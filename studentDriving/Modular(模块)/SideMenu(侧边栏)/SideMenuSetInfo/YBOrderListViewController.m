//
//  YBOrderListViewController.m
//  studentDriving
//
//  Created by zyt on 16/2/24.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBOrderListViewController.h"
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
#import "DVVPaySuccessController.h"
#import "JZPayWayController.h"

#define StartOffset  kSystemWide/4-60/2

static NSString *const kgetapplyschoolinfo = @"userinfo/getapplyschoolinfo"; // 报名详情

static NSString *kCellIdentifier = @"userinfo/getmypayorder"; // 获取我的订单

@interface YBOrderListViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UIImageView*navBarHairlineImageView;
}

@property (strong, nonatomic) UITableView *tableView;


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
@property (nonatomic, strong) NSMutableDictionary *dict;

@property (nonatomic, strong) ShowWarningBG *warningBG; //提示背景图片
@property (nonatomic, strong) ShowWarningBG *mallBG;
@property (nonatomic, strong) NSMutableArray *dataListArray;

@property (nonatomic,strong) DVVNoDataPromptView *noCountentView;
@property (nonatomic,strong) DVVNoDataPromptView *mallView;

@end

@implementation YBOrderListViewController

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kSystemWide, kSystemHeight- 64) style:UITableViewStylePlain];
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
    
    self.dict = [NSMutableDictionary dictionary];
    
    self.title = @"报名信息";
    self.view.backgroundColor = RGBColor(226, 226, 233);
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];

    _dataListArray = [NSMutableArray array];
    
    self.noCountentView = [[DVVNoDataPromptView alloc] initWithTitle:@"没有找到您的订单信息，请确认您是否报名" image:[UIImage imageNamed:@"app_error_robot"] subTitle:nil];
    [self.view addSubview:self.noCountentView];
    
    if (self.isPaySuccess) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    }
    
}

