//
//  SignUpOneViewController.m
//  BlackCat
//
//  Created by 董博 on 15/9/17.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "SignUpViewController.h"
#import "SignUpCell.h"
#import "ExamClassViewController.h"
#import <Masonry/Masonry.h>
#import "ExamCarViewController.h"
#import <IQKeyboardManager.h>
#import "JEPhotoPickManger.h"
#import "SignUpInfoManager.h"
#import "DrivingViewController.h"
#import <QiniuSDK.h>
#import "SignUpCoachViewController.h"
#import "SignUpDrivingViewController.h"
#import "BLPFAlertView.h"
#import "ChooseBtnView.h"
#import "KindlyReminderView.h"
#import "SignUpSuccessViewController.h"
#import "AcountManager.h"
#import "UIColor+Hex.h"
//245 247 250

static NSString *const kuserapplyUrl = @"/userinfo/userapplyschool";

static NSString *const kuserapplyState = @"/userinfo/getmyapplystate?userid=%@";

@interface SignUpViewController ()<UITableViewDataSource, UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    NSArray *inputArray;
    NSArray *signUpArray;
}

@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)UIButton *referButton;
@property (strong, nonatomic) UIButton *camerBnt ;
@property (strong, nonatomic) UIImageView *camerImage;
@property (strong, nonatomic) NSArray *firstArray;
@property (strong, nonatomic) NSString *qiniuToken;

@property (strong, nonatomic) NSMutableDictionary *mubDictionary;
@property (strong, nonatomic) NSDictionary *qiniuUpdic;
@property (strong, nonatomic) UIButton *goBackButton;
@property (strong, nonatomic) UIButton *callButton;

@end

@implementation SignUpViewController

- (NSMutableDictionary *)mubDictionary {
    if (_mubDictionary == nil) {
        _mubDictionary = [[NSMutableDictionary alloc] init];
    }
    return _mubDictionary;
}

- (UIButton *)goBackButton{
    if (_goBackButton == nil) {
        _goBackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [_goBackButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//        [_goBackButton setBackgroundImage:[UIImage imageNamed:@"返回_click"] forState:UIControlStateNormal];
        [_goBackButton addTarget:self action:@selector(dealGoBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goBackButton;
}

- (UIButton *)callButton{
    if (_callButton == nil) {
        _callButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [_callButton setBackgroundImage:[UIImage imageNamed:@"dianhua"] forState:UIControlStateNormal];
        [_callButton addTarget:self action:@selector(callBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _callButton;
}

- (NSArray *)firstArray {
    if (_firstArray == nil) {
        _firstArray = @[@"真实姓名",@"身份证号",@"联系方式",@"常用地址"];
    }
    return _firstArray;
}

- (UIButton *)referButton{
    if (_referButton == nil) {
        _referButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _referButton.backgroundColor = [UIColor colorWithHexString:@"ff5d35"];
        _referButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_referButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_referButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_referButton addTarget:self action:@selector(dealRefer:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _referButton;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kSystemWide, kSystemHeight-64-49) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = RGBColor(245, 247, 250);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    }
    return _tableView;
}
- (UIView *)tableHeadView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 77+110)];
    
    ChooseBtnView *chooseBtnView = [[ChooseBtnView alloc] initWithSelectedBtn:1 leftTitle:@"选择驾校" midTitle:@"填写信息" rightTitle:@"报名验证" frame:CGRectMake(0, 10,kSystemWide , 67 )];
    chooseBtnView.backgroundColor = [UIColor whiteColor];
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 77, kSystemWide, 110)];
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
    
    
    [view addSubview:chooseBtnView];
    [view addSubview:backGroundView];
    return view;
}

- (UIView *)tableFootView {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = RGBColor(245, 247, 250);
    return view;
}
- (void)viewDidLoad{
    [super  viewDidLoad];
    
    self.view.backgroundColor = RGBColor(245, 247, 250);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"报名";
  
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.goBackButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.callButton];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = [self tableHeadView];
    self.tableView.tableFooterView = [self tableFootView];
    [self.view addSubview:self.referButton];
    
    [self.referButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(49);
    }];
}
#pragma mark - Aciton

- (void)dealGoBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)callBtnClick {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://01053658566"]];
}

