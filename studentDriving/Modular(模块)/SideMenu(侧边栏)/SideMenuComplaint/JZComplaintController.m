//
//  JZComplaintController.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/10.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZComplaintController.h"
#import "YBMyComplaintListController.h"
#import "JZComplaintHeaderView.h"
#import "JZComplaintLeftView.h"
#import "JZComplaintRightView.h"
#import "NSString+Helper.h"
#import "CoachListController.h"
#import "DVVImagePickerControllerManager.h"
#import "QNUploadManager.h"
#import "CoachListDMData.h"
#import "JZMyComplaintListController.h"


#define kLKSize [UIScreen mainScreen].bounds.size
//static NSString * const contentCellID = @"contentCellID";
@interface JZComplaintController ()<UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,complaintPushCoachDetail,BackCoachCompalaintModelDelegate>

///  顶部
@property (nonatomic, weak)  JZComplaintHeaderView *headerView;

///  滚动父视图
@property (nonatomic, weak) UIScrollView *contentScrollView;

///  左侧
@property (nonatomic, weak) JZComplaintLeftView *leftView;

///  右侧
@property (nonatomic, weak) JZComplaintRightView *rightView;

@property (nonatomic, weak) UIImagePickerController *picker;
///  投诉教练照片数组数组
@property (nonatomic,strong) NSMutableArray *picArray;

///  投诉驾校照片url数组
@property(nonatomic,strong)NSMutableArray *picArrSchool;

@property (nonatomic, strong) CoachListDMData *complaintCoachModel;

@property (nonatomic ,copy) NSString *coachId;
/// 投诉教练的url
@property (nonatomic, strong) NSString *picListURL;


@end

@implementation JZComplaintController

- (NSMutableArray *)picArray
{
    if (_picArray==nil) {
        _picArray = [NSMutableArray array];
    }
    return _picArray;
}

-(NSMutableArray *)picArrSchool {
    
    if (_picArrSchool ==nil) {
        
        _picArrSchool = [NSMutableArray array];
        
        
    }
    return _picArrSchool;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"投诉";
    
    self.view.backgroundColor = RGBColor(232, 232, 237);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"我的投诉" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarDidClick)];
    [self.navigationItem.rightBarButtonItem
     setTitleTextAttributes:[NSDictionary
                             dictionaryWithObjectsAndKeys:[UIFont
                                                           boldSystemFontOfSize:14], NSFontAttributeName,nil] forState:UIControlStateNormal];
    [self setUI];
    
    self.leftView.complaintPushCoachDetailDelegate = self;
    
    [self click];
    
}
#pragma mark - 点击事件
-(void)click {
    [self.headerView.headerLeftBtn addTarget:self action:@selector(clickHeaderLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView.headerRightBtn addTarget:self action:@selector(clickHeaderRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.leftView.addImageBtn addTarget:self action:@selector(addImageClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightView.addImgBtn addTarget:self action:@selector(addImageClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.leftView.putInBtn addTarget:self action:@selector(leftViewPutInClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightView.putInBtn addTarget:self action:@selector(rightViewPutInClick:) forControlEvents:UIControlEventTouchUpInside];
    
       

}
#pragma mark - 主界面视图设置
-(void)setUI {
    
    JZComplaintHeaderView *headerView = [[JZComplaintHeaderView alloc]initWithFrame:CGRectMake(0, 0, kLKSize.width, 44)];
    self.headerView = headerView;
    [self.view addSubview:headerView];
    
    
    UIScrollView *contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 54, kLKSize.width, kLKSize.height - 54)];
    contentScrollView.showsVerticalScrollIndicator = NO;
    contentScrollView.showsHorizontalScrollIndicator = NO;
    contentScrollView.pagingEnabled = YES;
    contentScrollView.bounces = NO;
    contentScrollView.contentSize = CGSizeMake(kLKSize.width * 2, kLKSize.height - 54);
    self.contentScrollView = contentScrollView;
//    contentScrollView.backgroundColor = [UIColor cyanColor];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:contentScrollView];
    
    JZComplaintLeftView *leftView = [[JZComplaintLeftView alloc]initWithFrame:CGRectMake(0, 0, kLKSize.width, kLKSize.height - 54)];
    self.leftView = leftView;
    [self.contentScrollView addSubview:leftView];
    
    
    JZComplaintRightView *rightView = [[JZComplaintRightView alloc]initWithFrame:CGRectMake(contentScrollView.contentSize.width *0.5, 0, kLKSize.width, kLKSize.height - 54)];
    self.rightView = rightView;
    [self.contentScrollView addSubview:rightView];
    
    
    self.contentScrollView.delegate = self;
    
    
}
#pragma mark - Bar右侧--我的投诉
- (void)rightBarDidClick{
//    YBMyComplaintListController *vc = [[YBMyComplaintListController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    JZMyComplaintListController *listVC = [[JZMyComplaintListController alloc]init];
    
    
    
    [self.navigationController pushViewController:listVC animated:YES];
}

#pragma mark - scrollView的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"移动移动---%@",NSStringFromCGPoint(self.contentScrollView.contentOffset));
    if (self.contentScrollView.contentOffset.x == kLKSize.width) {
        
        [self clickHeaderRightBtn:self.headerView.headerRightBtn];
        
    }else {
        
        [self clickHeaderLeftBtn:self.headerView.headerLeftBtn];
        
    }
}

#pragma mark - 顶部按钮点击事件
-(void)clickHeaderLeftBtn:(UIButton *)sender {
    
    [self.headerView.headerLeftBtn setTitleColor:YBNavigationBarBgColor forState:UIControlStateNormal];
    [self.headerView.headerRightBtn setTitleColor:TEXTGRAYCOLOR forState:UIControlStateNormal];
    
    if (self.headerView.herderLineView.frame.origin.x != 0) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            [self.contentScrollView setContentOffset:CGPointMake(0, 0)];
            
            self.headerView.herderLineView.transform = CGAffineTransformMakeTranslation(0,0);
            
        }];
        
        
    }
    
}
-(void)clickHeaderRightBtn:(UIButton *)sender  {
    
    
    [self.headerView.headerRightBtn setTitleColor:YBNavigationBarBgColor forState:UIControlStateNormal];
    [self.headerView.headerLeftBtn setTitleColor:TEXTGRAYCOLOR forState:UIControlStateNormal];
    [UIView animateWithDuration:0.25 animations:^{
        
        [self.contentScrollView setContentOffset:CGPointMake(kLKSize.width, 0)];
        
        self.headerView.herderLineView.transform = CGAffineTransformMakeTranslation(kLKSize.width * 0.5,0);
        
    }];
    
}

