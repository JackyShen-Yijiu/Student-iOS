//
//  YBUserCenterController.m
//  studentDriving
//
//  Created by 大威 on 16/3/1.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBUserCenterController.h"
#import "YBUserCenterCell.h"
#import "YBUserCenterHeaderCell.h"
#import "DVVImagePickerControllerManager.h"
#import <QiniuSDK.h>
#import "YBEditUserInfoController.h"
#import "ModifyPhoneNumViewController.h"

static NSString *headerCellIdentifier = @"headerCellIdentifier";
static NSString *cellIdentifier = @"kCellIdentifier";

@interface YBUserCenterController ()<UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *userInfoIconArray;
@property (nonatomic, strong) NSArray *userInfoTitleArray;
@property (nonatomic, strong) NSMutableArray *userInfoDetailArray;

@property (nonatomic, strong) NSArray *applyInfoIconArray;
@property (nonatomic, strong) NSArray *applyInfoTitleArray;
@property (nonatomic, strong) NSMutableArray *applyInfoDetailArray;

@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation YBUserCenterController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    self.title = @"个人中心";
    self.edgesForExtendedLayout = NO;
    
    _userInfoIconArray = @[ @"nickname", @"name", @"sexual", @"phone", @"address" ];
    _userInfoTitleArray = @[ @"昵称", @"姓名", @"性别", @"手机号码", @"地址" ];
    
    
    _applyInfoIconArray = @[ @"school", @"class", @"permit", @"ic_collect", @"information" ];
    _applyInfoTitleArray = @[ @"驾校", @"班型", @"驾照类型", @"我的收藏", @"报名信息" ];
    
    [self loadData];
    
    [self.view addSubview:self.tableView];
    
    // 注册用户信息改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:YBNotif_ChangeUserInfo object:nil];
}

- (void)loadData {
    
    NSString *nickName = [AcountManager manager].userNickName;
    if (!nickName || !nickName.length) {
        nickName = @"";
    }
    NSString *name = [AcountManager manager].userName;
    if (!name || !name.length) {
        name = @"";
    }
    NSString *gender = [AcountManager manager].userGender;
    if (!gender || !gender.length) {
        gender = @"";
    }
    NSString *mobile = [AcountManager manager].userMobile;
    if (!mobile || !mobile.length) {
        mobile = @"";
    }
    NSString *address = [AcountManager manager].userAddress;
    if (!address || !address.length) {
        address = @"";
    }
    
    _userInfoDetailArray = @[ nickName, name, gender, mobile, address ].mutableCopy;
    
    
    NSString *schoolName = [AcountManager manager].applyschool.name;
    if (!schoolName || !schoolName.length) {
        schoolName = @"";
    }
    NSString *classType = [AcountManager manager].applyclasstype.name;
    if (!classType || !classType.length) {
        classType = @"";
    }
    NSString *drivingType = [AcountManager manager].userCarmodels.code;
    if (!drivingType || !drivingType.length) {
        drivingType = @"";
    }
    
    _applyInfoDetailArray = @[ schoolName, classType, drivingType, @"", @"" ].mutableCopy;
    
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    _tableView.frame = CGRectMake(0, 0, size.width, size.height - 64);
}

