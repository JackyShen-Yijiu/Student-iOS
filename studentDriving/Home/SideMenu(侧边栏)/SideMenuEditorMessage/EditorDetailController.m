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
static NSString *const kupdateUserInfo = @"userinfo/updateuserinfo";

@interface EditorDetailController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *strArray;
@property (nonatomic, strong) NSArray *descrArray;
@property (nonatomic, strong) UIView *bgheaderView;
@property (nonatomic, strong) UIImageView *iconImgView;
@property (strong, nonatomic) NSString *qiniuToken;
@end

@implementation EditorDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"编辑信息";
    [self.view addSubview:self.tableView];
    [self.bgheaderView addSubview:self.iconImgView];
    self.tableView.tableHeaderView = self.bgheaderView;
    UITapGestureRecognizer *tapGestureRe = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickImage:)];
    [self.iconImgView addGestureRecognizer:tapGestureRe];
    self.iconImgView.userInteractionEnabled = YES;
    [self initData];
    
}
- (void)initData{
    self.strArray = @[@"姓名",@"",@"昵称",@"绑定手机号",@"我的地址"];
    NSString *nameStr = nil;
    NSString *nickStr = nil;
    NSString *phoneStr = nil;
    NSString *addressSre = nil;
    
    // 姓名
    if ([[AcountManager manager].userName isEqualToString:@""]) {
        nameStr = @"暂无姓名";
    }else{
        nameStr = [AcountManager manager].userName;
    }
    // 昵称
    if ([[AcountManager manager].userNickName isEqualToString:@""]) {
        nickStr = @"暂无昵称";
    }else{
        nickStr = [AcountManager manager].userNickName;
    }
    // 绑定手机号
    if ([[AcountManager manager].userMobile isEqualToString:@""]) {
        phoneStr = @"暂无手机号";
    }else{
        phoneStr = [AcountManager manager].userMobile;
    }
    // 我的地址
    if ([[AcountManager manager].userAddress isEqualToString:@""]) {
        addressSre = @"暂无地址";
    }else{
        addressSre = [AcountManager manager].userAddress;
    }
    self.descrArray = @[nameStr,@"",nickStr,phoneStr,addressSre];

}
#pragma mark ---- 选择图片
- (void)pickImage:(UITapGestureRecognizer *)tapRecognizer{
        [JEPhotoPickManger pickPhotofromController:self];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.strArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (1 == indexPath.row) {
        NSString *cellID = @"sexID";
        EditorDetailSexCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[EditorDetailSexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        NSString *cellID = @"TopID";
        EditorDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[EditorDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.toplabel.text = self.strArray[indexPath.row];
        cell.descriTextField.text = self.descrArray[indexPath.row];
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
        [_iconImgView sd_setImageWithURL:(NSURL *)[AcountManager manager].userHeadImageUrl placeholderImage:nil completed:nil];
    }
    return _iconImgView;
}
@end