#pragma mark - 添加照片
-(void)addImageClick:(UIButton *)sender {
    
    [DVVImagePickerControllerManager showImagePickerControllerFrom:self delegate:self];
 
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
   
    UIImage *photoImage = [info valueForKey:UIImagePickerControllerEditedImage];
    
    
    
    if(self.contentScrollView.contentOffset.x == kLKSize.width)
    {
       
        
        if (!self.rightView.firstImageView.image)
        {
            
            self.rightView.firstImageView.hidden = NO;
            
            self.rightView.firstImageView.image = photoImage;
            
            self.rightView.firstImageView.frame = CGRectMake(self.rightView.complaintInfoText.origin.x, self.rightView.addImgBtn.frame.origin.y, self.rightView.addImgBtn.bounds.size.width, self.rightView.addImgBtn.bounds.size.height);
            
            self.rightView.addImgBtn.transform = CGAffineTransformMakeTranslation(90,0);
            
            
        }else {
            
            self.rightView.firstImageView.hidden = NO;
            self.rightView.secondImageView.hidden = NO;
            
            self.rightView.secondImageView.image = photoImage;
            
            self.rightView.secondImageView.frame = CGRectMake(self.leftView.complaintInfoText.origin.x+90, self.leftView.addImageBtn.frame.origin.y, self.leftView.addImageBtn.bounds.size.width, self.leftView.addImageBtn.bounds.size.height);
            
            self.rightView.addImgBtn.hidden = YES;
            
            
        }
    }else {
        
        
        if (!self.leftView.firstImageView.image) {
            
            self.rightView.firstImageView.hidden = YES;
            self.rightView.secondImageView.hidden = YES;
            
            self.leftView.firstImageView.hidden = NO;
            
            self.leftView.firstImageView.image = photoImage;
            
            self.leftView.firstImageView.frame = CGRectMake(self.leftView.complaintInfoText.origin.x, self.leftView.addImageBtn.frame.origin.y, self.leftView.addImageBtn.bounds.size.width, self.leftView.addImageBtn.bounds.size.height);
            
            self.leftView.addImageBtn.transform = CGAffineTransformMakeTranslation(90,0);
            
        }else {
            
            self.leftView.firstImageView.hidden = NO;
            self.leftView.secondImageView.hidden = NO;
            
            self.leftView.secondImageView.image = photoImage;
            
            self.leftView.secondImageView.frame = CGRectMake(self.leftView.complaintInfoText.origin.x+90, self.leftView.addImageBtn.frame.origin.y, self.leftView.addImageBtn.bounds.size.width, self.leftView.addImageBtn.bounds.size.height);
            
            self.leftView.addImageBtn.hidden = YES;
            
        }
        
    }

    NSData *photeoData = UIImageJPEGRepresentation(photoImage, 0.5);
    
    __block NSData *gcdPhotoData = photeoData;
    
    NSString *qiniuUrl = [NSString stringWithFormat:BASEURL,kQiniuUpdateUrluserFeedback];
    
    [JENetwoking startDownLoadWithUrl:qiniuUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSDictionary *dataDic = data;
        NSString *qiniuToken = dataDic[@"data"];
        QNUploadManager *upLoadManager = [[QNUploadManager alloc] init];
        NSString *keyUrl = [NSString stringWithFormat:@"%@-%@.png",[NSString currentTimeDay],[AcountManager manager].userid];
        
        [upLoadManager putData:gcdPhotoData key:keyUrl token:qiniuToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
            
            NSLog(@"upLoadManager resp:%@",resp);
            
            if (resp) {
                
//                NSLog(@"%@",key);
                
                
                NSString *upImageUrl = [NSString stringWithFormat:kQiniuImageUrl,key];
                
            
                
                if(self.contentScrollView.contentOffset.x == kLKSize.width)
                {
                    [self.picArrSchool addObject:upImageUrl];


                    
                    
                }else {
                    
                    
                    
                    [self.picArray addObject:upImageUrl];
                    
                   
                        
                    }
            }
        } option:nil];
    }];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - 点击提交按钮的方法
