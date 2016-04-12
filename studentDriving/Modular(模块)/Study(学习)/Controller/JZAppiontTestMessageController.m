//
//  JZAppiontTestMessageController.m
//  studentDriving
//
//  Created by ytzhang on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZAppiontTestMessageController.h"
#import "JZAppiontMessageTopCell.h"
#import "JZAppiontMessageBottomCell.h"

@interface JZAppiontTestMessageController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *toptitleArray;

@property (nonatomic, strong) NSArray *topdesArray;

@property (nonatomic, strong) NSArray *bottomTitleArray;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *topLabel;

@property (nonatomic, strong) UILabel *bottomLabel;

@property (nonatomic, strong) UIButton *appiontButton;



@end

@implementation JZAppiontTestMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.title = @"驾校代约";
    self.view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    [self.bgView addSubview:self.topLabel];
    [self.bgView addSubview:self.bottomLabel];
    self.tableView.tableFooterView = self.bgView;
    [self.view addSubview:self.appiontButton];
    [self initData];
    
}
- (void)initData{
    self.toptitleArray = @[@"姓名",@"电话",@"考试原因"];
    
    self.bottomTitleArray = @[@"开始时间",@"至",@"结束时间"];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (0 == section) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 10)];
        view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
        return view;
    }
    if (1 == section) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 40)];
        view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 200, 40)];
        label.text = @"预约考试起止时间";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = JZ_FONTCOLOR_DRAK;
        [view addSubview:label];
        return view;
    }
    return nil;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (0 == section) {
        return 10;
    }
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (1 == indexPath.section && 1 == indexPath.row) {
        return 33;
    }
    return 44;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        static NSString *IDexchange = @"ecchangeID";
        JZAppiontMessageTopCell *cell = [tableView dequeueReusableCellWithIdentifier:IDexchange];
        if (!cell) {
            cell = [[JZAppiontMessageTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDexchange];
        }
        cell.titleLabel.text = self.toptitleArray[indexPath.row];
        
        return cell;
        
    }
    if (1 == indexPath.section) {
            static NSString *IDnumber = @"numberID";
            JZAppiontMessageBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:IDnumber];
            if (!cell) {
                cell = [[JZAppiontMessageBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDnumber];
            }
        if (1 == indexPath.row) {
            cell.textField.backgroundColor = RGB_Color(249, 249, 249);
            cell.textField.userInteractionEnabled = NO;
        }
        cell.textField.placeholder = self.bottomTitleArray[indexPath.row];
            return cell;
    
     
    }
    
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma  mark -- Action 申请预约
- (void)appointSchool:(UIButton *)btn{
//    JZAppiontTestMessageController * appiontTestVC  = [[JZAppiontTestMessageController alloc] init];
//    [self.navigationController pushViewController:appiontTestVC animated:YES];
}

#pragma mark --- Lazy加载
- (UITableView *)tableView
{
    if (_tableView == nil ) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kSystemWide , kSystemHeight - 64 ) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 200)];
        _bgView.backgroundColor = [UIColor clearColor];
    }
    return _bgView;
}
- (UILabel *)topLabel{
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 16, kSystemWide - 2 * 16, 30)];
        _topLabel.text = @"选择驾校代约后,您所报考的驾校将收到您提交的约考信息并统一帮您约考,您不必在自行去122网站约考";
        _topLabel.font = [UIFont systemFontOfSize:12];
        _topLabel.textColor = JZ_FONTCOLOR_LIGHT;
        _topLabel.numberOfLines = 0;
    }
    return _topLabel;
}
- (UILabel *)bottomLabel{
    if (_bottomLabel == nil) {
        _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(self.topLabel.frame) + 5, kSystemWide - 2 * 16, 30)];
        _bottomLabel.text = @"若您已自行子在122网站提交约考信息,就不必在这里提交代约信息";
        _bottomLabel.font = [UIFont systemFontOfSize:12];
        _bottomLabel.textColor = JZ_FONTCOLOR_LIGHT;
        _bottomLabel.numberOfLines = 0;
    }
    return _bottomLabel;
}
- (UIButton *)appiontButton{
    if (_appiontButton == nil) {
        _appiontButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat marginW = 16;
        CGFloat H = 44;
        _appiontButton.frame = CGRectMake(marginW, kSystemHeight - marginW - H - 64, kSystemWide - 2 * marginW , H);
        [_appiontButton setTitle:@"申请预约" forState:UIControlStateNormal];
        _appiontButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_appiontButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _appiontButton.backgroundColor = YBNavigationBarBgColor;
        [_appiontButton addTarget:self action:@selector(appointSchool:) forControlEvents:UIControlEventTouchUpInside];
        _appiontButton.layer.masksToBounds = YES;
        _appiontButton.layer.cornerRadius = 4;
    }
    return _appiontButton;
}

@end
