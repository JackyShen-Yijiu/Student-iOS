//
//  EditorMessageController.m
//  studentDriving
//
//  Created by zyt on 16/2/23.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "EditorMessageController.h"
#import "EditorMessageCell.h"
#import "EditorBottomCell.h"
#import "EditorTopCell.h"
#import "JEPhotoPickManger.h"
#import <QiniuSDK.h>

static NSString *const kupdateUserInfo = @"userinfo/updateuserinfo";

@interface EditorMessageController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *descriArray;
@property (strong, nonatomic) NSString *qiniuToken;
@end

@implementation EditorMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"个人中心";
    [self initData];
    
}
- (void)initData{
    self.titleArray = @[@"",@"报考驾校",@"报考班型",@"报考车型",@"我的喜欢",@"报名详情"];
    if ([[AcountManager manager].userApplystate isEqualToString:@"0"] || [[AcountManager manager].userApplystate isEqualToString:@"1"]) {
        self.descriArray = @[@"",@"尚未报名",@"尚未报名",@"尚未报名"];
    }
    if ([[AcountManager manager].userApplystate isEqualToString:@"2"]) {
        self.descriArray = @[@"",[AcountManager manager].applyschool.name,[AcountManager manager].applyclasstype.name,[AcountManager manager].userCarmodels.name];
    }
    
    /*
     @property (readonly,strong, nonatomic) ApplyclasstypeinfoModel *applyclasstype;
     @property (readonly,strong, nonatomic) ApplycoachinfoModel *applycoach;
     @property (readonly,strong, nonatomic) ApplyschoolinfoModel *applyschool;
     @property (readonly,strong, nonatomic) ExamCarModel *userCarmodels;
     */

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (0 == indexPath.row) {
        NSString *cellID = @"TopID";
        EditorTopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[EditorTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (1 == indexPath.row || 2 == indexPath.row || 3 == indexPath.row) {
        NSString *cellID = @"signUpID";
        EditorMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[EditorMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = self.titleArray[indexPath.row];
        cell.describeLabel.text = self.descriArray[indexPath.row];
        return cell;

    }
    if (4 == indexPath.row || 5 == indexPath.row) {
        NSString *cellID = @"EditorID";
        EditorBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[EditorBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.titleLabel.text = self.titleArray[indexPath.row];
        return cell;
        
    }
    return nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.row) {
        // 头像编辑
//        [JEPhotoPickManger pickPhotofromController:self];
    }
    if (4 == indexPath.row) {
        // 我的喜欢
    }
    if (5 == indexPath.row) {
        // 报名详情
    }
}
//#pragma mark - delegate
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    DYNSLog(@"imageData = %@",[AcountManager manager].userid);
//    
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    UIImage *photoImage = [info valueForKey:UIImagePickerControllerEditedImage];
//    NSData *photeoData = UIImageJPEGRepresentation(photoImage, 0.5);
////    self.userHeadImage.image = photoImage;
//    
//    __weak EditorMessageController *weakself = self;
//    __block NSData *gcdPhotoData = photeoData;
//    NSString *qiniuUrl = [NSString stringWithFormat:BASEURL,kQiniuUpdateUrl];
//    [JENetwoking startDownLoadWithUrl:qiniuUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
//        
//        NSDictionary *dataDic = data;
//        weakself.qiniuToken = dataDic[@"data"];
//        QNUploadManager *upLoadManager = [[QNUploadManager alloc] init];
//        NSString *keyUrl = [NSString stringWithFormat:@"%@-%@.png",[NSString currentTimeDay],[AcountManager manager].userid];
//        [upLoadManager putData:gcdPhotoData key:keyUrl token:weakself.qiniuToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//            if (info) {
//                
//                NSString *upImageUrl = [NSString stringWithFormat:kQiniuImageUrl,key];
//                NSString *updateUserInfoUrl = [NSString stringWithFormat:BASEURL,kupdateUserInfo];
//                NSDictionary *headPortrait  = @{@"originalpic":upImageUrl,@"thumbnailpic":@"",@"width":@"",@"height":@""};
//                
//                NSDictionary *dicParam = @{@"headportrait":[JsonTransformManager dictionaryTransformJsonWith:headPortrait],@"userid":[AcountManager manager].userid};
//                [JENetwoking startDownLoadWithUrl:updateUserInfoUrl postParam:dicParam WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
//                    NSDictionary *dataParam = data;
//                    NSNumber *messege = dataParam[@"type"];
//                    if (messege.intValue == 1) {
//                        [self showTotasViewWithMes:@"修改成功"];
//                        [AcountManager saveUserHeadImageUrl:upImageUrl];
////                        [weakself.userHeadImage sd_setImageWithURL:[NSURL URLWithString:[AcountManager manager].userHeadImageUrl] placeholderImage:[UIImage imageWithData:gcdPhotoData]];
//                        
//                    }else {
//                        [self showTotasViewWithMes:@"修改失败"];
//                        
//                        return;
//                    }
//                }];
//            }
//        } option:nil];
//    }];
//}

@end
