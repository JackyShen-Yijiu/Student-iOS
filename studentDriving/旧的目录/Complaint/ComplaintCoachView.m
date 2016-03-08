//
//  ComplaintCoachView.m
//  studentDriving
//
//  Created by 大威 on 16/1/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "ComplaintCoachView.h"
#import "CoachListController.h"
#import "DVVImagePickerControllerManager.h"
#import <QNUploadManager.h>
#import "NetMonitor.h"
#import "NSString+Helper.h"

static NSString *const kupdateUserInfo = @"userinfo/updateuserinfo";

@interface ComplaintCoachView ()

@property (nonatomic, assign) BOOL complaintWay;

@property (nonatomic, assign) NSUInteger photoButtonTag;

@property (nonatomic, strong) UIImage *image_1;
@property (nonatomic, strong) UIImage *image_2;

@property (nonatomic, strong) NSMutableArray *imagesUrlArray;

@end

@implementation ComplaintCoachView

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray  *xibArray = [[NSBundle mainBundle]loadNibNamed:@"ComplaintCoachView" owner:self options:nil];
        ComplaintCoachView *view = xibArray.firstObject;
        self = view;
        
        [_anonymousButton setImage:[UIImage imageNamed:@"cancelSelect_click"] forState:UIControlStateSelected];
        _anonymousButton.selected = YES;
        [_realNameButton setImage:[UIImage imageNamed:@"cancelSelect_click"] forState:UIControlStateSelected];
        _textView.delegate = self;
        
        _photo_2_button.hidden = YES;
        [_photo_1_button setBackgroundImage:[UIImage imageNamed:@"defaul_complaint_icon"] forState:UIControlStateNormal];
        [_photo_2_button setBackgroundImage:[UIImage imageNamed:@"defaul_complaint_icon"] forState:UIControlStateNormal];
        [_okButton setBackgroundColor:MAINCOLOR];
    }
    return self;
}

- (void)textViewDidChange:(UITextView *)textView {
    
    if (0 == textView.text.length) {
        self.placeholderLabel.hidden = NO;
    }else {
        self.placeholderLabel.hidden = YES;
    }
}
- (IBAction)anonymousButtonAction:(UIButton *)sender {
    _complaintWay = 0;
    _realNameButton.selected = NO;
    sender.selected = YES;
}
- (IBAction)realNameButton:(UIButton *)sender {
    _complaintWay = 1;
    _anonymousButton.selected = NO;
    sender.selected = YES;
}


- (IBAction)selectCoachButtonAction:(UIButton *)sender {
    
    CoachListController *listVC = [CoachListController new];
    listVC.schoolID = [AcountManager manager].applyschool.infoId;
    listVC.type = 1;
    listVC.complaintCoachNameLabel = _coachNameLabel;
    [_superController.navigationController pushViewController:listVC animated:YES];
}
- (IBAction)photo_1_buttonAction:(UIButton *)sender {
    
    _photoButtonTag = 1;
    [DVVImagePickerControllerManager showImagePickerControllerFrom:_superController delegate:self];
}
- (IBAction)photo_2_buttonAction:(UIButton *)sender {
    
    _photoButtonTag = 2;
    [DVVImagePickerControllerManager showImagePickerControllerFrom:_superController delegate:self];
}

- (IBAction)okButtonAction:(UIButton *)sender {
    
    if ([_coachNameLabel.text isEqualToString:@"点击选择教练"]) {
        [self obj_showTotasViewWithMes:@"请选择要投诉的教练"];
        return ;
    }
    if (!_textView.text.length) {
        [self obj_showTotasViewWithMes:@"请输入投诉原因"];
        return ;
    }
    
    if (!_image_1) {
        [self networkRequest];
        return ;
    }
    
    _imagesUrlArray = [NSMutableArray array];
    if (_image_1) {
        [self uploadImg:_image_1 type:1];
    }
    if (_image_2) {
        [self uploadImg:_image_2 type:2];
    }
    
}

