//
//  MallOrderController.m
//  studentDriving
//
//  Created by ytzhang on 16/3/1.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "MallOrderController.h"

#import "UIDevice+JEsystemVersion.h"
#import "UIView+CalculateUIView.h"
#import "CoachTableViewCell.h"
#import "DrivingCell.h"
#import "CoachModel.h"
#import "DrivingModel.h"
//#import "DrivingDetailController.h"
#import "JGDrivingDetailViewController.h"
#import "SignUpInfoManager.h"
#import "BLPFAlertView.h"
#import "SignUpDetailCell.h"
#import "MallOrderCell.h"
#import "ShowWarningBG.h"
#import "MallOrderListModel.h"
#import "YYModel.h"
#import "YBMyWalletMallViewController.h"
#import "YBSignUpSuccessController.h"
#import "OrdetDetailController.h"
#import "DVVNoDataPromptView.h"


#define StartOffset  kSystemWide/4-60/2

static NSString *const kgetMallList = @"userinfo/getmyorderlist"; // 商品订单


typedef NS_ENUM(NSUInteger,MyLoveState){
    MyLoveStateCoach,
    MyLoveStateDriving
};

@interface MallOrderController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView*navBarHairlineImageView;
}

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) UIView *menuIndicator;
@property (assign, nonatomic) MyLoveState myLoveState;
@property (strong, nonatomic) NSMutableArray *dataArray;


@property (strong, nonatomic) CoachModel *coachDetailModel;
@property (strong, nonatomic) DrivingModel *drivingDetailModel;

@property (nonatomic, strong) NSString *headerImageURl; // 驾校头像
@property (nonatomic, strong) NSString *payWaystr; // 支付方式
@property (nonatomic, strong) NSString *schoolStr; // 驾校姓名
@property (nonatomic, strong) NSString *carModelStr; // 班型
@property (nonatomic, strong) NSString *signUpStr; // 报名时间
@property (nonatomic, strong) NSString *realMoneyStr; // 实付款
@property (nonatomic, strong) NSString *payStausStr; // 支付状态
@property (nonatomic, strong) NSString *applySatus; // 申请状态
@property (nonatomic, strong) NSString *classType;
@property (nonatomic, strong) NSDictionary *dict;

@property (nonatomic, strong) ShowWarningBG *warningBG; //提示背景图片
@property (nonatomic, strong) ShowWarningBG *mallBG;
@property (nonatomic, strong) NSMutableArray *dataListArray;

@property (nonatomic,strong) DVVNoDataPromptView *p;
@property (nonatomic,strong) DVVNoDataPromptView *mallView;

@end

@implementation MallOrderController

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (UIView *)menuIndicator {
    if (_menuIndicator == nil) {
        _menuIndicator = [[UIView alloc] initWithFrame:CGRectMake(0,40-2, kSystemWide / 2, 2)];
        _menuIndicator.backgroundColor = [UIColor yellowColor];
    }
    return _menuIndicator;
}
- (NSMutableArray *)buttonArray {
    if (_buttonArray == nil ) {
        _buttonArray = [[NSMutableArray alloc] init];
    }
    return _buttonArray;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kSystemWide, kSystemHeight- 64 ) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的订单";
    self.view.backgroundColor = RGBColor(249, 249, 249);
    self.automaticallyAdjustsScrollViewInsets = NO;
    _myLoveState = MyLoveStateDriving;
    [self.view addSubview:self.tableView];
    _dataListArray = [NSMutableArray array];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 隐藏导航条底部分割线
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden=YES;
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self startDownLoad];
}
-(void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    navBarHairlineImageView.hidden=NO;
    
    [self.p removeFromSuperview];
    
}

- (UIImageView*)findHairlineImageViewUnder:(UIView*)view {
    
    if([view isKindOfClass:UIImageView.class] && view.bounds.size.height<=1.0) {
        return(UIImageView*)view;
    }
    for(UIView*subview in view.subviews) {
        UIImageView*imageView = [self findHairlineImageViewUnder:subview];
        if(imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)startDownLoad {
    
    //    [self.dataArray removeAllObjects];
    
    NSString *urlString = nil;
    NSDictionary *param = nil;
    
          // 获取商品订单
        urlString = [NSString stringWithFormat:BASEURL,kgetMallList];
        param = @{@"userid": [AcountManager manager].userid,
                  @"index":@"1",
                  @"count":@"10"};
   
    [JENetwoking startDownLoadWithUrl:urlString postParam:param WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        DYNSLog(@"data = %@",data);
        NSDictionary *param = data;
        NSError *error = nil;
        if (1 == [[data objectForKey:@"type"] integerValue]) {
            NSDictionary *data = param[@"data"];
                NSArray *array = data[@"ordrelist"];
                if (!array.count) {
                    self.mallView = [[DVVNoDataPromptView alloc] initWithTitle:@"小步没有找到您的订单信息，请前往商城购买" image:[UIImage imageNamed:@"app_error_robot"] subTitle:nil];
                    [self.view addSubview:self.mallView];
                    return ;
                    
                }
                
                
                [_dataListArray removeAllObjects];
                for (NSDictionary *dic in array) {
                    MallOrderListModel *listModel = [MallOrderListModel yy_modelWithDictionary:dic];
                    [_dataListArray addObject:listModel];
                }
                
                NSLog(@"-----------------------------========================================%@",_dataListArray);
            [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }
    } withFailure:^(id data) {
        
        
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_myLoveState == MyLoveStateCoach) {
        return 150.0f;
    }else if (_myLoveState == MyLoveStateDriving) {
        return 125.0f;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_myLoveState == MyLoveStateCoach) {
        return 1;
    }else if (_myLoveState == MyLoveStateDriving) {
        return _dataListArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof (self) ws = self;
    
     if (_myLoveState == MyLoveStateDriving) {
        // 兑换商品订单
        static NSString *cellId = @"Driving";
        MallOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[MallOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            
        }
        cell.listModel = _dataListArray[indexPath.row];
        cell.didclickBlock = ^(NSInteger tag){
            YBMyWalletMallViewController *mallVC = [[YBMyWalletMallViewController alloc] init];
            [ws.navigationController pushViewController:mallVC animated:YES];
        };
        return cell;
        
    }
    
    return nil;
}
// 当为线下报名，并且状态为1时，点击cell进入扫描功能
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.payWaystr isEqualToString:@"线下支付"] && [self.applySatus isEqualToString:@"申请中"]) {
        // 跳转到扫描界面
        YBSignUpSuccessController *signUpVC = [[YBSignUpSuccessController alloc] init];
        
        [self.navigationController pushViewController:signUpVC animated:YES];
    }
}
@end
