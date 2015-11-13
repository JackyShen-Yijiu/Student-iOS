//
//  SignUpOneViewController.m
//  BlackCat
//
//  Created by 董博 on 15/9/17.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "SignUpListViewController.h"
#import "SignUpCell.h"
#import "ExamClassViewController.h"
#import <Masonry/Masonry.h>
#import "ExamCarViewController.h"
#import <SVProgressHUD.h>
#import <IQKeyboardManager.h>
#import "JEPhotoPickManger.h"
#import "SignUpInfoManager.h"
#import "DrivingViewController.h"
#import <QiniuSDK.h>
#import "SignUpCoachViewController.h"
#import "SignUpDrivingViewController.h"
#import "PFAlertView.h"
//245 247 250

static NSString *const kuserapplyUrl = @"/userinfo/userapplyschool";

@interface SignUpListViewController ()<UITableViewDataSource, UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    NSArray *inputArray;
    NSArray *signUpArray;
}

@property (strong, nonatomic) UIButton *GoBackButton;
@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)UIButton *referButton;
@property (strong, nonatomic) UIButton *camerBnt ;
@property (strong, nonatomic) UIImageView *camerImage;
@property (strong, nonatomic) NSArray *firstArray;
@property (strong, nonatomic) NSArray *secondArray;
@property (strong, nonatomic) NSString *qiniuToken;

@property (strong, nonatomic) NSMutableDictionary *mubDictionary;


@end

@implementation SignUpListViewController

- (UIButton *)GoBackButton {
    if (_GoBackButton == nil) {
        _GoBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _GoBackButton.frame = CGRectMake(0, 20, 44, 44);
        [_GoBackButton setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
        [_GoBackButton addTarget:self action:@selector(clickGoback:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _GoBackButton;
}
- (void)clickGoback:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSMutableDictionary *)mubDictionary {
    if (_mubDictionary == nil) {
        _mubDictionary = [[NSMutableDictionary alloc] init];
    }
    return _mubDictionary;
}

- (NSArray *)firstArray {
    if (_firstArray == nil) {
        _firstArray = @[@"学员号",@"准考证号",@"真实姓名",@"身份证号",@"联系方式",@"常用地址"];
    }
    return _firstArray;
}
- (NSArray *)secondArray {
    if (_secondArray == nil) {
        _secondArray = @[@"报考驾校",@"报考车型",@"报考教练",@"报考班型"];
    }
    return _secondArray;
}
- (UIButton *)referButton{
    if (_referButton == nil) {
        _referButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _referButton.backgroundColor = MAINCOLOR;
        _referButton.titleLabel.font = [UIFont systemFontOfSize:16];
        if ([[AcountManager manager].userApplystate isEqualToString:@"2"]) {
            [_referButton setTitle:@"报名成功" forState:UIControlStateNormal];
            _referButton.userInteractionEnabled = NO;
        }else {
            [_referButton setTitle:@"提交" forState:UIControlStateNormal];
        }
        [_referButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_referButton addTarget:self action:@selector(dealRefer:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _referButton;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kSystemWide, kSystemHeight-49-64) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = RGBColor(245, 247, 250);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
    }
    return _tableView;
}
- (UIView *)tableHeadView {
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 110)];
    backGroundView.backgroundColor = RGBColor(245, 247, 250);
    backGroundView.layer.borderColor = RGBColor(230, 230, 230).CGColor;
    backGroundView.layer.borderWidth = 1;
    _camerImage = [[UIImageView alloc] init];
    _camerImage.layer.cornerRadius = 2;
    _camerImage.userInteractionEnabled = YES;
    _camerImage.layer.borderColor = RGBColor(230, 230, 230).CGColor;
    _camerImage.layer.borderWidth = 1;
    _camerImage.backgroundColor = [UIColor whiteColor];
    [backGroundView addSubview:_camerImage];
    [_camerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backGroundView.mas_centerY);
        make.centerX.mas_equalTo(backGroundView.mas_centerX);
        make.height.mas_equalTo(@71);
        make.width.mas_equalTo(@71);
    }];
    _camerBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    [_camerBnt setBackgroundImage:[UIImage imageNamed:@"相机.png"] forState:UIControlStateNormal];
    [_camerBnt setBackgroundImage:[UIImage imageNamed:@"相机pressed.png"] forState:UIControlStateHighlighted];
    //    [_camerBnt addTarget:self action:@selector(clickCamer:) forControlEvents:UIControlEventTouchUpInside];
    [_camerImage addSubview:_camerBnt];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCamer:)];
    [_camerImage addGestureRecognizer:tapGesture];
    [_camerBnt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_camerImage.mas_centerY);
        make.centerX.mas_equalTo(_camerImage.mas_centerX);
        make.height.mas_equalTo(@29);
        make.width.mas_equalTo(@29);
    }];
    return backGroundView;
}

