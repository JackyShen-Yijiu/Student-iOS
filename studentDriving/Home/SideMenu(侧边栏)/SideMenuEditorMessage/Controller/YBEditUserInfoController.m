//
//  YBEditUserInfoController.m
//  studentDriving
//
//  Created by 大威 on 16/3/1.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBEditUserInfoController.h"
#import "YBEditUserAdressController.h"

@interface YBEditUserInfoController ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIButton *naviRightButton;

@property (nonatomic, strong) UIView *editView;
@property (nonatomic, strong) UITextField *editTextFidld;

// 选择性别
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *genderArray;

// 如果是修改地址的话，则显示此箭头
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIButton *addressButton;

@end

@implementation YBEditUserInfoController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    
    UIBarButtonItem *bbiRight = [[UIBarButtonItem alloc] initWithCustomView:self.naviRightButton];
    self.navigationItem.rightBarButtonItem = bbiRight;
    
    [self.view addSubview:self.editView];
    [_editView addSubview:self.editTextFidld];
    
    if (_editType == YBEditUserInfoType_NickName) {
        self.title = @"昵称";
        self.editTextFidld.placeholder = @"请输入昵称";
    }else if (_editType == YBEditUserInfoType_Name) {
        self.title = @"姓名";
        self.editTextFidld.placeholder = @"请输入姓名";
    }else if (_editType == YBEditUserInfoType_Sex) {
        
        self.title = @"性别";
        self.editTextFidld.placeholder = @"请选择性别";
        _genderArray = @[ @"男", @"女" ];
        self.editTextFidld.inputView = self.pickerView;
        if ([AcountManager manager].userGender && [AcountManager manager].userGender.length) {
            _editTextFidld.text = [AcountManager manager].userGender;
            if ([_genderArray.firstObject isEqualToString:_editTextFidld.text]) {
                [self.pickerView selectRow:0 inComponent:0 animated:YES];
            }else {
                [self.pickerView selectRow:1 inComponent:0 animated:YES];
            }
        }else {
            _editTextFidld.text = @"男";
        }
        
    }else if (_editType == YBEditUserInfoType_Mobile) {
        self.title = @"手机号";
        self.editTextFidld.placeholder = @"请输入手机号";
    }else if (_editType == YBEditUserInfoType_Address) {
        
        self.title = @"地址";
        self.editTextFidld.placeholder = @"请输入地址";
//        _editTextFidld.userInteractionEnabled = NO;
//        [_editView addSubview:self.addressButton];
//        [_editView addSubview:self.arrowImageView];
        
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGSize size = self.view.bounds.size;
    
    CGFloat editViewHeight = 44;
    _editView.frame = CGRectMake(0, 12, size.width, editViewHeight);
    _editTextFidld.frame = CGRectMake(8, 0, size.width - 8, editViewHeight);
    _arrowImageView.frame = CGRectMake(size.width - 8 - 20, (editViewHeight - 28)/2.f, 20, 28);
    _addressButton.frame = _editView.bounds;
//    _editTextFidld.backgroundColor = [UIColor lightGrayColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (_editType == YBEditUserInfoType_Sex) {
        [self.editTextFidld becomeFirstResponder];
    }
}

#pragma mark - action

