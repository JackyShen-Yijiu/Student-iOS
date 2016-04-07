//
//  EditorDetailController.m
//  studentDriving
//
//  Created by zyt on 16/2/23.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "EditorDetailController.h"
#import "EditorDetailCell.h"
#import "EditorDetailSexCell.h"
#import "JEPhotoPickManger.h"
#import <QiniuSDK.h>
#import "ModifyPhoneNumViewController.h"
static NSString *const kupdateUserInfo = @"userinfo/updateuserinfo";

@interface EditorDetailController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *strArray;
@property (nonatomic, strong) NSArray *descrArray;
@property (nonatomic, strong) NSArray *tagArray;
@property (nonatomic, strong) UIView *bgheaderView;
@property (nonatomic, strong) UIImageView *iconImgView;
@property (strong, nonatomic) NSString *qiniuToken;

@property (nonatomic, strong) NSString *nameStr;
@property (nonatomic, strong) NSString *nickStr;
@property (nonatomic, strong) NSString *addressSre;
@property (nonatomic, strong) NSString *phoneStr;
@property (nonatomic, assign) BOOL sexWay;

@property (nonatomic, strong) EditorDetailCell *nameCell;
@property (nonatomic, strong) EditorDetailCell *nickCell;
@property (nonatomic, strong) EditorDetailCell *addressCell;
@end

@implementation EditorDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(249, 249, 249);
    self.title = @"编辑信息";
    [self.view addSubview:self.tableView];
    [self.bgheaderView addSubview:self.iconImgView];
    self.tableView.tableHeaderView = self.bgheaderView;
    UITapGestureRecognizer *tapGestureRe = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickImage:)];
    [self.iconImgView addGestureRecognizer:tapGestureRe];
    self.iconImgView.userInteractionEnabled = YES;
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phone) name:kphone object:nil];
    [self addSignUp];
    [self initData];
   
    
}