-  (void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 隐藏导航条底部分割线
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden=YES;
    [self startDownLoad];
}
-(void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    navBarHairlineImageView.hidden=NO;
    
    [self.noCountentView removeFromSuperview];
    
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
    
    
    NSString *urlString = nil;
    NSDictionary *param = nil;
    
        // 获取报名详情
        urlString = [NSString stringWithFormat:BASEURL,kgetapplyschoolinfo];
        param = @{@"userid":[AcountManager manager].userid};
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:param WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        DYNSLog(@"data = %@",data);
        NSDictionary *param = data;
        NSError *error = nil;
        if (1 == [[data objectForKey:@"type"] integerValue]) {
            NSDictionary *data = param[@"data"];
                /***************************************************** 报名详情请求数据
                 {
                 data =     {
                 applyclasstypeinfo =         {
                 id = 562dd1fd1cdf5c60873625f3;
                 name = "\U4e00\U6b65\U4e92\U8054\U7f51\U9a7e\U6821\U5feb\U73ed";
                 onsaleprice = 4700;
                 price = 4700;
                 };
                 applycoachinfo =         {
                 id = 564227ec1eb4017436ade69c;
                 name = "\U91d1\U9f99";
                 };
                 applynotes = "";
                 applyschoolinfo =         {
                 id = 562dcc3ccb90f25c3bde40da;
                 name = "\U4e00\U6b65\U4e92\U8054\U7f51\U9a7e\U6821";
                 };
                 applystate = 2;
                 applytime = "2016-02-01";
                 carmodel =         {
                 code = C1;
                 modelsid = 1;
                 name = "\U5c0f\U578b\U6c7d\U8f66\U624b\U52a8\U6321";
                 };
                 endtime = "2016-03-01";
                 mobile = 15652305650;
                 name = "\U560e\U560e";
                 paytype = 1;
                 paytypestatus = 0;
                 scanauditurl = "http://api.yibuxueche.com/validation/applyvalidation?userid=564e1242aa5c58b901e4961a";
                 schoollogoimg = "http://7xnjg0.com1.z0.glb.clouddn.com/banner.jpg";
                 userid = 564e1242aa5c58b901e4961a;
                 };
                 msg = "";
                 type = 1;
                 }
                 申请状态请求数据
                 { "type": 1, "msg": "", "data":
                 
                 { "_id": "560539bea694336c25c3acb9", 用户id "applyinfo":
                 
                 {
                 "handelmessage": [], 处理消息
                 "handelstate": 0, //处理状态 0 未处理 1 处理中 2 处理成功
                 "applytime": "2015-10-11T02:56:09.281Z"
                 },
                 
                 "applystate": 2 申请状态 0 未报名 1 申请中 2 申请成功 "paytypestatus": 0, 0 未支付 20支付成功(等待验证) 30 支付失败
                 "paytype": 1, 1 线下支付， 2 线上支付
                 }
                 
                 }
                 */
                if (0 == [[data objectForKey:@"applystate"] integerValue]) {
                    
                    self.noCountentView.hidden = NO;
                    
                    return ;
                }
                
                self.noCountentView.hidden = YES;
                self.headerImageURl = [NSString stringWithFormat:@"%@",data[@"schoollogoimg"]];
                NSLog(@"%@",data[@"schoollogoimg"]);
                self.schoolStr = [NSString stringWithFormat:@"%@",[[data objectForKey:@"applyschoolinfo"] objectForKey:@"name"]];
                self.carModelStr = [NSString stringWithFormat:@"%@",[[data objectForKey:@"carmodel"] objectForKey:@"name"]];
                self.signUpStr = [NSString stringWithFormat:@"%@",[data objectForKey:@"applytime"]];
                
                self.realMoneyStr = [NSString stringWithFormat:@"%lu",[[[data objectForKey:@"applyclasstypeinfo"] objectForKey:@"onsaleprice"] integerValue]];
                self.classType = [[data objectForKey:@"applyclasstypeinfo"] objectForKey:@"name"];
                // 支付状态
                if (0 == [[data objectForKey:@"paytypestatus"] integerValue]) {
                    self.payStausStr = @"未支付";
                }else if (20 == [[data objectForKey:@"paytypestatus"] integerValue]) {
                    self.payStausStr = @"支付成功";
                }else if (30 == [[data objectForKey:@"paytypestatus"] integerValue]) {
                    self.payStausStr = @"支付失败";
                }
                // 支付方式
                if (1 == [[data objectForKey:@"paytype"] integerValue]) {
                    self.payWaystr = @"线下支付";
                } else if (2 == [[data objectForKey:@"paytype"] integerValue]) {
                    self.payWaystr = @"线上支付";
                }
                // 申请状态
                if (0 == [[data objectForKey:@"applystate"] integerValue]) {
                    self.applySatus = @"未报名";
                } else if(1 == [[data objectForKey:@"applystate"] integerValue]) {
                    self.applySatus = @"申请中";
                } else if (2 == [[data objectForKey:@"applystate"] integerValue]) {
                    self.applySatus = @"申请成功";
                }
            
            self.dict[@"headerUrl"] = self.headerImageURl;
            self.dict[@"schoolStr"] = self.schoolStr;
            self.dict[@"carModelStr"] = self.carModelStr;
            self.dict[@"signUpStr"] = self.signUpStr;
            self.dict[@"realMoneyStr"] = self.realMoneyStr;
            self.dict[@"payStausStr"] = self.payStausStr;
            self.dict[@"payWaystr"] = self.payWaystr;
            self.dict[@"applySatus"] = self.applySatus;
        
//
//            
//                self.dict = @{@"headerUrl":self.headerImageURl,
//                              @"schoolStr":self.schoolStr,
//                              @"carModelStr":self.carModelStr,
//                              @"signUpStr":self.signUpStr,
//                              @"realMoneyStr":self.realMoneyStr,
//                              @"payStausStr":self.payStausStr,
//                              @"payWaystr":self.payWaystr,
//                              @"applySatus":self.applySatus};
//                
                       [self.tableView reloadData];
            
        }
    } withFailure:^(id data) {
        
        
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 188;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 报名订单
    static NSString *cellId = @"Coach";
    SignUpDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[SignUpDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dict = self.dict;
    cell.didclickBlock = ^(NSInteger tag){
        if(401 == tag){
//            // 取消报名
//            [SignUpInfoManager removeSignData];
//            [AcountManager saveUserApplyState:@"0"];
//            //1为重新报名，0为报名
//            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//            [ud setObject:@"1" forKey:@"applyAgain"];
//            [ud synchronize];
//            [DVVUserManager userLoginSucces];


            NSString *message = [NSString stringWithFormat:@"您确定要取消报名%@吗?",[self.dict objectForKey:@"schoolStr"]];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"取消订单" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
            

//            // 取消订单
//            NSLog(@"%s",__func__);
//            NSString *url = [NSString stringWithFormat:kusercancelorder,[AcountManager manager].userid];
//            NSString *applyUrlString = [NSString stringWithFormat:BASEURL,url];
//            [JENetwoking startDownLoadWithUrl:applyUrlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
//                
//                NSString *type = [NSString stringWithFormat:@"%@",data[@"type"]];
//                
//                if ([type isEqualToString:@"1"]) {
//                    
//                    [self obj_showTotasViewWithMes:@"取消成功"];
//                    
//                    [self.navigationController popToRootViewControllerAnimated:YES];
//                    
//                }else{
//                    
//                    [self obj_showTotasViewWithMes:data[@"msg"]];
//                    
//                }
//                
//            } withFailure:^(id data) {
//                
//                
//            }];

            
        }else if(402 == tag){
            // 继续支付
//            OrdetDetailController *ordetVC = [[OrdetDetailController alloc] init];
//            ordetVC.schoolStr = self.schoolStr;
//            ordetVC.carModelStr = self.carModelStr;
//            ordetVC.signUpStr = self.signUpStr;
//            ordetVC.realMoneyStr = self.realMoneyStr;
//            ordetVC.payStausStr = self.payStausStr;
//            ordetVC.classType = self.classType;
//            [self.navigationController pushViewController:ordetVC animated:YES];
            
            // 跳转到选择支付界面
            NSDictionary *param = @{@"userid":[AcountManager manager].userid,
                                    @"orderstate":@"0"};
            //    NSString *appleStr = [NSString stringWithFormat:@"%@",kCellIdentifier,[AcountManager manager].userid];
            NSString *urlString = [NSString stringWithFormat:BASEURL,kCellIdentifier];
            [JENetwoking startDownLoadWithUrl:urlString postParam:param WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
                NSDictionary *param = data;
                
                NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
                
                if ([type isEqualToString:@"1"]){
                    /*
                     {
                     data =     (
                     {
                     "_id" = 56d8fa833947daad595e5a53;
                     activitycoupon = "";
                     applyclasstypeinfo =             {
                     id = 56aecf9b70667d997fda6247;
                     name = "\U6d4b\U8bd5\U73ed\U578b \U8df3\U697c\U4ef7";
                     onsaleprice = 1;
                     price = 1;
                     };
                     applyschoolinfo =             {
                     id = 562dcc3ccb90f25c3bde40da;
                     name = "\U4e00\U6b65\U4e92\U8054\U7f51\U9a7e\U6821";
                     };
                     couponcode = "";
                     creattime = "2016-03-04T03:01:23.453Z";
                     discountmoney = 0;
                     paychannel = 0;
                     payendtime = "2016-03-07T03:01:23.453Z";
                     paymoney = 1;
                     userpaystate = 0;
                     }
                     );
                     msg = "";
                     type = 1;
                     }
                     */
    
                    
                    
                    // push界面需要的字典类型
                   /* {
                        "type": 1,
                        "msg": "",
                        "data": "success",
                        "extra": {
                            "__v": 0,
                            "paymoney": 4700,
                            //支付金额"payendtime": "2016-02-03T12:29:49.423Z",
                            "creattime": "2016-01-31T12:29:49.423Z",
                            "userid": "564e1242aa5c58b901e4961a",
                            "_id": "56adfe3d323ed17278e71914",
                            订单id"discountmoney": 0,
                            "applyclasstypeinfo": {
                                "onsaleprice": 4700,
                                "price": 4700,
                                "name": "一步互联网驾校快班",
                                "id": "562dd1fd1cdf5c60873625f3"
                            },
                            "applyschoolinfo": {
                                "name": "一步互联网驾校",
                                "id": "562dcc3ccb90f25c3bde40da"
                            },
                            "paychannel": 0,
                            userpaystate": 0订单状态//0订单生成1开始支付2支付成功3支付失败4订单取消 //支付方式"
                        }
                    }
                    */
                    NSDictionary *dict =  [param[@"data"] firstObject];

                    JZPayWayController *payWayVC= [[JZPayWayController alloc] init];
                    payWayVC.extraDict =  dict;
                    if (_isFormallOrder) {
                        [self.pareVC.navigationController pushViewController:payWayVC animated:YES];
                    }else{
                        [self.navigationController pushViewController:payWayVC animated:YES];
                    }
                    
                    
                    
            }
                
            } withFailure:^(id data) {
                
            }];

            
            
            
            
            
            
            
            
        }
    };
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
// 当为线下报名，并且状态为1时，点击cell进入扫描功能
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.payWaystr isEqualToString:@"线下支付"] && [self.applySatus isEqualToString:@"申请中"]) {
        // 跳转到扫描界面
        YBSignUpSuccessController *signUpVC = [[YBSignUpSuccessController alloc] init];
        if (_isFormallOrder) {
            [self.pareVC.navigationController pushViewController:signUpVC animated:YES];
        }else{
            [self.navigationController pushViewController:signUpVC animated:YES];
        }
        
}
    if ([self.payWaystr isEqualToString:@"线下支付"] && [self.applySatus isEqualToString:@"申请成功"]) {
        // 跳转到线下报名成功界面
        DVVPaySuccessController *vc = [DVVPaySuccessController new];
        vc.isPaySuccess = YES;
        if (_isFormallOrder) {
            [self.pareVC.navigationController pushViewController:vc animated:YES];
        }else{
            [self.navigationController pushViewController:vc animated:YES];
        }

    }
    if ([self.payWaystr isEqualToString:@"线上支付"] && [self.payStausStr isEqualToString:@"支付成功"]) {
        // 跳转到线上报名成界面
        DVVPaySuccessController *vc = [DVVPaySuccessController new];
        vc.isPaySuccess = YES;
        
        if (_isFormallOrder) {
            [self.pareVC.navigationController pushViewController:vc animated:YES];
        }else{
            [self.navigationController pushViewController:vc animated:YES];
        }

    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==1) {
        
        NSLog(@"%s",__func__);
        NSString *url = [NSString stringWithFormat:kusercancelorder,[AcountManager manager].userid];
        NSString *applyUrlString = [NSString stringWithFormat:BASEURL,url];
        [JENetwoking startDownLoadWithUrl:applyUrlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
            
            NSString *type = [NSString stringWithFormat:@"%@",data[@"type"]];
            
            if ([type isEqualToString:@"1"]) {
                
                [self obj_showTotasViewWithMes:@"取消成功"];
                
                if (_isFormallOrder) {
                    [self.pareVC.navigationController.navigationController popToRootViewControllerAnimated:YES];
                }else{
                    [self.parentViewController.navigationController popToRootViewControllerAnimated:YES];
                }
                
                
            }else{
                
                
                
                [self obj_showTotasViewWithMes:data[@"msg"]];
                
            }
            
        } withFailure:^(id data) {
            
            
        }];
        
    }
    
}

@end