- (void)naviRightButtonAction:(UIButton *)sender {
    
    if (!_editTextFidld.text || !_editTextFidld.text.length) {
        [self obj_showTotasViewWithMes:@"内容为空"];
        return ;
    }
    
    NSMutableDictionary *paramsDict = @{ @"userid": [AcountManager manager].userid }.mutableCopy;
    
    if (_editType == YBEditUserInfoType_NickName) {
        // 昵称
        if (_editTextFidld.text.length > 14) {
            [self obj_showTotasViewWithMes:@"最多不超过14个字"];
            return;
        }
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[\\u4e00-\\u9fa5\\w\\-_]+"];
        if(![predicate evaluateWithObject:_editTextFidld.text]) {
            [self obj_showTotasViewWithMes:@"你输入的内容中含有非法字符"];
            return;
        }
        paramsDict[@"gender"] = _editTextFidld.text;
        
    }else if (_editType == YBEditUserInfoType_Name) {
        // 用户名
        if ([_editTextFidld.text length] > 6) {
            [self obj_showTotasViewWithMes:@"最多不超过6个字"];
            return;
        }
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[\\u4e00-\\u9fa5\\w\\-_]+"];
        if(![predicate evaluateWithObject:_editTextFidld.text]) {
            [self obj_showTotasViewWithMes:@"你输入的内容中含有非法字符"];
            return;
        }
        paramsDict[@"name"] = _editTextFidld.text;
        
    }else if (_editType == YBEditUserInfoType_Sex) {
        // 性别
        if ([_editTextFidld.text isEqualToString:@"男"] || [_editTextFidld.text isEqualToString:@"女"]) {
            paramsDict[@"gender"] = _editTextFidld.text;
        }else {
            [self obj_showTotasViewWithMes:@"请选择正确的性别"];
            return ;
        }
        
        
    }else if (_editType == YBEditUserInfoType_Mobile) {
        // 手机号
        if ([_editTextFidld.text length] != 11) {
            [self obj_showTotasViewWithMes:@"请输入正确的手机号"];
            return;
        }
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[\\u4e00-\\u9fa5\\w\\-_]+"];
        if(![predicate evaluateWithObject:_editTextFidld.text]) {
            [self obj_showTotasViewWithMes:@"你输入的内容中含有非法字符"];
            return;
        }
        
    }else if (_editType == YBEditUserInfoType_Address) {
        // 地址
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[\\u4e00-\\u9fa5\\w\\-_]+"];
        if(![predicate evaluateWithObject:_editTextFidld.text]) {
            [self obj_showTotasViewWithMes:@"你输入的内容中含有非法字符"];
            return;
        }
        paramsDict[@"address"] = _editTextFidld.text;
    }
    
    NSString *updateUserInfoUrl = [NSString stringWithFormat:BASEURL,@"userinfo/updateuserinfo"];
    [JENetwoking startDownLoadWithUrl:updateUserInfoUrl postParam:paramsDict WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        NSDictionary *dataParam = data;
        NSNumber *messege = dataParam[@"type"];
        if (messege.intValue == 1) {
            
            [self obj_showTotasViewWithMes:@"修改成功"];
            if (_editType == YBEditUserInfoType_NickName) {
                
                [AcountManager saveUserNickName:_editTextFidld.text];
                
            }else if (_editType == YBEditUserInfoType_Name) {
                
                [AcountManager saveUserName:_editTextFidld.text];
                
            }else if (_editType == YBEditUserInfoType_Sex) {
                
                [AcountManager saveUserGender:_editTextFidld.text];
                
            }else if (_editType == YBEditUserInfoType_Address) {
                
                [AcountManager saveUserAddress:_editTextFidld.text];
                
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:YBNotif_ChangeUserInfo object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [self obj_showTotasViewWithMes:@"修改失败"];
            return ;
        }
        
    }];
}

- (void)addressButtonAction:(UIButton *)sender {
    YBEditUserAdressController *vc = [YBEditUserAdressController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - pickerView data source and delegate

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _genderArray.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _genderArray[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *resultString = _genderArray[row];
    _editTextFidld.text = resultString;
    
}


#pragma mark - lazy load

- (UIView *)editView {
    if (!_editView) {
        _editView = [UIView new];
        _editView.backgroundColor = [UIColor whiteColor];
    }
    return _editView;
}

- (UITextField *)editTextFidld {
    if (!_editTextFidld) {
        _editTextFidld = [UITextField new];
        _editTextFidld.clearButtonMode = UITextFieldViewModeWhileEditing;
        _editTextFidld.tintColor = [UIColor lightGrayColor];
        _editTextFidld.font = [UIFont systemFontOfSize:14];
        if (_defaultString && _defaultString.length) {
            _editTextFidld.text = _defaultString;
        }else {
            _editTextFidld.text = @"";
        }
    }
    return _editTextFidld;
}

- (UIButton *)naviRightButton {
    if (!_naviRightButton) {
        _naviRightButton = [UIButton new];
        [_naviRightButton addTarget:self action:@selector(naviRightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _naviRightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_naviRightButton setTitle:@"确定" forState:UIControlStateNormal];
        _naviRightButton.bounds = CGRectMake(0, 0, 14 * 2, 44);
    }
    return _naviRightButton;
}

- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = RGBColor(245, 247, 250);
    }
    return _pickerView;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [UIImageView new];
        _arrowImageView.image = [UIImage imageNamed:@"more_right"];
        _arrowImageView.contentMode = UIViewContentModeCenter;
    }
    return _arrowImageView;
}

- (UIButton *)addressButton {
    if (!_addressButton) {
        _addressButton = [UIButton new];
        [_addressButton addTarget:self action:@selector(addressButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addressButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
