//
//  SignatureViewController.m
//  BlackCat
//
//  Created by bestseller on 15/10/6.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "ModifyNickNameViewController.h"
#import "UIDevice+JEsystemVersion.h"

static NSString *const kupdateUserInfo = @"userinfo/updateuserinfo";
@interface ModifyNickNameViewController ()
@property (strong, nonatomic) UITextField *modifyNameTextField;
@property (strong, nonatomic) UIButton *naviBarRightButton;
@property (strong, nonatomic) UIButton *naviBarLeftButton;
@end

@implementation ModifyNickNameViewController
- (UITextField *)modifyNameTextField {
    if (_modifyNameTextField == nil) {
        _modifyNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 20, kSystemWide, 44)];
        _modifyNameTextField.backgroundColor = [UIColor whiteColor];
        if ([AcountManager manager].userNickName) {
            _modifyNameTextField.text = [AcountManager manager].userNickName;
        }
    }
    return _modifyNameTextField;
}
- (UIButton *)naviBarRightButton {
    if (_naviBarRightButton == nil) {
        _naviBarRightButton = [WMUITool initWithTitle:@"完成" withTitleColor:MAIN_FOREGROUND_COLOR withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarRightButton.frame = CGRectMake(0, 0, 44, 44);
        [_naviBarRightButton addTarget:self action:@selector(clickRight:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBarRightButton;
}
- (UIButton *)naviBarLeftButton {
    if (_naviBarLeftButton == nil) {
        _naviBarLeftButton = [WMUITool initWithTitle:@"取消" withTitleColor:MAIN_FOREGROUND_COLOR withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarLeftButton.frame = CGRectMake(0, 0, 44, 44);
        [_naviBarLeftButton addTarget:self action:@selector(clickLeft:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBarLeftButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([UIDevice jeSystemVersion] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"昵称";
    self.view.backgroundColor = RGBColor(245, 247, 250);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarLeftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self.view addSubview:self.modifyNameTextField];
    [self.modifyNameTextField becomeFirstResponder];
}

- (void)clickLeft:(UIButton *)sender {
    if (self.modifyNameTextField.text == nil || self.modifyNameTextField.text.length == 0) {
        kShowFail(@"您还未填写信息");
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickRight:(UIButton *)sender {
    DYNSLog(@"上传");
    //
    DYNSLog(@"userid = %@",self.modifyNameTextField.text);
    NSString *updateUserInfoUrl = [NSString stringWithFormat:BASEURL,kupdateUserInfo];
    
    NSDictionary *dicParam = @{@"nickname":self.modifyNameTextField.text,@"userid":[AcountManager manager].userid};
    
    
    [JENetwoking startDownLoadWithUrl:updateUserInfoUrl postParam:dicParam WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        NSDictionary *dataParam = data;
        NSNumber *messege = dataParam[@"type"];
        if (messege.intValue == 1) {
            [self showTotasViewWithMes:@"修改成功"];
            [AcountManager saveUserNickName:self.modifyNameTextField.text];
            [[NSNotificationCenter defaultCenter] postNotificationName:kmodifyNickNameChange object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [self showTotasViewWithMes:@"修改失败"];
            return;
        }
        
    }];
}

@end
