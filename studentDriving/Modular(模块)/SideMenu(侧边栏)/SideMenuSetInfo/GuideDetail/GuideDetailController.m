//
//  GuideDetailController.m
//  studentDriving
//
//  Created by ytzhang on 16/2/29.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "GuideDetailController.h"
#import "DuideDetailCell.h"

@interface GuideDetailController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, strong) UIImageView *imgHeardView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *desArray;

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *addressLabel;


@end

@implementation GuideDetailController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"使用指南";
    self.view.backgroundColor = [UIColor whiteColor];
    //头部视图
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.imgHeardView;
    // 尾部视图
    [self.bgView addSubview:self.phoneLabel];
    [self.bgView addSubview:self.addressLabel];
    self.tableView.tableFooterView = self.bgView;
    
    [self initData];
    
}
- (void)initData{
    self.titleArray = @[@"1、注册报名:",@"2、预约练车:",@"3、教练评价:",@"4、取消预约:",@"5、报名缴费:"];
    self.desArray = @[@"  APP下载安装完成后，按照流程填写验证手机号进行注册，注册完成后点击“报名”，在页面中通过筛选驾校和教练选择自己满意的驾校并进行报名。",
                      @"  进入极致驾服APP预约页面，选择报名时的教练或驾校分配的教练进行预约（如果不知道教练可以致电所报驾校和极致客服为您查询）。最早可以提前预约一周的课程，并根据所报驾校的最少预约时间单位预约课程（理论最小预约时间为1小时），预约时间必须连续。学员预约课程后，需按时间到达练车场地并与教练签到后方可练车。",
                      @"  学时结束后，根据教练的表现，必须通过极致驾服APP对驾校和教练进行评价。如果本节课程没有评价，用户在下次启动APP、预约、签到时都会弹出评价界面。如过学员在学车过程中发现不满意可投诉驾校和教练，同时极致驾服客服中心将根据学员投诉，为学员营造快乐的学车之旅。",
                      @"  根据驾校的取消预约时间规定，学员可以进入极致驾服APP“预约”中查看已经预约的学时，如需要取消预约，点击预约订单在详情中取消预约并填写取消原因即可。需要注意取消预约截止的时间依据驾校规定",
                      @"  线上支付：注册报名费用可通过APP利用支付宝和微信支付直接缴费。线下支付：需要用户报名成功后，凭订单二维码至当地驾校办公室进行现金缴费。"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.row) {
        return 80;
    }
    if (1 == indexPath.row) {
        return 120;
    }
    if (2 == indexPath.row) {
        return 100;
    }
    if (3 == indexPath.row) {
        return 95;
    }
    if (4 == indexPath.row) {
        return 80;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = @"DetailID";
    DuideDetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!detailCell) {
        detailCell = [[DuideDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    detailCell.backgroundColor = [UIColor clearColor];
    detailCell.titleLabel.text = self.titleArray[indexPath.row];
    detailCell.deTextView.text = self.desArray[indexPath.row];
    detailCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return detailCell;
}
#pragma mark ----- Lazy加载
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGBColor(249, 249, 249);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (UIImageView *)imgHeardView{
    if (_imgHeardView == nil) {
        _imgHeardView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 150)];
        _imgHeardView.image = [UIImage imageNamed:@"Help_DetailHeader"];
    }
    return _imgHeardView;
}
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 50)];
        _bgView.backgroundColor = [UIColor clearColor];
    }
    return _bgView;
}
- (UILabel *)phoneLabel{
    if (_phoneLabel == nil) {
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 14)];
        _phoneLabel.text = @"客服电话:400-626-9255";
        _phoneLabel.font = [UIFont systemFontOfSize:14];
        _phoneLabel.textColor = [UIColor colorWithHexString:@"212121"];
        
    }
    return _phoneLabel;
}
- (UILabel *)addressLabel{
    if (_addressLabel == nil) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 19, 270, 14)];
        _addressLabel.text = @"地址:北京市海淀区中关村E世界财富广场";
        _addressLabel.font = [UIFont systemFontOfSize:14];
        _addressLabel.textColor = [UIColor colorWithHexString:@"212121"];
        
    }
    return _addressLabel;
}

@end
