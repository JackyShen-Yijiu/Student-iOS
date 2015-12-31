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
#import "CoachDetailViewController.h"
#import "DrivingDetailViewController.h"
#import "SignUpInfoManager.h"
#import "BLPFAlertView.h"
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
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) UIView *menuIndicator;
@property (assign, nonatomic) MyLoveState myLoveState;
@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) UIButton *naviBarRightButton;
@property (strong, nonatomic) CoachModel *coachDetailModel;
@property (strong, nonatomic) DrivingModel *drivingDetailModel;


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
        _menuIndicator = [[UIView alloc] initWithFrame:CGRectMake(kSystemWide/4-60/2,40-2, 60, 2)];
        _menuIndicator.backgroundColor = MAINCOLOR;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+40, kSystemWide, kSystemHeight-64-40) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的喜欢";
    self.view.backgroundColor = [UIColor whiteColor];
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
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self startDownLoad];
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
        
    }];
}
- (UIView *)tableViewHeadView {
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kSystemWide, 40)];
    backGroundView.backgroundColor = [UIColor whiteColor];
    
    backGroundView.layer.shadowColor = RGBColor(204, 204, 204).CGColor;
    backGroundView.layer.shadowOffset = CGSizeMake(0, 1);
    backGroundView.layer.shadowOpacity = 0.5;
    backGroundView.userInteractionEnabled = YES;
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(kSystemWide/2-1/2, 40/2-18/2, 1, 18)];
    centerView.backgroundColor = RGBColor(230, 230, 230);
    [backGroundView addSubview:centerView];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:@"教练" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftButton.selected = YES;
    [leftButton addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [leftButton setTitleColor:MAINCOLOR forState:UIControlStateSelected];
    [backGroundView addSubview:leftButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backGroundView.mas_left).offset(0);
        make.top.mas_equalTo(backGroundView.mas_top).offset(0);
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide/2];
        make.width.mas_equalTo(height);
        make.height.mas_equalTo(@40);
    }];
    [self.buttonArray addObject:leftButton];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"驾校" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    
    [rightButton setTitleColor:MAINCOLOR forState:UIControlStateSelected];
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
        self.menuIndicator.frame = CGRectMake(StartOffset, self.menuIndicator.calculateFrameWithY, self.menuIndicator.calculateFrameWithWide, self.menuIndicator.calculateFrameWithHeight);
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
        self.menuIndicator.frame = CGRectMake(StartOffset+kSystemWide/2, self.menuIndicator.calculateFrameWithY, self.menuIndicator.calculateFrameWithWide, self.menuIndicator.calculateFrameWithHeight);
    }];
    sender.selected = YES;
    _myLoveState = MyLoveStateDriving;
    [self startDownLoad];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_myLoveState == MyLoveStateCoach) {
        return 100.0f;
    }else if (_myLoveState == MyLoveStateDriving) {
        return 100.0f;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_myLoveState == MyLoveStateCoach) {
        CoachModel *model = self.dataArray[indexPath.row];
        self.coachDetailModel = model;
        //        self.naviBarRightButton.hidden = NO;
        
        CoachDetailViewController *detailVC = [[CoachDetailViewController alloc]init];
        DYNSLog(@"coachid = %@",model.coachid);
        detailVC.coachUserId = model.coachid;
        [self.navigationController pushViewController:detailVC animated:YES];
        
    }else if (_myLoveState == MyLoveStateDriving) {
        DrivingDetailViewController *SelectVC = [[DrivingDetailViewController alloc]init];
        DrivingModel *model = self.dataArray[indexPath.row];
        self.drivingDetailModel = model;
        self.naviBarRightButton.hidden = YES;
        SelectVC.schoolId = model.schoolid;
        [self.navigationController pushViewController:SelectVC animated:YES];
        
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