- (void)addSignUp
{
    CGRect backframe= CGRectMake(0, 0, 44, 44);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = backframe;
    [backButton setTitle:@"保存" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [backButton addTarget:self action:@selector(sideMenuButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)initData{
    self.tagArray = @[@"300",@"",@"301",@"302",@"303",@"304"];
    self.strArray = @[@"姓名",@"",@"昵称",@"绑定手机号",@"我的地址"];
    if ([[[AcountManager manager] userGender] isEqualToString:@"男"]) {
        _sexWay = 0;
    }else if ([[[AcountManager manager] userGender] isEqualToString:@"女"]){
        _sexWay = 1;
    }
//    NSString *nameStr = nil;
//    NSString *nickStr = nil;
//    NSString *phoneStr = nil;
//    NSString *addressSre = nil;
    
    // 姓名
    if ([[AcountManager manager].userName isEqualToString:@""]) {
        self.nameStr = @"暂无姓名";
    }else{
        self.nameStr = [AcountManager manager].userName;
    }
    NSLog(@"self.nickStr = %@",[AcountManager manager].userNickName);
    // 昵称
    if ([[AcountManager manager].userNickName isEqualToString:@""]) {
        self.nickStr = @"暂无昵称";
        
    }else{
        self.nickStr = [AcountManager manager].userNickName;
    }
    // 绑定手机号
    if ([[AcountManager manager].userMobile isEqualToString:@""]) {
        self.phoneStr = @"暂无手机号";
    }else{
        self.phoneStr = [AcountManager manager].userMobile;
    }
    // 我的地址
    if ([[AcountManager manager].userAddress isEqualToString:@""]) {
        self.addressSre = @"暂无地址";
    }else{
        self.addressSre = [AcountManager manager].userAddress;
    }
    self.descrArray = @[self.nameStr,@"",self.nickStr,self.phoneStr,self.addressSre];

}
// 绑定手机号成功后的通知方法
- (void)phone{
    NSIndexPath *path = [NSIndexPath indexPathForRow:3 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma mark ---- Action
- (void)sideMenuButtonAction{
    // 保存修改的个人信息
    if (!self.nameCell.showWarningMessageView.hidden) {
        [self obj_showTotasViewWithMes:@"请填写姓名"];
        return;
    }
    if (!self.nickCell.showWarningMessageView.hidden) {
        [self obj_showTotasViewWithMes:@"请核实信息!"];
        return;
    }
    if (!self.addressCell.showWarningMessageView.hidden) {
        [self obj_showTotasViewWithMes:@"请核实信息!"];
        return;
    }
    
    
    NSString *realNameStr = @"";
    NSString *realNickStr = @"";
    NSString *realAddressStr = @"";
    NSString *realSex = @"";
    
    // 保存姓名
    realNameStr = self.nameCell.descriTextField.text;

    
    // 保存昵称
   if (self.nickCell.descriTextField.text == nil || self.nickCell.descriTextField.text.length == 0) {
        realNickStr = @"";
   }else {
       realNickStr = self.nickCell.descriTextField.text;
   }
    
    // 保存地址
    if (self.addressCell.descriTextField.text == nil || self.addressCell.descriTextField.text.length == 0) {
        realNickStr = @"";
    }else if (self.addressCell.descriTextField.text && self.addressCell.descriTextField.text.length !=  0){
        realAddressStr = self.addressCell.descriTextField.text;

    }
        // 保存性别
    if (self.sexWay) {
        realSex = @"女";
    }else{
        realSex = @"男";
    }
    
    NSString *updateUserInfoUrl = [NSString stringWithFormat:BASEURL,kupdateUserInfo];
    /*
     "userid": "560539bea694336c25c3acb9",
     "name": "李亚飞",
     "nickname": "",
     "email": "",
     "headportrait": "",
     "address": "北京市",
     "gender": "男",
     "signature": "好好学习天天向上"
     }
     */
    NSLog(@"realNickStr= %@,realNameStr = %@,realAddressStr = %@,realSex = %@",realNickStr,realNameStr,realAddressStr,realSex);
    
    NSDictionary *dicParam = @{@"nickname":realNickStr,
                               @"userid":[AcountManager manager].userid,
                               @"name":realNameStr,
                               @"address":realAddressStr,
                               @"gender":realSex};
    
    
    [JENetwoking startDownLoadWithUrl:updateUserInfoUrl postParam:dicParam WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        NSDictionary *dataParam = data;
        NSNumber *messege = dataParam[@"type"];
        if (messege.intValue == 1) {
            [self obj_showTotasViewWithMes:@"修改成功"];
            [AcountManager saveUserName:realNameStr];
            [AcountManager saveUserAddress:realAddressStr];
            [AcountManager saveUserGender:realSex];
            [AcountManager saveUserNickName:realNickStr];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [self obj_showTotasViewWithMes:@"修改失败"];
            return;
        }
        
    }];


}
#pragma mark ---- 选择图片
- (void)pickImage:(UITapGestureRecognizer *)tapRecognizer{
        [JEPhotoPickManger pickPhotofromController:self];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.strArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (1 == indexPath.row) {
        NSString *cellID = @"sexID";
        EditorDetailSexCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
           
            cell = [[EditorDetailSexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak typeof(self) ws = self;
        cell.sexWayBlock = ^(BOOL sexWay){
            ws.sexWay = sexWay;
        };
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }else{
        NSString *cellID = @"TopID";
        EditorDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
             NSInteger tag = [self.tagArray[indexPath.row] integerValue];
            cell = [[EditorDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID tag:tag];
        }
        if (3 == indexPath.row) {
            cell.descriTextField.userInteractionEnabled = NO;
        }
        if (0 == indexPath.row) {
            self.nameCell = cell;
        }if (2 == indexPath.row) {
            self.nickCell = cell;
        }if (4 == indexPath.row) {
            self.addressCell = cell;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.toplabel.text = self.strArray[indexPath.row];
        cell.descriTextField.text = self.descrArray[indexPath.row];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    
}



#pragma mark - delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    DYNSLog(@"imageData = %@",[AcountManager manager].userid);

    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *photoImage = [info valueForKey:UIImagePickerControllerEditedImage];
    NSData *photeoData = UIImageJPEGRepresentation(photoImage, 0.5);
    self.iconImgView.image = photoImage;

    __weak EditorDetailController *weakself = self;
    __block NSData *gcdPhotoData = photeoData;
    NSString *qiniuUrl = [NSString stringWithFormat:BASEURL,kQiniuUpdateUrl];
    [JENetwoking startDownLoadWithUrl:qiniuUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {

        NSDictionary *dataDic = data;
        weakself.qiniuToken = dataDic[@"data"];
        QNUploadManager *upLoadManager = [[QNUploadManager alloc] init];
        NSString *keyUrl = [NSString stringWithFormat:@"%@-%@.png",[NSString currentTimeDay],[AcountManager manager].userid];
        [upLoadManager putData:gcdPhotoData key:keyUrl token:weakself.qiniuToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
            if (info) {

                NSString *upImageUrl = [NSString stringWithFormat:kQiniuImageUrl,key];
                NSString *updateUserInfoUrl = [NSString stringWithFormat:BASEURL,kupdateUserInfo];
                NSDictionary *headPortrait  = @{@"originalpic":upImageUrl,@"thumbnailpic":@"",@"width":@"",@"height":@""};

                NSDictionary *dicParam = @{@"headportrait":[JsonTransformManager dictionaryTransformJsonWith:headPortrait],@"userid":[AcountManager manager].userid};
                [JENetwoking startDownLoadWithUrl:updateUserInfoUrl postParam:dicParam WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
                    NSDictionary *dataParam = data;
                    NSNumber *messege = dataParam[@"type"];
                    if (messege.intValue == 1) {
                        [self showTotasViewWithMes:@"修改成功"];
                        [AcountManager saveUserHeadImageUrl:upImageUrl];
                        [weakself.iconImgView sd_setImageWithURL:[NSURL URLWithString:[AcountManager manager].userHeadImageUrl] placeholderImage:[UIImage imageWithData:gcdPhotoData]];
                        [[NSNotificationCenter defaultCenter] postNotificationName:kiconImage object:nil];

                    }else {
                        [self showTotasViewWithMes:@"修改失败"];

                        return;
                    }
                }];
            }
        } option:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (UIView *)bgheaderView{
    if (_bgheaderView == nil) {
        _bgheaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
        _bgheaderView.backgroundColor = [UIColor clearColor];
        
    }
    return _bgheaderView;
}
- (UIImageView *)iconImgView{
    if (_iconImgView == nil) {
        _iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake((kSystemWide - 60)/2, 20, 60, 60)];
        [_iconImgView.layer setMasksToBounds:YES];
        [_iconImgView.layer setCornerRadius:30];
        [_iconImgView sd_setImageWithURL:(NSURL *)[AcountManager manager].userHeadImageUrl placeholderImage:[UIImage imageNamed:@"side_user_header"] completed:nil];
    }
    return _iconImgView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (3 == indexPath.row) {
        // 绑定手机号
        ModifyPhoneNumViewController *ModifyPhoneVC = [[ModifyPhoneNumViewController alloc] init];
        [self.navigationController pushViewController:ModifyPhoneVC animated:YES];
    }
}
@end
