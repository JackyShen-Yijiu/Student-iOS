//
//  EditorUserViewController.m
//  BlackCat
//
//  Created by bestseller on 15/9/18.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "EditorUserViewController.h"
#import "PFActionSheetView.h"
#import "JEPhotoPickManger.h"
#import "ModifyPhoneNumViewController.h"
#import "GenderViewController.h"
#import "SignatureViewController.h"
#import "ModifyNameViewController.h"
#import "ModifyNickNameViewController.h"
#import "CommonAddressViewController.h"
#import <QiniuSDK.h>
#import "JsonTransformManager.h"
static NSString *const kupdateUserInfo = @"userinfo/updateuserinfo";


@interface EditorUserViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) UIImageView *userHeadImage;
@property (strong, nonatomic) NSArray *detailDataArray;
@property (strong, nonatomic) NSString *qiniuToken;
@end

@implementation EditorUserViewController

- (NSArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = @[@[@"头像",@"名字",@"昵称",@"性别",@"个性签名"],@[@"绑定手机号",@"常用地址"]];
    }
    return _dataArray;
}

- (NSArray *)detailDataArray {
    _detailDataArray = @[@[@"",[AcountManager manager].userName,[AcountManager manager].userNickName,[AcountManager manager].userGender,[AcountManager manager].userSignature],@[[AcountManager manager].userDisplaymobile,[AcountManager manager].userAddress]];
    return _detailDataArray;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"编辑信息";
    
    
    [self.view addSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(genderChange) name:kGenderChange object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signatureChange) name:kSignatureChange object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nameChange) name:kmodifyNameChange object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nickNameChange) name:kmodifyNickNameChange object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addAddressChange) name:kaddAddressChange object:nil];

}
- (void)addAddressChange {
    NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)nickNameChange {
    NSIndexPath *path = [NSIndexPath indexPathForRow:2 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)nameChange {
    NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)genderChange {
    NSIndexPath *path = [NSIndexPath indexPathForRow:3 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)signatureChange {
    NSIndexPath *path = [NSIndexPath indexPathForItem:4 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0 && indexPath.row == 0) {
        return 80;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.dataArray[section];
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    if (indexPath.row == 0 && indexPath.section == 0) {
        self.userHeadImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        cell.accessoryView = self.userHeadImage;
        if ([AcountManager manager].userHeadImageUrl) {
            DYNSLog(@"imageUrl = %@",[AcountManager manager].userHeadImageUrl);
            [self.userHeadImage sd_setImageWithURL:[NSURL URLWithString:[AcountManager manager].userHeadImageUrl]placeholderImage:[UIImage imageNamed:@"side_user_header"]];
        }
        self.userHeadImage.backgroundColor = MAINCOLOR;
    }else {
        DYNSLog(@"reload = %@ %@",self.detailDataArray[indexPath.section][indexPath.row],[AcountManager manager].userName);
        cell.detailTextLabel.text = self.detailDataArray[indexPath.section][indexPath.row];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];

    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        [JEPhotoPickManger pickPhotofromController:self];
    }else if (indexPath.section == 1 && indexPath.row == 0) {
        ModifyPhoneNumViewController *modify = [[ModifyPhoneNumViewController alloc] init];
        [self.navigationController pushViewController:modify animated:YES];
    }else if (indexPath.section == 0 && indexPath.row == 1) {
        ModifyNameViewController *modifyName = [[ModifyNameViewController alloc] init];
        [self.navigationController pushViewController:modifyName animated:YES];
    }else if (indexPath.section == 0 && indexPath.row == 2) {
        ModifyNickNameViewController *modifyNickName = [[ModifyNickNameViewController alloc] init];
        [self.navigationController pushViewController:modifyNickName animated:YES];
    }
    else if (indexPath.section == 0 && indexPath.row == 3) {
        GenderViewController *gender = [[GenderViewController alloc] init];
        [self.navigationController pushViewController:gender animated:YES];
    }
    else if (indexPath.section == 0 && indexPath.row == 4) {
        SignatureViewController *signature = [[SignatureViewController alloc] init];
        [self.navigationController pushViewController:signature animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 1) {
        CommonAddressViewController *commonAddress = [[CommonAddressViewController alloc] init];
        [self.navigationController pushViewController:commonAddress animated:YES];
    }
}

#pragma mark - delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    DYNSLog(@"imageData = %@",[AcountManager manager].userid);
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *photoImage = [info valueForKey:UIImagePickerControllerEditedImage];
    NSData *photeoData = UIImageJPEGRepresentation(photoImage, 0.5);
    self.userHeadImage.image = photoImage;
    
    __weak EditorUserViewController *weakself = self;
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
                        [weakself.userHeadImage sd_setImageWithURL:[NSURL URLWithString:[AcountManager manager].userHeadImageUrl] placeholderImage:[UIImage imageWithData:gcdPhotoData]];

                    }else {
                        [self showTotasViewWithMes:@"修改失败"];

                        return;
                    }
                }];
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
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
