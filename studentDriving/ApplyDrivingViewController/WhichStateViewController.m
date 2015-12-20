//
//  WhichStateViewController.m
//  studentDriving
//
//  Created by 胡东苑 on 15/12/17.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "WhichStateViewController.h"
#import "SignUpInfoManager.h"
#import <SVProgressHUD.h>

@interface WhichStateViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *WMSelectedbackGroundView;
@property (nonatomic, strong) NSArray     *dataArr;
@property (strong, nonatomic) UIButton *naviBarRightButton;
@property (nonatomic, strong) NSString *selectedContent;
@property (nonatomic, strong) NSString *selectedindex;

@end

@implementation WhichStateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.view.backgroundColor = RGBColor(245, 247, 250);
    self.automaticallyAdjustsScrollViewInsets = NO;
    _dataArr = @[@"科目一",@"科目二",@"科目三",@"科目四"];
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 74, kSystemWide, kSystemHeight-64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        UIView *view = [[UIView alloc] init];
        _tableView.tableFooterView = view;
    }
    return _tableView;
}
- (UIButton *)naviBarRightButton {
    if (_naviBarRightButton == nil) {
        _naviBarRightButton = [WMUITool initWithTitle:@"完成" withTitleColor:MAINCOLOR withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarRightButton.frame = CGRectMake(0, 0, 44, 44);
        [_naviBarRightButton addTarget:self action:@selector(clickRight:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBarRightButton;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yy"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"yy"];
        _WMSelectedbackGroundView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, kSystemWide-20, 70)];
        _WMSelectedbackGroundView.backgroundColor = [UIColor whiteColor];
        _WMSelectedbackGroundView.layer.borderColor = MAINCOLOR.CGColor;
        _WMSelectedbackGroundView.layer.borderWidth = 2;
        UIImageView *selectedImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellSelected.png"]];
        [_WMSelectedbackGroundView addSubview:selectedImage];
        [selectedImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_WMSelectedbackGroundView.mas_right).offset(0);
            make.top.mas_equalTo(_WMSelectedbackGroundView.mas_top).offset(0);
            make.height.mas_equalTo(@30);
            make.width.mas_equalTo(@30);
        }];
        cell.selectedBackgroundView = self.WMSelectedbackGroundView;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = _dataArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedContent = self.dataArr[indexPath.row];
    _selectedindex = [NSString stringWithFormat:@"%zd",indexPath.row +1];
}

- (void)clickRight:(UIButton *)sender {
    if (_selectedContent) {
        NSDictionary *param = @{@"name":_selectedContent,@"subject":_selectedindex};
        [SignUpInfoManager signUpInfoSaveRealSubjectID:param];
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [SVProgressHUD showErrorWithStatus:@"请选择阶段"];
    }
    
    
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
