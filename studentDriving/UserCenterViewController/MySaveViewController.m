//
//  MyLoveCoachViewController.m
//  BlackCat
//
//  Created by bestseller on 15/9/18.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "MySaveViewController.h"
#import "UIDevice+JEsystemVersion.h"
#import "UIView+CalculateUIView.h"
#import "CoachTableViewCell.h"
#import "DrivingCell.h"
#import "CoachModel.h"
#import "DrivingModel.h"
#import "DrivingDetailController.h"
#import "JGDrivingDetailViewController.h"
#import "SignUpInfoManager.h"
#import "BLPFAlertView.h"
#import "ShowWarningBG.h"
#import "DVVCoachDetailController.h"

#define StartOffset  kSystemWide/4-60/2

static NSString *const kGetMySaveCoach = @"userinfo/favoritecoach";

static NSString *const kGetMySaveSchool = @"userinfo/favoriteschool";

static NSString *const kDeleteMySaveCoach = @"userinfo/favoritecoach";

static NSString *const kDeleteMySaveSchool = @"userinfo/favoriteschool";

typedef NS_ENUM(NSUInteger,MyLoveState){
    MyLoveStateCoach,
    MyLoveStateDriving
};

@interface MySaveViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView*navBarHairlineImageView;
}

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) UIView *menuIndicator;
@property (assign, nonatomic) MyLoveState myLoveState;
@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) UIButton *naviBarRightButton;
@property (strong, nonatomic) CoachModel *coachDetailModel;
@property (strong, nonatomic) DrivingModel *drivingDetailModel;

@property (strong, nonatomic) ShowWarningBG *coachBG;
@property (nonatomic, strong) ShowWarningBG *schoolBG;


@end

@implementation MySaveViewController

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
    
    self.title = @"我的喜欢";
    self.view.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightButton];
    DYNSLog(@"right = %@",self.naviBarRightButton);
    self.navigationItem.rightBarButtonItem = rightItem;
    //    if ([UIDevice jeSystemVersion] >= 7.0f) {
    //        self.edgesForExtendedLayout = UIRectEdgeNone;
    //      }
    
    _myLoveState = MyLoveStateCoach;
    
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:[self tableViewHeadView]];
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 0.5)];
//    view.backgroundColor = HM_LINE_COLOR;
//    self.tableView.tableFooterView = view;
    
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
    
//    navBarHairlineImageView.hidden=NO;
    
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [_coachBG hidden];
    [_schoolBG hidden];
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

