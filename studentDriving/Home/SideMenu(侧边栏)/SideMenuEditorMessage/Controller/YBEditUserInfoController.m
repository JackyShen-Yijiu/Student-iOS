//
//  YBEditUserInfoController.m
//  studentDriving
//
//  Created by 大威 on 16/3/1.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBEditUserInfoController.h"
#import "YBEditUserAdressController.h"

@interface YBEditUserInfoController ()

@property (nonatomic, strong) UIButton *naviRightButton;

@property (nonatomic, strong) UIView *editView;
@property (nonatomic, strong) UITextField *editTextFidld;

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
    }else if (_editType == YBEditUserInfoType_Mobile) {
        self.title = @"手机号";
        self.editTextFidld.placeholder = @"请输入手机号";
    }else if (_editType == YBEditUserInfoType_Address) {
        self.title = @"地址";
        self.editTextFidld.placeholder = @"请输入地址";
        _editTextFidld.userInteractionEnabled = NO;
        [_editView addSubview:self.addressButton];
        [_editView addSubview:self.arrowImageView];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGSize size = self.view.bounds.size;
    
    CGFloat editViewHeight = 44;
    _editView.frame = CGRectMake(0, 8, size.width, editViewHeight);
    _editTextFidld.frame = CGRectMake(8, 0, size.width - 8, editViewHeight);
    _arrowImageView.frame = CGRectMake(size.width - 8 - 20, (editViewHeight - 28)/2.f, 20, 28);
    _addressButton.frame = _editView.bounds;
//    _editTextFidld.backgroundColor = [UIColor lightGrayColor];
}

#pragma mark - action

- (void)naviRightButtonAction:(UIButton *)sender {
    
    
}

- (void)addressButtonAction:(UIButton *)sender {
    YBEditUserAdressController *vc = [YBEditUserAdressController new];
    [self.navigationController pushViewController:vc animated:YES];
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