- (void)uploadImg:(UIImage *)img type:(NSInteger)type
{

    NSData *imgData = UIImageJPEGRepresentation(img, 0.5);

    NSString *qiniuUrl = [NSString stringWithFormat:BASEURL,kQiniuUpdateUrl];
    
    [JENetwoking startDownLoadWithUrl:qiniuUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSDictionary *dataDic = data;
        NSString *qiniuToken = dataDic[@"data"];
        QNUploadManager *upLoadManager = [[QNUploadManager alloc] init];
        
        NSString *keyUrl = [NSString stringWithFormat:@"%@-%@.png",[NSString currentTimeDay],[AcountManager manager].userid];
        
        [upLoadManager putData:imgData key:keyUrl token:qiniuToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
            
            NSLog(@"key:%@ resp:%@",key,resp);
            
            if (type==1) {
                [_imagesUrlArray addObject:key];
                if (!_image_2) {
                    [self networkRequest];
                }
            }else if (type==2){
                [_imagesUrlArray addObject:key];
                [self networkRequest];
            }
            
        } option:nil];
    }];
}

- (void)networkRequest {
    
//    {   "userid":"560539bea694336c25c3acb9",（用户id 可以空）
//        "feedbackmessage":"无法登录", （反馈信息 必填）
//        "mobileversion":"小米 4.00",(手机版本 必填)
//        "network":"wifi",（网络情况 必填）
//        "resolution":"300*400", （分辨率 必填）
//        "appversion":"android 1.00"（app 版本 必填）
//        "feedbacktype": 1, // 反馈类型 0 平台反馈 1 投诉教练 2 投诉驾校
//        "name": "liyafei",
//        "feedbackusertype": 1, //投诉类型 0 匿名投诉 1 实名投诉
//        "moblie": "12345678901", // 投诉人手机号
//        "becomplainedname": "王教练", //被投诉姓名
//        "piclist": "pic1.jpg,pic2.jpg" // 图片列表 ,分割}
    
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionary];
    // 用户id 可以空
    if ([AcountManager manager].userid.length) {
        [parmDict setValue:[AcountManager manager].userid forKey:@"userid"];
    }
    // 反馈信息 必填
    [parmDict setValue:_textView.text forKey:@"feedbackmessage"];
    // 手机型号
    NSString *deviceModel = [NSString getCurrentDeviceModel];
    if (!deviceModel) {
        deviceModel = @"未知";
    }
    [parmDict setValue:deviceModel forKey:@"mobileversion"];
    // 网络情况 必填
    if ([NetMonitor manager].netStateExplain) {
        [parmDict setValue:[NetMonitor manager].netStateExplain forKey:@"network"];
    }
    // 分辨率 必填
    CGSize size = [UIScreen mainScreen].bounds.size;
    [parmDict setValue:[NSString stringWithFormat:@"%.0f*%.0f", size.width, size.height] forKey:@"resolution"];
    // app 版本 必填
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
    [parmDict setValue:[NSString stringWithFormat:@"iOS %@", currentVersion] forKey:@"appversion"];
    // 反馈类型 0 平台反馈 1 投诉教练 2 投诉驾校
    [parmDict setValue:@"1" forKey:@"feedbacktype"];
    // 投诉类型 0 匿名投诉 1 实名投诉
    [parmDict setValue:[NSString stringWithFormat:@"%d", _complaintWay] forKey:@"feedbackusertype"];
    // 投诉人手机号
    if ([AcountManager manager].userMobile) {
        [parmDict setValue:[AcountManager manager].userMobile forKey:@"moblie"];
    }
    // 被投诉姓名
    [parmDict setValue:_coachNameLabel.text forKey:@"becomplainedname"];
    // 上传的所有照片
    if (_imagesUrlArray.count) {
        [parmDict setValue:[_imagesUrlArray componentsJoinedByString:@","] forKey:@"piclist"];
    }
    
    DYNSLog(@"%@", parmDict);
    [JENetwoking startDownLoadWithUrl:[NSString stringWithFormat:BASEURL, @"userfeedback"] postParam:parmDict WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        NSDictionary *dict = data;
        NSInteger type = [[dict objectForKey:@"type"] integerValue];
        if (type) {
            [self obj_showTotasViewWithMes:@"投诉成功"];
            [_superController.navigationController popViewControllerAnimated:YES];
        }else {
            [self obj_showTotasViewWithMes:@"投诉失败"];
        }
        
    } withFailure:^(id data) {
        [self obj_showTotasViewWithMes:@"投诉失败"];
    }];
}

#pragma mark - delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *photoImage = [info valueForKey:UIImagePickerControllerEditedImage];
    
    if (1 == _photoButtonTag) {
        _image_1 = photoImage;
        [_photo_1_button setBackgroundImage:photoImage forState:UIControlStateNormal];
        _photo_2_button.hidden = NO;
    }else {
        _image_2 = photoImage;
        [_photo_2_button setBackgroundImage:photoImage forState:UIControlStateNormal];
    }
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