- (UIView *)tableFootView {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = RGBColor(245, 247, 250);
    return view;
}
- (void)viewDidLoad{
    [super  viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"报名";
    
    
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = [self tableHeadView];
    self.tableView.tableFooterView = [self tableFootView];
    [self.view addSubview:self.referButton];
    
    [self.referButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(0);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(49);
    }];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 15, 0, 15)];
    }
    
//    [self.view addSubview:self.GoBackButton];

}
#pragma mark - Aciton

- (void)clickCamer:(UITapGestureRecognizer *)tap {
    
    [JEPhotoPickManger pickPhotofromController:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = RGBColor(245, 247, 250);
    return view;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 6;
    }
    return 4;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 15, 0, 15)];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *cellId = @"cell";
        SignUpCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[SignUpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        [cell receiveTextContent:inputArray[indexPath.row]];
        NSString *titleString = self.firstArray[indexPath.row];
        [cell receiveTitile:titleString andSignUpBlock:^(NSString *completionString) {
            
            if (indexPath.row == 0) {
                if (completionString == nil || completionString.length == 0) {
                    [SVProgressHUD showErrorWithStatus:@"请输入真实姓名"];
                    return ;
                }
                [SignUpInfoManager signUpInfoSaveStudentNumber:completionString];
                
            }else if (indexPath.row == 1) {
                if (completionString == nil || completionString.length == 0) {
                    [SVProgressHUD showErrorWithStatus:@"请输入真实姓名"];
                    return ;
                }
                 [SignUpInfoManager signUpInfoSaveStudentNumber:completionString];
            }
            
           else if (indexPath.row == 2) {
                if (completionString == nil || completionString.length == 0) {
                    [SVProgressHUD showErrorWithStatus:@"请输入真实姓名"];
                    return ;
                }
                [SignUpInfoManager signUpInfoSaveRealName:completionString];
                DYNSLog(@"真实名字");
            }else if (indexPath.row == 3) {
                if (completionString == nil || completionString.length == 0) {
                    [SVProgressHUD showErrorWithStatus:@"请输入身份证号"];
                    return;
                }
                NSString *identityCarString = completionString;
                NSString *regex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
                NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
                BOOL isMatch = [pred evaluateWithObject:identityCarString];
                if (!isMatch) {
                    [SVProgressHUD showErrorWithStatus:@"请输入正确的身份证号"];
                    return;
                }
                [SignUpInfoManager signUpInfoSaveRealIdentityCar:completionString];
                DYNSLog(@"身份证号");
                
            }else if (indexPath.row == 4) {
                if (completionString == nil || completionString.length == 0) {
                    [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
                    return;
                }
                NSString *phoneNum = completionString;
                NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
                NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
                BOOL isMatch = [pred evaluateWithObject:phoneNum];
                if (!isMatch) {
                    [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
                    return;
                }
                [SignUpInfoManager signUpInfoSaveRealTelephone:completionString];
                DYNSLog(@"联系方式");
                
            }else if (indexPath.row == 5) {
                if (completionString == nil || completionString.length == 0) {
                    [SVProgressHUD showErrorWithStatus:@"请输入常用地址"];
                    return;
                }
                [SignUpInfoManager signUpInfoSaveRealAddress:completionString];
                DYNSLog(@"常用地址");
            }
        }];
        
        return cell;
    }else if (indexPath.section == 1 ) {
        static NSString *cellId = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        }
        if (![[AcountManager manager].userApplystate isEqualToString:@"0"]) {
            cell.userInteractionEnabled = NO;
        }
        cell.textLabel.text = self.secondArray[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        DYNSLog(@"result = %@",signUpArray[indexPath.row]);
        cell.detailTextLabel.text = signUpArray[indexPath.row];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        //        if ([SignUpInfoManager getSignUpSchoolid] ) {
        //            [PFAlertView showAlertWithTitle:@"提示" message:@"您已经选择了教练和班型更换驾校后您可能重新做出选择" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] completion:^(NSUInteger selectedOtherButtonIndex) {
        //                DYNSLog(@"index = %ld",selectedOtherButtonIndex);
        //                NSUInteger index = selectedOtherButtonIndex + 1;
        //                if (index == 0) {
        //                    return ;
        //                }else if (index == 1) {
        //
        //                    [SignUpInfoManager removeSignData];
        //
        //                SignUpDrivingViewController *drivingVC = [[SignUpDrivingViewController alloc] init];
        //                [self.navigationController pushViewController:drivingVC animated:YES];
        //                }
        //            }];
        //
        //        }else {
        SignUpDrivingViewController *drivingVC = [[SignUpDrivingViewController alloc] init];
        [self.navigationController pushViewController:drivingVC animated:YES];
        //        }
        
        
        
    }else if (indexPath.section == 1 && indexPath.row == 2 ){
        SignUpCoachViewController *coachVc = [[SignUpCoachViewController alloc] init];
        coachVc.markNum = 1;
        
        [self.navigationController pushViewController:coachVc animated:YES];
        
        
    }
    else if (indexPath.section == 1 && indexPath.row == 1) {
        if ([SignUpInfoManager getSignUpSchoolid] == nil || [SignUpInfoManager getSignUpSchoolid].length == 0) {
        }
        ExamCarViewController *carType = [[ExamCarViewController alloc] init];
        [self.navigationController pushViewController:carType animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 3) {
        if ([SignUpInfoManager getSignUpSchoolid] == nil || [SignUpInfoManager getSignUpSchoolid].length == 0) {
            [SVProgressHUD showInfoWithStatus:@"请选择驾校"];
            return;
        }
        ExamClassViewController *classType = [[ExamClassViewController alloc] init];
        [self.navigationController pushViewController:classType animated:YES];
    }
}



- (void)dealRefer:(UIButton *)sender{
    if ([[AcountManager manager].userApplystate isEqualToString:@"0"]) {
        NSDictionary *param = [SignUpInfoManager getSignUpPassInformation];
        if (param == nil) {
            return;
        }
        DYNSLog(@"提交 = %@",param);
        
        NSString *applyUrlString = [NSString stringWithFormat:BASEURL,kuserapplyUrl];
        
        [JENetwoking startDownLoadWithUrl:applyUrlString postParam:param WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
            DYNSLog(@"param = %@",data[@"msg"]);
            NSDictionary *param = data;
            NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
            if ([type isEqualToString:@"1"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }else if ([[AcountManager manager].userApplystate isEqualToString:@"1"]) {
        [SVProgressHUD showInfoWithStatus:@"报名申请中"];
        
    }
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    inputArray = @[[SignUpInfoManager getStudentNumber],[SignUpInfoManager getPassNumber],[SignUpInfoManager getSignUpRealName],[SignUpInfoManager getSignUpRealIdentityCar],[SignUpInfoManager getSignUpRealTelephone],[SignUpInfoManager getSignUpRealAddress]];
    
    signUpArray = @[[SignUpInfoManager getSignUpSchoolName],[SignUpInfoManager getSignUpCarmodelName],[SignUpInfoManager getSignUpCoachName],[SignUpInfoManager getSignUpClasstypeName]];
    [self.tableView reloadData];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    kShowDismiss
}


#pragma mark - delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    DYNSLog(@"imageData = %@",[AcountManager manager].userid);
    self.camerBnt.hidden = YES;
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *photoImage = [info valueForKey:UIImagePickerControllerEditedImage];
    NSData *photeoData = UIImageJPEGRepresentation(photoImage, 0.5);
    self.camerImage.image = photoImage;
    
    
    __weak SignUpListViewController *weakself = self;
    __block NSData *gcdPhotoData = photeoData;
    NSString *qiniuUrl = [NSString stringWithFormat:BASEURL,kQiniuUpdateUrl];
    [SVProgressHUD show];
    [JENetwoking startDownLoadWithUrl:qiniuUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        DYNSLog(@"data = %@",data);
        NSDictionary *dataDic = data;
        weakself.qiniuToken = dataDic[@"data"];
        QNUploadManager *upLoadManager = [[QNUploadManager alloc] init];
        NSString *keyUrl = [NSString stringWithFormat:@"%@-%@.png",[NSString currentTimeDay],[AcountManager manager].userid];
        DYNSLog(@"keyUrl = %@",keyUrl);
        [upLoadManager putData:gcdPhotoData key:keyUrl token:weakself.qiniuToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
            DYNSLog(@"info = %@ %@ %@",info,key,resp);
            if (info) {
                //                DYNSLog(@"key = %@",key);
                //                NSString *upImageUrl = [NSString stringWithFormat:kQiniuImageUrl,key];
                //                NSString *updateUserInfoUrl = [NSString stringWithFormat:BASEURL,kupdateUserInfo];
                //                NSDictionary *headPortrait  = @{@"originalpic":upImageUrl,@"thumbnailpic":@"",@"width":@"",@"height":@""};
                //
                //                NSDictionary *dicParam = @{@"headportrait":[JsonTransformManager dictionaryTransformJsonWith:headPortrait],@"userid":[AcountManager manager].userid};
                //                [JENetwoking startDownLoadWithUrl:updateUserInfoUrl postParam:dicParam WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
                //                    NSDictionary *dataParam = data;
                //                    NSNumber *messege = dataParam[@"type"];
                //                    DYNSLog(@"msg = %@ %@",data,dataParam[@"msg"]);
                //                    if (messege.intValue == 1) {
                //                        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                //                        [AcountManager saveUserHeadImageUrl:upImageUrl];
                //                        DYNSLog(@"url = %@",[AcountManager manager].userHeadImageUrl);
                //
                //                        [weakself.camerImage sd_setImageWithURL:[NSURL URLWithString:[AcountManager manager].userHeadImageUrl] placeholderImage:[UIImage imageWithData:gcdPhotoData]];
                //
                //                    }else {
                //                        [SVProgressHUD showErrorWithStatus:@"修改失败"];
                //                        return;
                //                    }
                //                }];
            }
        } option:nil];
    }];
    
    
    
    //    dispatch_group_t group = dispatch_group_create();
    //    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //    dispatch_group_async(group, queue, ^{
    //        dispatch_group_async(group, dispatch_get_main_queue(), ^{
    //        });
    //    });
    //    dispatch_group_async(group, queue, ^{
    //        dispatch_group_async(group, dispatch_get_main_queue(), ^{
    //
    //        });
    //    });
    //    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
    //        NSLog(@"3");
    //    });
    
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.title = @"照片";
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(0, 0, 44, 44);
    [cancelBtn addTarget:self action:@selector(clickCancel:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    viewController.navigationItem.rightBarButtonItem = rightItem;
    
}
- (void)clickCancel:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end