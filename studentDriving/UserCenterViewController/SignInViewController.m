//
//  SignInViewController.m
//  studentDriving
//
//  Created by yyx on 15/12/31.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "SignInViewController.h"
#import "ToolHeader.h"
#import "UIBarButtonItem+JGBarButtonItem.h"
#import "SignInHelpViewController.h"
#import "DVVCreateQRCode.h"
#import "Masonry.h"
#import "NSString+Helper.h"
#import <BaiduMapAPI/BMKLocationService.h>
#import <BaiduMapAPI/BMKGeocodeSearch.h>
#import "DVVLocationStatus.h"

@interface SignInViewController ()<BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UIImageView *qrCodeImageView;
@property (nonatomic, strong) UIButton *completeButton;
@property (nonatomic, strong) UILabel *markLabel;

@property (nonatomic, strong) UILabel *explainTitleLabel;
@property (nonatomic, strong) UILabel *explainLabel;

@property (strong, nonatomic) BMKLocationService *locationService;
@property (nonatomic, strong) BMKGeoCodeSearch *geoCodeSearch;
@property (nonatomic, strong) DVVLocationStatus *dvvLocationStatus;

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"签到";
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"使用帮助" highTitle:@"使用帮助" target:self action:@selector(helpDidClick) isRightItem:YES];
    
    [self.view addSubview:self.qrCodeImageView];
    [self.view addSubview:self.completeButton];
    [self.view addSubview:self.markLabel];
    [self.view addSubview:self.explainTitleLabel];
    [self.view addSubview:self.explainLabel];
    
    [self configUI];
    
    [self locationManager];
}

- (NSString *)dateFromLocalWithFormatString:(NSString *)formatString {
    
    NSDate *localDate = [NSDate new];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:formatString];
    return [dateFormatter stringFromDate:localDate];
}

#pragma mark - action
- (void)completeButtonAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 根据内容加载二维码
- (void)showQRCodeImageWithContent:(NSString *)content {
    
    CGFloat size = 160;
    self.qrCodeImageView.image = [DVVCreateQRCode createQRCodeWithContent:content size:size];
}

#pragma mark - config UI
- (void)configUI {
    
    [_completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@44);
        make.left.and.bottom.with.right.equalTo(@0);
    }];
    
    [_qrCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@94);
        make.width.and.height.equalTo(@160);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    [_markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.qrCodeImageView.mas_bottom).offset(15);
    }];
    [_explainTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64 + 15);
        make.height.equalTo(@20);
        make.left.with.right.mas_equalTo(15);
    }];
    [_explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.explainTitleLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
}

#pragma mark - 定位功能
- (void)locationManager {
    
    // 检查定位功能是否可用
    _dvvLocationStatus = [DVVLocationStatus new];
    __weak typeof(self) ws = self;
    [_dvvLocationStatus setSelectCancelButtonBlock:^{
        [ws.navigationController popViewControllerAnimated:YES];
    }];
    [_dvvLocationStatus setSelectOkButtonBlock:^{
        [ws.navigationController popViewControllerAnimated:YES];
    }];
    if (![_dvvLocationStatus checkLocationStatus]) {
        [_dvvLocationStatus remindUser];
        return ;
    }
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    [BMKLocationService setLocationDistanceFilter:10000.0f];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.locationService startUserLocationService];
}

#pragma mark 处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    // 反地理编码，获取城市名
    [self reverseGeoCodeWithLatitude:userLocation.location.coordinate.latitude
                           longitude:userLocation.location.coordinate.longitude];
}
#pragma mark 定位失败
- (void)didFailToLocateUserWithError:(NSError *)error {
    // 这个代理方法会调用两次，导致会弹出两个失败的弹窗 所以在这里将代理设为nil
    self.locationService.delegate = nil;
    [self remindUserLocationError];
}

