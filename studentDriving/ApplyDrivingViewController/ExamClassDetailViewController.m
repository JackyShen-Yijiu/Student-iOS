//
//  ExamClassDetailViewController.m
//  studentDriving
//
//  Created by bestseller on 15/11/3.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "ExamClassDetailViewController.h"
#import "ExamClassModel.h"
#import <SVProgressHUD.h>
#import "ExamDetailCell.h"
#import "SignUpInfoManager.h"
#import "NSString+CurrentTimeDay.h"
static NSString *const kexamClassDetail = @"driveschool/schoolclasstype/%@";
@interface ExamClassDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UILabel *headLabel;
@property (strong, nonatomic) UILabel *headDetailLabel;
@property (strong, nonatomic) UIImageView *locationImage;

@property (strong, nonatomic) UILabel *schoolIntroduction;
@property (strong, nonatomic) UILabel *schoolDetailIntroduction;
@end

@implementation ExamClassDetailViewController
- (UIImageView *)locationImage {
    if (_locationImage == nil) {
        _locationImage = [[UIImageView alloc] init];
        _locationImage.image = [UIImage imageNamed:@"locationImage.png"];
    }
    return _locationImage;
}
- (UILabel *)headLabel {
    if (_headLabel == nil) {
        _headLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont boldSystemFontOfSize:16]];
        _headLabel.text = self.model.schoolinfo.name;
    }
    return _headLabel;
}
- (UILabel *)headDetailLabel {
    if (_headDetailLabel == nil) {
        _headDetailLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
        _headDetailLabel.text = self.model.schoolinfo.address;
    }
    return _headDetailLabel;
}
- (UILabel *)schoolIntroduction {
    if (_schoolIntroduction == nil) {
        _schoolIntroduction = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont boldSystemFontOfSize:14]];
        _schoolIntroduction.text = @"驾校简介";
    }
    return _schoolIntroduction;
}
- (UILabel *)schoolDetailIntroduction {
    if (_schoolDetailIntroduction == nil) {
        _schoolDetailIntroduction = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
        _schoolDetailIntroduction.text = self.model.classdesc;
        _schoolDetailIntroduction.numberOfLines = 2;
    }
    return _schoolDetailIntroduction;
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kSystemWide, kSystemHeight-64)  style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    
    self.title = @"选择驾校";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];

    self.tableView.tableHeaderView = [self tableViewHeadView];
    
    self.tableView.tableFooterView = [self tableViewFootView];
    
    [self startDownLoad];
}
- (void)startDownLoad {
    NSString *url = [NSString stringWithFormat:kexamClassDetail,@"56163c376816a9741248b7f9"];
    NSString *urlString = [NSString stringWithFormat:BASEURL,url];
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        DYNSLog(@"data = %@",data);
    }];
}
- (UIView *)tableViewHeadView {
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 80)];
    backGroundView.backgroundColor = [UIColor whiteColor];
    [backGroundView addSubview:self.headLabel];
    [backGroundView addSubview:self.headDetailLabel];
    [backGroundView addSubview:self.locationImage];
    
    
    [self.headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(backGroundView.mas_top).offset(15);
    }];
    [self.locationImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.headLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(@20);
        make.height.mas_equalTo(@20);
    }];
    [self.headDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.locationImage.mas_right).offset(0);
        make.top.mas_equalTo(self.locationImage.mas_top).offset(0);
    }];
    
    return backGroundView;
}
- (UIView *)tableViewFootView {
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 80)];
    backGroundView.backgroundColor = [UIColor whiteColor];
    [backGroundView addSubview:self.schoolIntroduction];
    [backGroundView addSubview:self.schoolDetailIntroduction];
    
    [self.schoolIntroduction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(backGroundView.mas_top).offset(15);
    }];
   
    [self.schoolDetailIntroduction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.schoolIntroduction.mas_bottom).offset(15);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide-30];
        make.width.mas_equalTo(wide);
    }];
    
    return backGroundView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return 300;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        static NSString *cellId = @"cell";
        ExamDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[ExamDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    cell.schoolClassLabel.text = [NSString stringWithFormat:@"适用驾照类型:%@",self.model.carmodel.code];
    cell.timeLabel.text = [NSString stringWithFormat:@"活动日期:%@-%@",[NSString getLitteLocalDateFormateUTCDate:self.model.begindate],[NSString getLitteLocalDateFormateUTCDate:self.model.enddate]];
    cell.studyLabel.text = [NSString stringWithFormat:@"授课日程:%@",self.model.classchedule];
    cell.carType.text = [NSString stringWithFormat:@"训练车品牌:%@",self.model.cartype];
    cell.price.text = [NSString stringWithFormat:@"价格:%@元",self.model.price];
    cell.personCount.text = [NSString stringWithFormat:@"已经报名人数:%@",self.model.applycount];
    [cell receiveVipList:self.model.vipserverlist];

    return cell;
}

@end
