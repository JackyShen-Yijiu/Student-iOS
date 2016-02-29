//
//  WMMenuViewController.m
//  QQSlideMenu
//
//  Created by wamaker on 15/6/12.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

#import "WMMenuViewController.h"
#import "WMMenuTableViewCell.h"
#import "WMCommon.h"
#import "UIImage+WM.h"
#import "WMOtherViewController.h"
#import "EditorDetailController.h"
@interface WMMenuViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) WMCommon *common;
@property (strong ,nonatomic) NSArray  *listArray;
@property (strong, nonatomic) NSArray *imgArray;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *userMobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *YLabel;

@end

@implementation WMMenuViewController
// 侧边栏顶部信息
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.YLabel.text = @"我的Y码：暂无";
    [self.tableView reloadData];
    
    [self setUpUserData];

}

- (void)setUpUserData
{
    
    if (![AcountManager isLogin]) {
        return;
    }
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[AcountManager manager].userHeadImageUrl] placeholderImage:[[UIImage imageNamed:@"coach_man_default_icon"] getRoundImage] completed:nil];
    // 用户名
    if ([AcountManager manager].userMobile) {
        
        self.userMobileLabel.text = [AcountManager manager].userMobile;
    }
    
    
    NSString *urlString = [NSString stringWithFormat:@"/userinfo/getmymoney?userid=%@&usertype=1", [AcountManager manager].userid];
    // 请求数据显示豆币相关信息
    [JENetwoking startDownLoadWithUrl:[NSString stringWithFormat:BASEURL,urlString] postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSLog(@"=== %@",data);
        NSDictionary *dict = data;
        if ([dict objectForKey:@"type"]) {
            NSDictionary *paramsDict = [dict objectForKey:@"data"];
            if (paramsDict) {
                NSString *fcode = [paramsDict objectForKey:@"fcode"];
                NSInteger couponcount = [[paramsDict objectForKey:@"couponcount"] integerValue];
                if (fcode && fcode.length) {
                    self.YLabel.text = [NSString stringWithFormat:@"我的Y码：%@", fcode];
                }
                
                [self.tableView reloadData];
                // 显示我的优惠券信息
                NSString *couponString = @"";
                if (couponcount) {
                    couponString = [NSString stringWithFormat:@"还有%li张兑换券(点击兑换)",couponcount];
                }
                //                self.headerView.coinCertificateLabel.text = couponString;
                // 存储兑换券
                [AcountManager manager].userCoinCertificate = couponcount;
            }
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.common = [WMCommon getInstance];
    
//    self.listArray = @[@"我的消息", @"活动", @"预约签到", @"我的驾校班车", @"我的钱包", @"我要投诉",@"一步优势",@"设置与帮助"];
//    
//    // 正常状态图片
//    self.imgArray = @[@"Slide_Menu_Message_Normal", @"Slide_Menu_Activity_Normal", @"Slide_Menu_SignUp_Normal", @"Slide_Menu_School_Normal", @"Slide_Menu_Money_Normal", @"Slide_Menu_Complaint_Normal",@"Slide_Menu_Advantage_Normal",@"Slide_Menu_Help_Normal"];
    
    self.listArray = @[@"优惠活动", @"我的钱包", @"我的消息", @"班车接收" ,@"预约签到",@"我要投诉",@"一步优势",@"设置与帮助"];
    
    // 正常状态图片
    self.imgArray = @[@"Slide_Menu_Activity_Normal", @"Slide_Menu_Money_Normal", @"Slide_Menu_Message_Normal", @"Slide_Menu_School_Normal", @"Slide_Menu_SignUp_Normal", @"Slide_Menu_Complaint_Normal",@"Slide_Menu_Advantage_Normal",@"Slide_Menu_Help_Normal"];
    
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight       = 44 * (self.common.screenW / 320);
    self.tableView.scrollEnabled = NO;
    // 设置tableFooterView为一个空的View，这样就不会显示多余的空白格子了
    self.tableView.tableFooterView = [[UIView alloc] init];

    
    // 设置头像
    self.headerImageView.image = [[UIImage imageNamed:@"coach_man_default_icon"] getRoundImage];
    [self.headerImageView.layer setMasksToBounds:YES];
    [self.headerImageView.layer setCornerRadius:28];
    self.headerImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(priateMessage:)];
    [self.headerImageView addGestureRecognizer:tapGesture];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(iconImage) name:kiconImage object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(iconImage) name:k object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setUpUserData) name:@"kuserLogin" object:nil];
    
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 当头像改变时通知方法
- (void)iconImage{
    if ([AcountManager manager].userHeadImageUrl) {
        
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[AcountManager manager].userHeadImageUrl] placeholderImage:[[UIImage imageNamed:@"coach_man_default_icon"] getRoundImage] completed:nil];
   
    }
}
// 点击头像手势
- (void)priateMessage:(UITapGestureRecognizer *)tapGesture{
    if ([self.iconDelegage respondsToSelector:@selector(didSelectIconImage:)]) {
        [self.delegate didSelectIconImage:tapGesture];
    }
}

#pragma mark - tableView代理方法及数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.09 * kSystemHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 没有用系统自带的类而用了自己重新定义的cell，仅仅为了之后扩展方便，无他
    WMMenuTableViewCell *cell = [WMMenuTableViewCell cellWithTableView:tableView];
    [cell setCellText:self.listArray[indexPath.row] withNormolImageStr:self.imgArray[indexPath.row]];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    WMOtherViewController *other = [[WMOtherViewController alloc] init];
//    other.navTitle = title;
//    other.hidesBottomBarWhenPushed = YES;
//    [self showHome];
//    [self.navigationController pushViewController:other animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(didSelectItem: indexPath:)]) {
        [self.delegate didSelectItem:self.listArray[indexPath.row] indexPath:(NSIndexPath *)indexPath];
    }
}

@end
