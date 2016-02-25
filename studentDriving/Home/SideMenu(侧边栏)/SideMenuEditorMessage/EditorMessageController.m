//
//  EditorMessageController.m
//  studentDriving
//
//  Created by zyt on 16/2/23.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "EditorMessageController.h"
#import "EditorMessageCell.h"
#import "EditorBottomCell.h"
#import "EditorTopCell.h"
#import "EditorDetailController.h"
#import "SignUpSuccessViewController.h"
#import "FavouriteViewController.h"
#import "MySaveViewController.h"
#import "SignUpDetailController.h"

static NSString *kinfomationCheck = @"userinfo/getapplyschoolinfo";

@interface EditorMessageController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *descriArray;

@end

@implementation EditorMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"个人中心";
    [self initData];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(iconImage) name:kiconImage object:nil];
    
}
- (void)initData{
    self.titleArray = @[@"",@"报考驾校",@"报考班型",@"报考车型",@"我的喜欢",@"报名详情"];
    if ([[AcountManager manager].userApplystate isEqualToString:@"0"] || [[AcountManager manager].userApplystate isEqualToString:@"1"]) {
        self.descriArray = @[@"",@"尚未报名",@"尚未报名",@"尚未报名"];
    }
    if ([[AcountManager manager].userApplystate isEqualToString:@"2"]) {
        self.descriArray = @[@"",[AcountManager manager].applyschool.name,[AcountManager manager].applyclasstype.name,[AcountManager manager].userCarmodels.name];
    }
    
    /*
     @property (readonly,strong, nonatomic) ApplyclasstypeinfoModel *applyclasstype;
     @property (readonly,strong, nonatomic) ApplycoachinfoModel *applycoach;
     @property (readonly,strong, nonatomic) ApplyschoolinfoModel *applyschool;
     @property (readonly,strong, nonatomic) ExamCarModel *userCarmodels;
     */

}
#pragma mark --- 头像改变的通知
- (void)iconImage{
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
 
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (4 == indexPath.row || 5 == indexPath.row) {
        return 60;
    }
    
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (0 == indexPath.row) {
        NSString *cellID = @"TopID";
        EditorTopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[EditorTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (1 == indexPath.row || 2 == indexPath.row || 3 == indexPath.row) {
        NSString *cellID = @"signUpID";
        EditorMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[EditorMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = self.titleArray[indexPath.row];
        cell.describeLabel.text = self.descriArray[indexPath.row];
        return cell;

    }
    if (4 == indexPath.row || 5 == indexPath.row) {
        NSString *EditorcellID = @"EditorID";
        EditorBottomCell *editorCell = [tableView dequeueReusableCellWithIdentifier:EditorcellID];
        if (!editorCell) {
            editorCell = [[EditorBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:EditorcellID];
        }
        editorCell.titleLabel.text = self.titleArray[indexPath.row];
        return editorCell;
        
    }
    return nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return _tableView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.row) {
        // 头像编辑
        EditorDetailController *editorVC = [[EditorDetailController alloc] init];
        [self.navigationController pushViewController:editorVC animated:YES];
                                            //        [JEPhotoPickManger pickPhotofromController:self];
    }
    if (4 == indexPath.row) {
        // 我的喜欢
        MySaveViewController *favouriteVC = [[MySaveViewController alloc] init];
        [self.navigationController pushViewController:favouriteVC animated:YES];
    }
    if (5 == indexPath.row) {
        // 报名详情
        
        NSString *applyUrlString = [NSString stringWithFormat:BASEURL,kinfomationCheck];
        NSDictionary *param = @{@"userid":[AcountManager manager].userid};
        [JENetwoking startDownLoadWithUrl:applyUrlString postParam:param WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
            if (!data) {
                return ;
            }
            NSDictionary *param = data;
            NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
            if ([type isEqualToString:@"1"]) {
                
                /* 申请状态请求数据
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

                 */
                
                NSDictionary *dataDic = [param objectForKey:@"data"];
                if (!dataDic || ![dataDic isKindOfClass:[NSDictionary class]]) {
                    return;
                }
                if ([[dataDic objectForKey:@"applystate"] integerValue] == 0) {
                    // 尚未报名
                    [self obj_showTotasViewWithMes:@"您还未报名!"];
                }else if ([[dataDic objectForKey:@"applystate"] integerValue] == 1) {
                    // 报名申请中（区分线上，线下）
                    if ([[data objectForKey:@"paytype"] integerValue] == 1) {
                        // 线下支付
                    }
                    if ([[data objectForKey:@"paytype"] integerValue] == 2) {
                        // 线上支付
                    }
                }else if ([[dataDic objectForKey:@"applystate"] integerValue] == 2){
                    // 报名成功
                    SignUpDetailController *signUpVC = [[SignUpDetailController alloc] init];
                    [self.navigationController pushViewController:signUpVC animated:YES];
                    
                }else {
                    [AcountManager saveUserApplyState:@"3"];
                }
                [AcountManager saveUserApplyCount:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"applycount"]]];
        }
            else {
                
                NSLog(@"1:%s [data objectForKey:msg:%@",__func__,[data objectForKey:@"msg"]);
                
                [self showTotasViewWithMes:[data objectForKey:@"msg"]];
            }
        } withFailure:^(id data) {
            [self showTotasViewWithMes:@"网络错误"];
        }];

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        if ([[[AcountManager manager] userApplystate] isEqualToString:@"1"]) {
            [self.navigationController pushViewController:[SignUpSuccessViewController new] animated:YES];
        }else if ([[[AcountManager manager] userApplystate] isEqualToString:@"0"])
        {
//            DrivingViewController *signUPVC = [DrivingViewController new];
//            [self.navigationController pushViewController:signUPVC animated:YES];
            [self obj_showTotasViewWithMes:@"您还未报名!"];
        }else if ([[[AcountManager manager] userApplystate] isEqualToString:@"3"]) {
            [self showTotasViewWithMes:@"验证报名中"];
        }else if ([[[AcountManager manager] userApplystate] isEqualToString:@"2"]) {
//            [self obj_showTotasViewWithMes:@"您已经报过名!"];
        }else{
            [self showTotasViewWithMes:@"您去支付完成的订单!"];
        }

    }
}

@end