#pragma mark - tableView delegate and data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (0 == section) {
        return 1;
    }else if (1 == section) {
        return _userInfoTitleArray.count;
    }else {
        return _applyInfoTitleArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        return 88;
    }else {
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.section) {
        if (0 == indexPath.row) {
            YBUserCenterHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:headerCellIdentifier];
            _iconImageView = cell.iconImageView;
            
            return cell;
        }
    }
    
    YBUserCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (1 == indexPath.section) {
        
        cell.iconImageView.image = [UIImage imageNamed:_userInfoIconArray[indexPath.row]];
        cell.titleLabel.text = _userInfoTitleArray[indexPath.row];
        cell.subTitleLabel.text = _userInfoDetailArray[indexPath.row];
        
        // 隐藏最后一条分割线
        if (indexPath.row == _userInfoTitleArray.count - 1) {
            cell.lineImageView.hidden = YES;
        }else {
            cell.lineImageView.hidden = NO;
        }
        
    }else {
        
        cell.iconImageView.image = [UIImage imageNamed:_applyInfoIconArray[indexPath.row]];
        cell.titleLabel.text = _applyInfoTitleArray[indexPath.row];
        cell.subTitleLabel.text = _applyInfoDetailArray[indexPath.row];
        
        // 去掉前三个的箭头
        if (indexPath.row >= 0 && indexPath.row <= 2) {
            cell.arrowImageView.hidden = YES;
        }else {
            cell.arrowImageView.hidden = NO;
        }
        
        // 隐藏最后一条分割线
        if (indexPath.row == _applyInfoTitleArray.count - 1) {
            cell.lineImageView.hidden = YES;
        }else {
            cell.lineImageView.hidden = NO;
        }
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.section) {
        if (0 == indexPath.row) {
            [DVVImagePickerControllerManager showImagePickerControllerFrom:self delegate:self];
        }
    }else if (1 == indexPath.section) {
        
        if (3 == indexPath.row) {
            ModifyPhoneNumViewController *vc = [ModifyPhoneNumViewController new];
            [self.navigationController pushViewController:vc animated:YES];
            return ;
        }
        YBEditUserInfoController *vc = [YBEditUserInfoController new];
        vc.userInfoDetailArray = _userInfoDetailArray;
        vc.tableView = _tableView;
        if (0 == indexPath.row) {
            vc.editType = YBEditUserInfoType_NickName;
        }else if (1 == indexPath.row) {
            vc.editType = YBEditUserInfoType_Name;
        }else if (2 == indexPath.row) {
            vc.editType = YBEditUserInfoType_Sex;
        }else if (4 == indexPath.row) {
            vc.editType = YBEditUserInfoType_Address;
        }
        vc.defaultString = _userInfoDetailArray[vc.editType];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (2 == indexPath.section) {
        
        if (3 == indexPath.row) {
            // 跳到我的收藏
        }else if (4 == indexPath.row) {
            // 跳到报名信息
        }
    }
}

#pragma mark - imagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    DYNSLog(@"imageData = %@",[AcountManager manager].userid);
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *photoImage = [info valueForKey:UIImagePickerControllerEditedImage];
    NSData *photeoData = UIImageJPEGRepresentation(photoImage, 0.5);
    _iconImageView.image = photoImage;
    
    __weak typeof(self) weakself = self;
    __block NSData *gcdPhotoData = photeoData;
    NSString *qiniuUrl = [NSString stringWithFormat:BASEURL,kQiniuUpdateUrl];
    [JENetwoking startDownLoadWithUrl:qiniuUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSDictionary *dataDic = data;
        NSString *qiniuToken = dataDic[@"data"];
        QNUploadManager *upLoadManager = [[QNUploadManager alloc] init];
        NSString *keyUrl = [NSString stringWithFormat:@"%@-%@.png",[NSString currentTimeDay],[AcountManager manager].userid];
        
        [upLoadManager putData:gcdPhotoData key:keyUrl token:qiniuToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
            if (info) {
                
                NSString *upImageUrl = [NSString stringWithFormat:kQiniuImageUrl,key];
                NSString *updateUserInfoUrl = [NSString stringWithFormat:BASEURL,@"userinfo/updateuserinfo"];
                NSDictionary *headPortrait  = @{@"originalpic":upImageUrl,@"thumbnailpic":@"",@"width":@"",@"height":@""};
                
                NSDictionary *dicParam = @{@"headportrait":[JsonTransformManager dictionaryTransformJsonWith:headPortrait],@"userid":[AcountManager manager].userid};
                [JENetwoking startDownLoadWithUrl:updateUserInfoUrl postParam:dicParam WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
                    NSDictionary *dataParam = data;
                    NSNumber *messege = dataParam[@"type"];
                    if (messege.intValue == 1) {
                        [self showTotasViewWithMes:@"修改成功"];
                        [AcountManager saveUserHeadImageUrl:upImageUrl];
                        [weakself.iconImageView sd_setImageWithURL:[NSURL URLWithString:[AcountManager manager].userHeadImageUrl] placeholderImage:[UIImage imageWithData:gcdPhotoData]];
                        [[NSNotificationCenter defaultCenter] postNotificationName:YBNotif_ChangeUserPortrait object:nil];
                        
                    }else {
                        [self obj_showTotasViewWithMes:@"修改失败"];
                        
                        return;
                    }
                }];
            }
        } option:nil];
    }];
}

#pragma mark - lazy load

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[YBUserCenterHeaderCell class] forCellReuseIdentifier:headerCellIdentifier];
        [_tableView registerClass:[YBUserCenterCell class] forCellReuseIdentifier:cellIdentifier];
    }
    return _tableView;
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