// 提交投诉信息
- (void)leftViewPutInClick:(UIButton *)btn{
    [self leftViewNetworkRequest];
}
- (void)rightViewPutInClick:(UIButton *)btn{
    [self rightViewNetworkRequest];
}

- (void)leftViewNetworkRequest {
    if (self.leftView.phoneNumTf.text == nil || self.leftView.phoneNumTf.text.length  == 0) {
        [self obj_showTotasViewWithMes:@"请输入手机号"];
        
        return;
    }
    
    
    if (![AcountManager isValidateMobile:self.leftView.phoneNumTf.text]) {
        [self obj_showTotasViewWithMes:@"请输入正确的手机号"];
        return;
    }
    
    
    if (!self.leftView.complaintInfoText.text.length) {
        [self obj_showTotasViewWithMes:@"请输入投诉原因"];
        
        return ;
    }
    

    
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionary];
    // 用户id 可以空
    if ([AcountManager manager].userid.length) {
        [parmDict setValue:[AcountManager manager].userid forKey:@"userid"];
    }
    // 反馈信息 必填
    [parmDict setValue:self.leftView.complaintInfoText.text forKey:@"feedbackmessage"];
    // 手机型号
    NSString *deviceModel = [NSString getCurrentDeviceModel];
    if (!deviceModel) {
        deviceModel = @"未知";
    }
    [parmDict setValue:deviceModel forKey:@"mobileversion"];
    
    
    ///  教练id和驾校id
    [parmDict setValue:self.coachId forKey:@"coachid"];
    
    [parmDict setValue:[AcountManager manager].applyschool.infoId forKey:@"schoolid"];
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
    
    BOOL isNoName = self.leftView.anonymitySwitch;
    
    int anonymity = isNoName ? 1 : 0;
    
    
    [parmDict setValue:[NSString stringWithFormat:@"%d", anonymity] forKey:@"feedbackusertype"];
    // 投诉人手机号
    if ([AcountManager manager].userMobile) {
        [parmDict setValue:[AcountManager manager].userMobile forKey:@"moblie"];
    }
    // 被投诉姓名
    [parmDict setValue:self.leftView.coachNameLabel.text forKey:@"becomplainedname"];
    
    
    
    if (self.picArray.count == 1) {
       
        self.picListURL = self.picArray[0];
        
        
    }else if (self.picArray.count == 2) {
        
        NSString *picURl = self.picArray[0];
        
        
        self.picListURL = [picURl stringByAppendingFormat:@",%@",self.picArray[2]];
            

    }
    
    [parmDict setValue:self.picListURL forKey:@"piclist"];
    
    
    DYNSLog(@"%@", parmDict);
    [JENetwoking startDownLoadWithUrl:[NSString stringWithFormat:BASEURL, @"userfeedback"] postParam:parmDict WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        NSDictionary *dict = data;
        NSInteger type = [[dict objectForKey:@"type"] integerValue];
        if (type) {
            [self obj_showTotasViewWithMes:@"投诉成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [self obj_showTotasViewWithMes:@"投诉失败"];
        }
        
    } withFailure:^(id data) {
        [self obj_showTotasViewWithMes:@"投诉失败"];
    }];
}
- (void)rightViewNetworkRequest {
    
    NSLog(@"self.complaintCoachModel.name = %@",self.complaintCoachModel.name);
    
    
    
    
    if (self.rightView.phoneNumTf.text == nil || self.rightView.phoneNumTf.text.length  == 0) {
        [self obj_showTotasViewWithMes:@"请输入手机号"];
        
        return;
    }
    
    
    if (![AcountManager isValidateMobile:self.rightView.phoneNumTf.text]) {
        [self obj_showTotasViewWithMes:@"请输入正确的手机号"];
        return;
    }
    
    
    if (!self.rightView.complaintInfoText.text.length) {
        [self obj_showTotasViewWithMes:@"请输入投诉原因"];
        
        return ;
    }
    

    
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionary];
    // 用户id 可以空
    if ([AcountManager manager].userid.length) {
        [parmDict setValue:[AcountManager manager].userid forKey:@"userid"];
    }
    // 反馈信息 必填
    [parmDict setValue:self.rightView.complaintInfoText.text forKey:@"feedbackmessage"];
    
    [parmDict setValue:self.picArrSchool forKey:@"piclist"];
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
    [parmDict setValue:@"2" forKey:@"feedbacktype"];
    // 投诉类型 0 匿名投诉 1 实名投诉
    
    BOOL isNoName = self.rightView.anonymitySwitch;
    
    int anonymity = isNoName ? 1 : 0;
    
    NSLog(@"是否是匿名%d",anonymity);
    
    
    [parmDict setValue:[NSString stringWithFormat:@"%d", anonymity] forKey:@"feedbackusertype"];
    // 投诉人手机号
    if ([AcountManager manager].userMobile) {
        [parmDict setValue:[AcountManager manager].userMobile forKey:@"moblie"];
    }
    // 被投诉姓名
    [parmDict setValue:self.rightView.schoolNameLabel.text forKey:@"becomplainedname"];
    DYNSLog(@"%@", parmDict);
    

    
    [parmDict setValue:[AcountManager manager].applyschool.infoId forKey:@"schoolid"];
    
    
    [JENetwoking startDownLoadWithUrl:[NSString stringWithFormat:BASEURL, @"userfeedback"] postParam:parmDict WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        NSDictionary *dict = data;
        NSInteger type = [[dict objectForKey:@"type"] integerValue];
        if (type) {
            [self obj_showTotasViewWithMes:@"投诉成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [self obj_showTotasViewWithMes:@"投诉失败"];
        }
        
    } withFailure:^(id data) {
        [self obj_showTotasViewWithMes:@"投诉失败"];
    }];
}

- (void)initWithCoacheModel:(CoachListDMData *)model{
    _complaintCoachModel = model;
    self.leftView.coachNameLabel.text = model.name;
    
    self.coachId = model.coachid;
    [self.leftView.bottomCoachName setTitle:[NSString stringWithFormat:@"投诉%@教练",model.name] forState:UIControlStateNormal];;
    
}


- (void)initWithComplaintPushCoachDetail{
    // 教练详情
    CoachListController *listVC = [CoachListController new];
    listVC.schoolID = [AcountManager manager].applyschool.infoId;
    listVC.type = 1;
    listVC.complaintCoachNameLabel.text = self.leftView.coachNameLabel.text;
    listVC.complaintCoachNameLabelBottom.text = self.leftView.bottomCoachName.titleLabel.text;
    listVC.delagate = self;
    [self.navigationController pushViewController:listVC animated:YES];
}
@end