- (UIButton *)naviBarRightButton {
    if (_naviBarRightButton == nil) {
        _naviBarRightButton = [WMUITool initWithTitle:@"完成" withTitleColor:MAINCOLOR withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarRightButton.hidden = YES;
        _naviBarRightButton.frame = CGRectMake(0, 0, 44, 44);
        [_naviBarRightButton addTarget:self action:@selector(clickRight:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBarRightButton;
}
- (void)clickRight:(UIButton *)sender {
    
    if (![[AcountManager manager].userApplystate isEqualToString:@"0"]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    DYNSLog(@"countId = %@",[AcountManager manager].applycoach.infoId);
    
    
    
    
    if (_myLoveState == MyLoveStateCoach) {
        if (![AcountManager manager].applyschool.infoId) {
            if (self.coachDetailModel || self.coachDetailModel.name) {
                NSDictionary *coachParam = @{kRealCoachid:self.coachDetailModel.coachid,@"name":self.coachDetailModel.name};
                [SignUpInfoManager signUpInfoSaveRealCoach:coachParam];
                
            }
            if (self.coachDetailModel.driveschoolinfo.driveSchoolId && self.coachDetailModel.driveschoolinfo.name) {
                DYNSLog(@"schoolinfo");
                NSDictionary *schoolParam = @{kRealSchoolid:self.coachDetailModel.driveschoolinfo.driveSchoolId,@"name":self.coachDetailModel.driveschoolinfo.name};
                [SignUpInfoManager signUpInfoSaveRealSchool:schoolParam];
            }
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        
        
        if ([[AcountManager manager].applyschool.infoId isEqualToString:self.coachDetailModel.driveschoolinfo.driveSchoolId]) {
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        
        if (![[AcountManager manager].applyschool.infoId isEqualToString:self.coachDetailModel.driveschoolinfo.driveSchoolId]) {
            [BLPFAlertView showAlertWithTitle:@"提示" message:@"您已经选择了教练和班型更换驾校后您可能重新做出选择" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] completion:^(NSUInteger selectedOtherButtonIndex) {
                DYNSLog(@"index = %ld",selectedOtherButtonIndex);
                NSUInteger index = selectedOtherButtonIndex + 1;
                if (index == 0) {
                    return ;
                }else {
                    if (self.coachDetailModel || self.coachDetailModel.name) {
                        NSDictionary *coachParam = @{kRealCoachid:self.coachDetailModel.coachid,@"name":self.coachDetailModel.name};
                        [SignUpInfoManager signUpInfoSaveRealCoach:coachParam];
                        
                    }
                    if (self.coachDetailModel.driveschoolinfo.driveSchoolId && self.coachDetailModel.driveschoolinfo.name) {
                        DYNSLog(@"schoolinfo");
                        NSDictionary *schoolParam = @{kRealSchoolid:self.coachDetailModel.driveschoolinfo.driveSchoolId,@"name":self.coachDetailModel.driveschoolinfo.name};
                        [SignUpInfoManager signUpInfoSaveRealSchool:schoolParam];
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                    
                }
            }];
        }
    }else if (_myLoveState == MyLoveStateDriving) {
        
        if (![AcountManager manager].applyschool.infoId) {
            if (self.drivingDetailModel.schoolid || self.drivingDetailModel.name) {
                NSDictionary *schoolParam = @{kRealSchoolid:self.drivingDetailModel.schoolid,@"name":self.drivingDetailModel.name};
                [SignUpInfoManager signUpInfoSaveRealSchool:schoolParam];
                
            }
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        
        if ([[AcountManager manager].applyschool.infoId isEqualToString:self.drivingDetailModel.schoolid] ) {
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        
        
        if (![[AcountManager manager].applyschool.infoId isEqualToString:self.drivingDetailModel.schoolid]) {
            [BLPFAlertView showAlertWithTitle:@"提示" message:@"您已经选择了教练和班型更换驾校后您可能重新做出选择" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] completion:^(NSUInteger selectedOtherButtonIndex) {
                DYNSLog(@"index = %ld",selectedOtherButtonIndex);
                NSUInteger index = selectedOtherButtonIndex + 1;
                if (index == 0) {
                    return ;
                }else  {
                    
                    [SignUpInfoManager removeSignData];
                    
                    if (self.drivingDetailModel.schoolid || self.drivingDetailModel.name) {
                        NSDictionary *schoolParam = @{kRealSchoolid:self.drivingDetailModel.schoolid,@"name":self.drivingDetailModel.name};
                        [SignUpInfoManager signUpInfoSaveRealSchool:schoolParam];
                        
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }
            }];
        }
        
    }
}
- (void)startDownLoad {
    
    [self.dataArray removeAllObjects];
    
    NSString *urlString = nil;
    
    if (_myLoveState == MyLoveStateCoach) {
        urlString = [NSString stringWithFormat:BASEURL,kGetMySaveCoach];
    }else if (_myLoveState == MyLoveStateDriving) {
        urlString = [NSString stringWithFormat:BASEURL,kGetMySaveSchool];
    }
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        DYNSLog(@"data = %@",data);
        NSDictionary *param = data;
        NSError *error = nil;
        if (_myLoveState == MyLoveStateCoach) {
            [self.dataArray addObjectsFromArray:[MTLJSONAdapter modelsOfClass:CoachModel.class fromJSONArray:param[@"data"] error:&error]];
        }else if (_myLoveState == MyLoveStateDriving) {
            [self.dataArray addObjectsFromArray:[MTLJSONAdapter modelsOfClass:DrivingModel.class fromJSONArray:param[@"data"] error:&error]];
        }
        [self.tableView reloadData];
        if (!self.dataArray.count) {
            if (_myLoveState == MyLoveStateCoach) {
                _coachBG = [[ShowWarningBG alloc] initWithTietleName:@"没有您喜欢的教练"];
                [_coachBG show];
            }
            if (_myLoveState == MyLoveStateDriving) {
//              NSString *msg = @"没有喜欢的教练";
                _schoolBG = [[ShowWarningBG alloc] initWithTietleName:@"没有您喜欢的驾校"];
                [_schoolBG show];
                
            }
//            [self showTotasViewWithMes:msg];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
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
    // 选择教练
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:@"教练" forState:UIControlStateNormal];
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
    // 选择驾校
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"驾校" forState:UIControlStateNormal];
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
    [_schoolBG hidden];
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
    [_coachBG hidden];
    sender.selected = YES;
    _myLoveState = MyLoveStateDriving;
    [self startDownLoad];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_myLoveState == MyLoveStateCoach) {
        return 90.0f;
    }else if (_myLoveState == MyLoveStateDriving) {
        return 90.0f;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArray.count == 0) {
        tableView.hidden = YES;
    }else {
        tableView.hidden = NO;
    }
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (_myLoveState == MyLoveStateCoach) {
        static NSString *cellId = @"Coach";
        CoachTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[CoachTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            //            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        CoachModel *model = self.dataArray[indexPath.row];
        [cell receivedCellModelWith:model];
        return cell;
    }else if (_myLoveState == MyLoveStateDriving) {
        static NSString *cellId = @"Driving";
        DrivingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[DrivingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            //            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        DrivingModel *model = self.dataArray[indexPath.row];
        [cell updateAllContentWith:model];
        
        return cell;
        
    }
    
    return nil;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (_myLoveState == MyLoveStateCoach) {
//        CoachModel *model = self.dataArray[indexPath.row];
//        self.coachDetailModel = model;
//        //        self.naviBarRightButton.hidden = NO;
//        
//        JGDrivingDetailViewController *detailVC = [[JGDrivingDetailViewController alloc]init];
//        DYNSLog(@"coachid = %@",model.coachid);
//        detailVC.coachUserId = model.coachid;
//        [self.navigationController pushViewController:detailVC animated:YES];
//        
//    }else if (_myLoveState == MyLoveStateDriving) {
//        DrivingDetailController *SelectVC = [[DrivingDetailController alloc]init];
//        DrivingModel *model = self.dataArray[indexPath.row];
//        self.drivingDetailModel = model;
//        self.naviBarRightButton.hidden = YES;
//        SelectVC.schoolID = model.schoolid;
//        [self.navigationController pushViewController:SelectVC animated:YES];
//        
//    }
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_myLoveState == MyLoveStateCoach) {// 教练详情
        
        CoachModel *model = self.dataArray[indexPath.row];
        self.coachDetailModel = model;
        
        // 跳转到教练详情
        DVVCoachDetailController *vc = [DVVCoachDetailController new];
        vc.hidesBottomBarWhenPushed = YES;
        vc.coachID = model.coachid;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (_myLoveState == MyLoveStateDriving) {// 驾校详情
        
        DrivingModel *model = self.dataArray[indexPath.row];
        self.drivingDetailModel = model;
        
        // 跳转到驾校详情
        DrivingDetailController *vc = [DrivingDetailController new];
        vc.hidesBottomBarWhenPushed = YES;
        vc.schoolID = model.schoolid;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        DYNSLog(@"delete");
        
        if (_myLoveState == MyLoveStateCoach) {
            CoachModel *model = self.dataArray[indexPath.row];
            self.coachDetailModel = model;
            
            NSString *deleteUrl = [NSString stringWithFormat:@"%@/%@",kDeleteMySaveCoach,model.coachid];
            NSString *urlString = [NSString stringWithFormat:BASEURL,deleteUrl];
            [self.dataArray removeObject:model];
            [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodDelete withCompletion:^(id data) {
                DYNSLog(@"data = %@",data);
                NSDictionary *param = data;
                NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
                if ([type isEqualToString:@"0"]) {
                    [self showTotasViewWithMes:@"删除失败"];
                }else if ([type isEqualToString:@"1"]) {
                    [self showTotasViewWithMes:@"成功删除"];
                    
                }
                
            }];
            
            
        }else if (_myLoveState == MyLoveStateDriving) {
            
            DrivingModel *model = self.dataArray[indexPath.row];
            self.drivingDetailModel = model;
            [self.dataArray removeObject:model];
            
            NSString *deleteUrl = [NSString stringWithFormat:@"%@/%@",kDeleteMySaveSchool,model.schoolid];
            NSString *urlString = [NSString stringWithFormat:BASEURL,deleteUrl];
            [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodDelete withCompletion:^(id data) {
                DYNSLog(@"data = %@",data);
                NSDictionary *param = data;
                NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
                if ([type isEqualToString:@"0"]) {
                    [self showTotasViewWithMes:@"删除失败"];
                }else if ([type isEqualToString:@"1"]) {
                    [self showTotasViewWithMes:@"成功删除"];
                    
                }
            }];
            
        }
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        
        
    }
    
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
@end
