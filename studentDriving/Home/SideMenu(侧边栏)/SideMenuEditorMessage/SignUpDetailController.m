//
//  SignUpDetailController.m
//  studentDriving
//
//  Created by zyt on 16/2/24.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "SignUpDetailController.h"
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


#define StartOffset  kSystemWide/4-60/2

static NSString *const kinfomationCheck = @"userinfo/getapplyschoolinfo"; // 报名详情
static NSString *const kGetMySaveCoach = @"userinfo/favoritecoach";

static NSString *const kGetMySaveSchool = @"userinfo/favoriteschool";

static NSString *const kDeleteMySaveCoach = @"userinfo/favoritecoach";

static NSString *const kDeleteMySaveSchool = @"userinfo/favoriteschool";

typedef NS_ENUM(NSUInteger,MyLoveState){
    MyLoveStateCoach,
    MyLoveStateDriving
};

@interface SignUpDetailController ()<UITableViewDataSource,UITableViewDelegate>
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
@property (nonatomic, strong) NSDictionary *dict;
@end

@implementation SignUpDetailController

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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,40, kSystemWide, kSystemHeight- 64 - 40) style:UITableViewStylePlain];
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
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _myLoveState = MyLoveStateCoach;
    [self.view addSubview:self.tableView];
    [self.view addSubview:[self tableViewHeadView]];
    
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
    
    if (_myLoveState == MyLoveStateCoach) {
        // 获取报名详情
        urlString = [NSString stringWithFormat:BASEURL,kinfomationCheck];
    }else if (_myLoveState == MyLoveStateDriving) {
        // 获取商品订单
        urlString = [NSString stringWithFormat:BASEURL,kGetMySaveSchool];
    }
    NSDictionary *param = @{@"userid":[AcountManager manager].userid};
    [JENetwoking startDownLoadWithUrl:urlString postParam:param WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        DYNSLog(@"data = %@",data);
        NSDictionary *param = data;
        NSError *error = nil;
        if (1 == [[data objectForKey:@"type"] integerValue]) {
            NSDictionary *data = param[@"data"];
            if (_myLoveState == MyLoveStateCoach) {
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

                
                self.headerImageURl = data[@"schoollogoimg"];
                NSLog(@"%@",data[@"schoollogoimg"]);
                self.schoolStr = [[data objectForKey:@"applyschoolinfo"] objectForKey:@"name"];
                self.carModelStr = [[data objectForKey:@"carmodel"] objectForKey:@"name"];
                self.signUpStr = [data objectForKey:@"applytime"];
                
                self.realMoneyStr = [NSString stringWithFormat:@"%lu",[[[data objectForKey:@"applyclasstypeinfo"] objectForKey:@"onsaleprice"] integerValue]];
                // 支付状态
                if (0 == [[data objectForKey:@"paytypestatus"] integerValue]) {
                self.payStausStr = @"未支付";
                }else if (1 == [[data objectForKey:@"paytypestatus"] integerValue]) {
                    self.payStausStr = @"支付成功";
                }else if (2 == [[data objectForKey:@"paytypestatus"] integerValue]) {
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
                self.dict = @{@"headerUrl":self.headerImageURl,
                                       @"schoolStr":self.schoolStr,
                                       @"carModelStr":self.carModelStr,
                                       @"signUpStr":self.signUpStr,
                                       @"realMoneyStr":self.realMoneyStr,
                                       @"payStausStr":self.payStausStr,
                                       @"payWaystr":self.payWaystr,
                                    @"applySatus":self.applySatus};
                
            }else if (_myLoveState == MyLoveStateDriving) {
//                [self.dataArray addObjectsFromArray:[MTLJSONAdapter modelsOfClass:DrivingModel.class fromJSONArray:param[@"data"] error:&error]];
            }
           [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }
    } withFailure:^(id data) {
        
    }];
    
}
- (UIView *)tableViewHeadView {
    // 背景
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 40)];
    backGroundView.backgroundColor = YBNavigationBarBgColor;
    backGroundView.layer.shadowColor = RGBColor(204, 204, 204).CGColor;
    backGroundView.layer.shadowOffset = CGSizeMake(0, 1);
    backGroundView.layer.shadowOpacity = 0.5;
    backGroundView.userInteractionEnabled = YES;
    // 报名订单
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:@"报名订单" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor colorWithHexString:@"f4c7c3"] forState:UIControlStateNormal];
    leftButton.selected = YES;
    [leftButton addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [backGroundView addSubview:leftButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backGroundView.mas_left).offset(0);
        make.top.mas_equalTo(backGroundView.mas_top).offset(0);
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide/2];
        make.width.mas_equalTo(height);
        make.height.mas_equalTo(@40);
    }];
    [self.buttonArray addObject:leftButton];
    // 兑换商品订单
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"兑换商品订单" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor colorWithHexString:@"f4c7c3"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [backGroundView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(backGroundView.mas_right).offset(0);
        make.top.mas_equalTo(backGroundView.mas_top).offset(0);
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide/2];
        make.width.mas_equalTo(height);
        make.height.mas_equalTo(@40);
    }];
    [self.buttonArray addObject:rightButton];
    
    [backGroundView addSubview:self.menuIndicator];
    
    return backGroundView;
}
#pragma mark - bntAciton
- (void)clickLeftBtn:(UIButton *)sender {
    for (UIButton *b in self.buttonArray) {
        b.selected = NO;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.menuIndicator.frame = CGRectMake(0, self.menuIndicator.calculateFrameWithY, self.menuIndicator.calculateFrameWithWide, self.menuIndicator.calculateFrameWithHeight);
    }];
    sender.selected = YES;
    _myLoveState = MyLoveStateCoach;
    [self startDownLoad];
}
- (void)clickRightBtn:(UIButton *)sender {
    for (UIButton *b in self.buttonArray) {
        b.selected = NO;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.menuIndicator.frame = CGRectMake(kSystemWide/2, self.menuIndicator.calculateFrameWithY, self.menuIndicator.calculateFrameWithWide, self.menuIndicator.calculateFrameWithHeight);
    }];
    sender.selected = YES;
    _myLoveState = MyLoveStateDriving;
    [self startDownLoad];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_myLoveState == MyLoveStateCoach) {
        return 150.0f;
    }else if (_myLoveState == MyLoveStateDriving) {
        return 150.0f;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_myLoveState == MyLoveStateCoach) {
        return 1;
    }else if (_myLoveState == MyLoveStateDriving) {
        return 2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (_myLoveState == MyLoveStateCoach) {
        static NSString *cellId = @"Coach";
        SignUpDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[SignUpDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            //            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.dict = self.dict;
        cell.didclickBlock = ^(NSInteger tag){
            if (400 == tag) {
                // 线下重新的报名
            }else if(401 == tag){
                // 线上重新报名
            }else if(401 == tag){
                // 立即支付
            }
        };
        return cell;
    }else if (_myLoveState == MyLoveStateDriving) {
        static NSString *cellId = @"Driving";
        DrivingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[DrivingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            //            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
//        DrivingModel *model = self.dataArray[indexPath.row];
//        [cell updateAllContentWith:model];
        
        return cell;
        
    }
    
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_myLoveState == MyLoveStateCoach) {
//        CoachModel *model = self.dataArray[indexPath.row];
//        self.coachDetailModel = model;
//        //        self.naviBarRightButton.hidden = NO;
//        
//        JGDrivingDetailViewController *detailVC = [[JGDrivingDetailViewController alloc]init];
//        DYNSLog(@"coachid = %@",model.coachid);
//        detailVC.coachUserId = model.coachid;
//        [self.navigationController pushViewController:detailVC animated:YES];
        
    }else if (_myLoveState == MyLoveStateDriving) {
//        DrivingDetailController *SelectVC = [[DrivingDetailController alloc]init];
//        DrivingModel *model = self.dataArray[indexPath.row];
//        self.drivingDetailModel = model;
//        self.naviBarRightButton.hidden = YES;
//        SelectVC.schoolID = model.schoolid;
//        [self.navigationController pushViewController:SelectVC animated:YES];
        
    }
}
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        DYNSLog(@"delete");
//        
//        if (_myLoveState == MyLoveStateCoach) {
//            CoachModel *model = self.dataArray[indexPath.row];
//            self.coachDetailModel = model;
//            
//            NSString *deleteUrl = [NSString stringWithFormat:@"%@/%@",kDeleteMySaveCoach,model.coachid];
//            NSString *urlString = [NSString stringWithFormat:BASEURL,deleteUrl];
//            [self.dataArray removeObject:model];
//            [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodDelete withCompletion:^(id data) {
//                DYNSLog(@"data = %@",data);
//                NSDictionary *param = data;
//                NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
//                if ([type isEqualToString:@"0"]) {
//                    [self showTotasViewWithMes:@"删除失败"];
//                }else if ([type isEqualToString:@"1"]) {
//                    [self showTotasViewWithMes:@"成功删除"];
//                    
//                }
//                
//            }];
//            
//            
//        }else if (_myLoveState == MyLoveStateDriving) {
//            
//            DrivingModel *model = self.dataArray[indexPath.row];
//            self.drivingDetailModel = model;
//            [self.dataArray removeObject:model];
//            
//            NSString *deleteUrl = [NSString stringWithFormat:@"%@/%@",kDeleteMySaveSchool,model.schoolid];
//            NSString *urlString = [NSString stringWithFormat:BASEURL,deleteUrl];
//            [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodDelete withCompletion:^(id data) {
//                DYNSLog(@"data = %@",data);
//                NSDictionary *param = data;
//                NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
//                if ([type isEqualToString:@"0"]) {
//                    [self showTotasViewWithMes:@"删除失败"];
//                }else if ([type isEqualToString:@"1"]) {
//                    [self showTotasViewWithMes:@"成功删除"];
//                    
//                }
//            }];
//            
//        }
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
//        
//        
//    }
//    
//}
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return @"删除";
//}
@end