- (void)clickCamer:(UITapGestureRecognizer *)tap {
    
    [JEPhotoPickManger pickPhotofromController:self];    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    KindlyReminderView *krv = [[KindlyReminderView alloc] initWithContentStr:@"请认真填写以上信息，您填写的信息将作为报名信息录入车考驾照系统内，如果信息错误，将影响您的报名流程。" frame:CGRectMake(0, 0, kSystemWide, 100)];
    return krv;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
                [self showTotasViewWithMes:@"请输入真实姓名"];
                return ;
            }
            [SignUpInfoManager signUpInfoSaveRealName:completionString];
            DYNSLog(@"真实名字");
        }else if (indexPath.row == 1) {
            if (completionString == nil || completionString.length == 0) {
                [self showTotasViewWithMes:@"请输入身份证号"];
                return;
            }
            NSString *identityCarString = completionString;
            NSString *regex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            BOOL isMatch = [pred evaluateWithObject:identityCarString];
            if (!isMatch) {
                [self showTotasViewWithMes:@"请输入正确的身份证号"];
                return;
            }
            [SignUpInfoManager signUpInfoSaveRealIdentityCar:completionString];
            DYNSLog(@"身份证号");
            
        }else if (indexPath.row == 2) {
            if (completionString == nil || completionString.length == 0) {
                [self showTotasViewWithMes:@"请输入手机号"];
                return;
            }
            NSString *phoneNum = completionString;
            NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            BOOL isMatch = [pred evaluateWithObject:phoneNum];
            if (!isMatch) {
                [self showTotasViewWithMes:@"请输入正确的手机号"];
                return;
            }
            [SignUpInfoManager signUpInfoSaveRealTelephone:completionString];
            DYNSLog(@"联系方式");
            
        }else if (indexPath.row == 3) {
            if (completionString == nil || completionString.length == 0) {
                [self showTotasViewWithMes:@"请输入常用地址"];
                return;
            }
            [SignUpInfoManager signUpInfoSaveRealAddress:completionString];
            DYNSLog(@"常用地址");
        }
    }];
    
    return cell;

}

- (void)dealRefer:(UIButton *)sender{
    if ([[AcountManager manager].userApplystate isEqualToString:@"0"]) {
        NSDictionary *param = [SignUpInfoManager getSignUpInforamtion];
        if (param == nil) {
            return;
        }
        DYNSLog(@"提交 = %@",param);
        NSMutableDictionary *upData = [[NSMutableDictionary alloc] initWithDictionary:param];
        if (self.qiniuUpdic) {
            [upData setObject:self.qiniuUpdic forKey:@"headportrait"];
        }
        NSString *applyUrlString = [NSString stringWithFormat:BASEURL,kuserapplyUrl];
        
        [JENetwoking startDownLoadWithUrl:applyUrlString postParam:upData WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
            DYNSLog(@"param = %@",data[@"msg"]);
            NSDictionary *param = data;
            NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
            if ([type isEqualToString:@"1"]) {
                kShowSuccess(@"报名成功");
                [self.navigationController pushViewController:[SignUpSuccessViewController new] animated:YES];
                //使重新报名变为0
                [AcountManager saveUserApplyState:@"1"];
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                if ([[ud objectForKey:@"applyAgain"] isEqualToString:@"1"]) {
                    [ud setObject:@"0" forKey:@"applyAgain"];
                    [ud synchronize];
                }
            }else {
                kShowFail(param[@"msg"]);
            }
        }];
        
        
    }else if ([[AcountManager manager].userApplystate isEqualToString:@"1"]) {
        [self showTotasViewWithMes:@"报名申请中"];
    }

  
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    inputArray = @[[SignUpInfoManager getSignUpRealName],[SignUpInfoManager getSignUpRealIdentityCar],[SignUpInfoManager getSignUpRealTelephone],[SignUpInfoManager getSignUpRealAddress]];
}

#pragma mark - delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    DYNSLog(@"imageData = %@",[AcountManager manager].userid);
    self.camerBnt.hidden = YES;
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *photoImage = [info valueForKey:UIImagePickerControllerEditedImage];
    NSData *photeoData = UIImageJPEGRepresentation(photoImage, 0.5);
    self.camerImage.image = photoImage;
    
    
    __weak SignUpViewController *weakself = self;
    __block NSData *gcdPhotoData = photeoData;
    NSString *qiniuUrl = [NSString stringWithFormat:BASEURL,kQiniuUpdateUrl];
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
                [self showTotasViewWithMes:@"头像上传成功"];

                NSString *upImageUrl = [NSString stringWithFormat:kQiniuImageUrl,key];
                NSDictionary *headPortrait  = @{@"originalpic":upImageUrl,@"thumbnailpic":@"",@"width":@"",@"height":@""};
                weakself.qiniuUpdic = headPortrait;
            }
        } option:nil];
    }];
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