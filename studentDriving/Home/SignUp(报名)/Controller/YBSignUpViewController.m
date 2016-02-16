//
//  YBSignUpViewController.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBSignUpViewController.h"
#import "DVVLocation.h"
#import "DVVSelectCityController.h"
#import "DVVSignUpToolBarView.h"
#import "DVVSignUpSchoolCell.h"
#import "DVVSignUpCoachCell.h"

static NSString *schoolCellID = @"schoolCellID";
static NSString *coachCellID = @"coachCellID";

@interface YBSignUpViewController ()<UITableViewDataSource, UITableViewDelegate>

// 当前显示的是驾校还是教练（0：驾校  1：教练）
@property (nonatomic, assign) BOOL showType;

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIButton *titleLeftButton;
@property (nonatomic, strong) UIButton *titleRightButton;
@property (nonatomic, strong) UILabel *titleLabel;
// 定位
@property (nonatomic, strong) UILabel *locationLabel;

@property (nonatomic, strong) DVVSignUpToolBarView *toolBarView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *schoolDataArray;
@property (nonatomic, strong) NSMutableArray *coachDataArray;

@end

@implementation YBSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = NO;
    
    [self.view addSubview:self.titleView];
    [_titleView addSubview:self.titleLeftButton];
    [_titleView addSubview:self.titleRightButton];
    [_titleView addSubview:self.titleLabel];
    self.navigationItem.titleView = _titleView;
    UIBarButtonItem *rightBBI = [[UIBarButtonItem alloc] initWithCustomView:self.locationLabel];
    self.navigationItem.rightBarButtonItem = rightBBI;
    [self.view addSubview:self.toolBarView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGSize size = self.view.bounds.size;
    _toolBarView.frame = CGRectMake(0, 0, size.width, 44);
    
    _titleView.backgroundColor = [UIColor redColor];
    _titleLeftButton.backgroundColor = [UIColor orangeColor];
    _titleRightButton.backgroundColor = [UIColor orangeColor];
    
    _toolBarView.backgroundColor = [UIColor redColor];
}

#pragma mark - action
#pragma mark 选驾校或者选教练
- (void)selectSchoolOrCoachAction {
    
    // 根据当前的状态来判断是显示驾校还是教练
    if (0 == _showType) {
        _showType = 1;
        _titleLabel.text = @"教练";
    }else {
        _showType = 0;
        _titleLabel.text = @"驾校";
    }
}
#pragma mark 右上角定位按钮
- (void)locationLabelAction {
    
    DVVSelectCityController *vc = [DVVSelectCityController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - table delegate datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == _showType) {
        return _schoolDataArray.count;
    }else {
        return _coachDataArray.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == _showType) {
        return 100;
    }else {
        return 100;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == _showType) {
        DVVSignUpSchoolCell *schoolCell = [tableView dequeueReusableCellWithIdentifier:schoolCellID];
        return schoolCell;
    }else {
        DVVSignUpCoachCell *coachCell = [tableView dequeueReusableCellWithIdentifier:coachCellID];
        return coachCell;
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == _showType) {
        DVVSignUpSchoolCell *schoolCell = (DVVSignUpSchoolCell *)cell;
    }else {
        DVVSignUpCoachCell *coachCell = (DVVSignUpCoachCell *)cell;
    }
}

#pragma mark - lazy load
- (UIView *)titleView {
    if (!_titleView) {
        _titleView = [UIView new];
        _titleView.frame = CGRectMake(0, 0, 44 * 2 + 40, 44);
    }
    return _titleView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"驾校";
        _titleLabel.frame = CGRectMake(0, 0, 44 * 2 + 40, 44);
    }
    return _titleLabel;
}
- (UIButton *)titleLeftButton {
    if (!_titleLeftButton) {
        _titleLeftButton = [UIButton new];
        _titleLeftButton.frame = CGRectMake(0, 0, 44, 44);
        [_titleLeftButton addTarget:self action:@selector(selectSchoolOrCoachAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleLeftButton;
}
- (UIButton *)titleRightButton {
    if (!_titleRightButton) {
        _titleRightButton = [UIButton new];
        _titleRightButton.frame = CGRectMake(44 + 40, 0, 44, 44);
        [_titleRightButton addTarget:self action:@selector(selectSchoolOrCoachAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleRightButton;
}

- (UILabel *)locationLabel {
    if (!_locationLabel) {
        _locationLabel = [UILabel new];
        _locationLabel.textAlignment = NSTextAlignmentRight;
        _locationLabel.textColor = [UIColor whiteColor];
        _locationLabel.text = @"定位中";
        _locationLabel.font = [UIFont systemFontOfSize:12];
        _locationLabel.frame = CGRectMake(0, 0, 70, 44);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(locationLabelAction)];
        [_locationLabel addGestureRecognizer:tap];
        _locationLabel.userInteractionEnabled = YES;
    }
    return _locationLabel;
}

- (DVVSignUpToolBarView *)toolBarView {
    if (!_toolBarView) {
        _toolBarView = [DVVSignUpToolBarView new];
        _toolBarView.titleArray = @[ @"评分", @"价格", @"综合" ];
    }
    return _toolBarView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView= [UITableView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[DVVSignUpSchoolCell class] forCellReuseIdentifier:schoolCellID];
        [_tableView registerClass:[DVVSignUpCoachCell class] forCellReuseIdentifier:coachCellID];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