#pragma mark - 反地理编码
- (BOOL)reverseGeoCodeWithLatitude:(double)latitude
                         longitude:(double)longitude {
    
    // 存储定位到的经纬度
    [AcountManager manager].latitude = [NSString stringWithFormat:@"%f",latitude];
    [AcountManager manager].longitude = [NSString stringWithFormat:@"%f",longitude];
    
    CLLocationCoordinate2D point = (CLLocationCoordinate2D){ latitude, longitude };
    //    CLLocationCoordinate2D point = (CLLocationCoordinate2D){39.929986, 116.395645};
    BMKReverseGeoCodeOption *reverseGeocodeOption = [BMKReverseGeoCodeOption new];
    reverseGeocodeOption.reverseGeoPoint = point;
    // 发起反向地理编码
    BOOL flage = [self.geoCodeSearch reverseGeoCode:reverseGeocodeOption];
    if (flage) {
        //        NSLog(@"反geo检索发送成功");
        return YES;
    }else {
        [self remindUserLocationError];
        //        NSLog(@"反geo检索发送失败");
        return NO;
    }
}
#pragma mark 反地理编码回调
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher
                           result:(BMKReverseGeoCodeResult *)result
                        errorCode:(BMKSearchErrorCode)error {
    
    if (error == BMK_SEARCH_NO_ERROR) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        //        NSLog(@"%@",result);
//        BMKAddressComponent *addressComponent = result.addressDetail;
        //        NSLog(@"addressComponent.city===%@",addressComponent.city);
        // 用户id
        NSString *userId = [AcountManager manager].userid;
        // 用户名
        NSString *userName = [AcountManager manager].userName;
        // 详细地址
        NSString *locationAddress = result.address;
        // 经纬度
        NSString *latitude = [AcountManager manager].latitude;
        NSString *longitude = [AcountManager manager].longitude;
        // 当前的时间(时间戳)
        NSDate *nowDate = [NSDate date];
        NSString *nowTimeStamp = [NSString stringWithFormat:@"%zi", (long)[nowDate timeIntervalSince1970]];
        
        NSLog(@"%@", userId);
        NSLog(@"%@", userName);
        NSLog(@"locationAddress === %@", locationAddress);
        NSLog(@"%@",self.dataModel.ID);
        NSLog(@"%@",self.dataModel.coachDataModel.name);
        NSLog(@"%@",self.dataModel.courseProcessDesc);
        NSString *reservationId = @"";
        if (![self.dataModel.ID isEmptyString]) {
            reservationId = self.dataModel.ID;
        }
        NSString *coachName = @"";
        if (![self.dataModel.coachDataModel.name isEmptyString]) {
            coachName = self.dataModel.coachDataModel.name;
        }
        NSString *courseProcessDesc = @"";
        if (![self.dataModel.courseProcessDesc isEmptyString]) {
            courseProcessDesc = self.dataModel.courseProcessDesc;
        }
        
        NSDictionary *dict = @{ @"studentId": userId,
                                @"studentName": userName,
                                @"reservationId": reservationId,
                                @"createTime": nowTimeStamp,
                                @"locationAddress": locationAddress,
                                @"latitude": latitude,
                                @"longitude": longitude,
                                @"coachName": coachName,
                                @"courseProcessDesc": courseProcessDesc };
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        // 显示二维码
        [self showQRCodeImageWithContent:string];
        // 显示提示文字
        _markLabel.textColor = [UIColor blackColor];
        
        // 停止位置更新服务
        [self.locationService stopUserLocationService];
    }else {
        [self remindUserLocationError];
        NSLog(@"抱歉，未找到结果");
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (0 == buttonIndex) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark 定位失败后提示用户
- (void)remindUserLocationError {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"定位失败，请重新定位！" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
    [alertView show];
}

#pragma mark - lazy load
- (BMKLocationService *)locationService {
    if (!_locationService) {
        _locationService = [BMKLocationService new];
        _locationService.delegate = self;
    }
    return _locationService;
}
- (BMKGeoCodeSearch *)geoCodeSearch {
    if (!_geoCodeSearch) {
        _geoCodeSearch = [BMKGeoCodeSearch new];
        _geoCodeSearch.delegate = self;
    }
    return _geoCodeSearch;
}
- (UIImageView *)qrCodeImageView {
    if (!_qrCodeImageView) {
        _qrCodeImageView = [UIImageView new];
    }
    return _qrCodeImageView;
}
- (UIButton *)completeButton {
    if (!_completeButton) {
        _completeButton = [UIButton new];
        _completeButton.backgroundColor = MAINCOLOR;
        [_completeButton setTitle:@"完成" forState:UIControlStateNormal];
        [_completeButton addTarget:self action:@selector(completeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _completeButton;
}

- (void)helpDidClick {
    NSLog(@"%s",__func__);
    
    SignInHelpViewController *vc = [[SignInHelpViewController alloc] init];
    vc.url = @"";
    [self.navigationController pushViewController:vc animated:YES];
}
- (UILabel *)markLabel {
    if (!_markLabel) {
        _markLabel = [UILabel new];
        _markLabel.font = [UIFont systemFontOfSize:14];
        _markLabel.textAlignment = 1;
        _markLabel.text = @"扫一扫上面的二维码图案,立即签到";
        _markLabel.textColor = self.view.backgroundColor;
    }
    return _markLabel;
}
- (UILabel *)explainTitleLabel {
    if (!_explainTitleLabel) {
        _explainTitleLabel = [UILabel new];
        _explainTitleLabel.font = [UIFont systemFontOfSize:13];
        _explainTitleLabel.text = @"签到须知:";
        _explainTitleLabel.textColor = [UIColor redColor];
    }
    return _explainTitleLabel;
}
- (UILabel *)explainLabel {
    if (!_explainLabel) {
        _explainLabel = [UILabel new];
        _explainLabel.numberOfLines = 0;
        _explainLabel.font = [UIFont systemFontOfSize:12];
        _explainLabel.text = @"        签到开放的时间为,预定学车开始前的15分钟至学车时间结束，请您及时签到。如不签到，可能会影响您的学时记录以及教练的工时记录。\n如有疑问，请拨打400-626-9255";
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle setLineSpacing:8];//调整行间距
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:_explainLabel.text];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_explainLabel.text length])];
        _explainLabel.attributedText = attributedString;
    }
    return _explainLabel;
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

- (IBAction)completeBtnDidClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
