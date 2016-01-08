//
//  AppointmentDetailViewController.m
//  BlackCat
//
//  Created by bestseller on 15/9/18.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "AppointmentDetailViewController.h"
#import "UIView+CalculateUIView.h"
#import "UIDevice+JEsystemVersion.h"
#import "AppointmentCollectionCell.h"
#import "AppointmentCell.h"
#import "CancelAppointmentViewController.h"
#import "StudentDetailViewController.h"
#import "MyAppointmentModel.h"
#import "StudentModel.h"
#import <BaiduMapAPI/BMapKit.h>
#import <BaiduMapAPI/BMKMapView.h>
#import <BaiduMapAPI/BMKPointAnnotation.h>
#import <BaiduMapAPI/BMKPinAnnotationView.h>
#import "ChatViewController.h"
#import <BaiduMapAPI/BMKGeocodeSearch.h>

static NSString *const kStudentTimeStudy = @"courseinfo/sametimestudents/reservationid/%@/index/%@";

static NSString *const kAppointmentDetail = @"courseinfo/userreservationinfo/%@";

@interface AppointmentDetailViewController ()<UITableViewDataSource,UITableViewDelegate,AppointmentCellDelegate,BMKMapViewDelegate, BMKGeoCodeSearchDelegate>
@property (strong, nonatomic) BMKMapView *mapView;

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIImageView *coachImageView;
@property (strong, nonatomic) UILabel *coachName;
@property (strong, nonatomic) UILabel *drivingAddress;

@property (strong, nonatomic) UIButton *itemTime;
@property (strong, nonatomic) UIButton *itemMessege;
@property (copy, nonatomic) NSArray *dataArray;

@property (nonatomic, strong) BMKGeoCodeSearch *geoCodeSearch;
@end

@implementation AppointmentDetailViewController

#pragma mark - 正地理编码
- (BOOL)geoCode {
    BMKGeoCodeSearchOption *geoCodeSearchOption = [BMKGeoCodeSearchOption new];
    //    geoCodeSearchOption.city = self.cityName;
    //    geoCodeSearchOption.address = self.cityName;
    //        geoCodeSearchOption.city= @"北京市";
    //        geoCodeSearchOption.address = @"北京市";
    geoCodeSearchOption.address = self.model.shuttleaddress;
    BOOL flag = [self.geoCodeSearch geoCode:geoCodeSearchOption];
    if(flag) {
        NSLog(@"geo检索发送成功");
        return YES;
    }else {
        NSLog(@"geo检索发送失败");
        return NO;
    }
}

#pragma mark 正地理编码回调
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //        NSLog(@"%@",result);
        CLLocationCoordinate2D location = result.location;
        NSLog(@"result.location.latitude===%f, result.location.longitude===%f",result.location.latitude,result.location.longitude);
        
        //        self.latitude = location.latitude;
        //        self.longitude = location.longitude;
        
        // 添加标注
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        //        coor.latitude = 39.915;
        //        coor.longitude = 116.404;
        coor.latitude = result.location.latitude;
        coor.longitude = result.location.longitude;
        annotation.coordinate = coor;
        annotation.title = self.model.shuttleaddress;
        [_mapView addAnnotation:annotation];
        
    }else {
        NSLog(@"抱歉，未找到结果");
        [self showTotasViewWithMes:@"地图定位失败"];
    }
}
// 标注样式
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

#pragma mark - lazy load
- (BMKGeoCodeSearch *)geoCodeSearch {
    if (!_geoCodeSearch) {
        _geoCodeSearch = [BMKGeoCodeSearch new];
        _geoCodeSearch.delegate = self;
    }
    return _geoCodeSearch;
}

- (UIButton *)itemTime {
    if (_itemTime == nil) {
        _itemTime = [UIButton buttonWithType:UIButtonTypeCustom];
        [_itemTime setBackgroundImage:[UIImage imageNamed:@"日历.png"] forState:UIControlStateNormal];
        _itemTime.frame = CGRectMake(0, 0, 50, 50);
        
    }
    return _itemTime;
}
- (UIButton *)itemMessege {
    if (_itemMessege == nil) {
        _itemMessege = [UIButton buttonWithType:UIButtonTypeCustom];
        [_itemMessege setBackgroundImage:[UIImage imageNamed:@"聊天.png"] forState:UIControlStateNormal];
        _itemMessege.frame = CGRectMake(0, 0, 50, 50);
        //        _itemMessege.backgroundColor = [UIColor blackColor];
        [_itemMessege addTarget:self action:@selector(dealMessage:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _itemMessege;
}

- (UILabel *)coachName {
    if (_coachName == nil) {
        _coachName = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:16]];
        _coachName.text = @"李教练";
    }
    return _coachName;
}
- (UILabel *)drivingAddress {
    if (_drivingAddress == nil) {
        _drivingAddress = [WMUITool initWithTextColor:TEXTGRAYCOLOR withFont:[UIFont systemFontOfSize:14]];
        _drivingAddress.text = @"北京市海淀区中关村驾校";
    }
    return _drivingAddress;
}

- (UIImageView *)coachImageView{
    if (_coachImageView == nil) {
        _coachImageView = [[UIImageView alloc] init];
        _coachImageView.backgroundColor = MAINCOLOR;
        [_coachImageView sd_setImageWithURL:[NSURL URLWithString:self.model.coachid.headportrait.originalpic]placeholderImage:[UIImage imageNamed:@"littleImage.png"]];
    }
    return _coachImageView;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"科目二";
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([UIDevice jeSystemVersion] >= 7.0f) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    if (self.isPushInformation) {
        [self startDownLoadAppoint];
        return;
    }else {
        [self createUI];
    }
    
}

- (void)dealMessage:(UIButton *)sender {
    
    ChatViewController *chat = [[ChatViewController alloc] initWithChatter:self.model.coachid.infoId  conversationType:eConversationTypeChat];
    chat.title = self.model.coachid.name;
    
    NSDictionary * extParam = @{@"headUrl":self.model.coachid.headportrait.originalpic,@"nickName":self.model.coachid.name,@"userId":self.model.coachid.infoId,@"userType":@"2"};
    chat.conversation.ext = extParam;
    [self.navigationController pushViewController:chat animated:YES];
    
}

- (void)createUI {
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = [self tableViewHeadView];
    
    if (self.state == AppointmentStateWait) {
        
    }else {
        self.tableView.tableFooterView = [[UIView alloc] init];
    }
    
    
    [self conformNavItem];
}
- (void)startDownLoadAppoint {
    NSString *urlString = [NSString stringWithFormat:kAppointmentDetail,self.infoId];
    NSString *url = [NSString stringWithFormat:BASEURL,urlString];
    DYNSLog(@"url = %@",url);
    [JENetwoking startDownLoadWithUrl:url postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        DYNSLog(@"appointment = %@",data);
        NSDictionary *param = data;
        NSNumber *type = param[@"type"];
        if (type.integerValue == 1) {
            MyAppointmentModel *model = [MTLJSONAdapter modelOfClass:MyAppointmentModel.class fromJSONDictionary:param[@"data"] error:nil];
            self.model = model;
            [self createUI];
        }
    }];
}
//获取同时段学员
//- (void)startDownLoad {
//
//    NSString *urlString = [NSString stringWithFormat:kStudentTimeStudy,self.model.infoId,@"1"];
//
//    NSString *url = [NSString stringWithFormat:BASEURL,urlString];
//    [JENetwoking startDownLoadWithUrl:url postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
//        NSDictionary *param = data;
//        NSNumber *type = param[@"type"];
//        NSString *msg = [NSString stringWithFormat:@"%@", param[@"msg"]];
//        if (type.integerValue == 1) {
//            NSError *error = nil;
//            self.dataArray = [MTLJSONAdapter modelsOfClass:StudentModel.class fromJSONArray:param[@"data"] error:&error];
//            DYNSLog(@"error = %@",error);
//            [self.collectionView reloadData];
//        }else {
//            kShowFail(msg);
//        }
//
//
//
//    }];
//
//}
- (void)conformNavItem {
    UIBarButtonItem *navTimeItem = [[UIBarButtonItem alloc] initWithCustomView:self.itemTime];
    UIBarButtonItem *navMessegeItem = [[UIBarButtonItem alloc] initWithCustomView:self.itemMessege];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -15;
    self.navigationItem.rightBarButtonItems = @[spaceItem,navMessegeItem];
}
- (UIView *)tableViewHeadView {
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 90)];
    backGroundView.backgroundColor = [UIColor whiteColor];
    
    [backGroundView addSubview:self.coachImageView];
    
    [self.coachImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(backGroundView.mas_top).offset(15);
        make.height.mas_equalTo(@60);
        make.width.mas_equalTo(@60);
        
    }];
    
    [backGroundView addSubview:self.coachName];
    [self.coachName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coachImageView.mas_right).offset(10);
        make.top.mas_equalTo(self.coachImageView.mas_top).offset(5);
    }];
    self.coachName.text = self.model.coachid.name;
    
    [backGroundView addSubview:self.drivingAddress];
    
    [self.drivingAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coachImageView.mas_right).offset(10);
        make.top.mas_equalTo(self.coachName.mas_bottom).offset(10);
    }];
    self.drivingAddress.text = self.model.coachid.driveschoolinfo.name;
    return backGroundView;
}
//- (UIView *)tableViewFootView {
//    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 90)];
//
//    [backGroundView addSubview:self.studentTitle];
//    [self.studentTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(backGroundView.mas_left).offset(15);
//        make.top.mas_equalTo(backGroundView.mas_top).offset(13);
//    }];
//
//    [backGroundView addSubview:self.collectionView];
//
//
//
//    return backGroundView;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 200;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    AppointmentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[AppointmentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.courseProgress.text = self.model.courseprocessdesc;
    cell.courseLocation.text = @"";
    cell.courseTime.text = self.model.classdatetimedesc;
    if (self.state == AppointmentStateSelfCancel) {
        [cell.cancelButton setTitle:@"已取消" forState:UIControlStateNormal];
        cell.cancelButton.userInteractionEnabled = NO;
        cell.cancelButton.backgroundColor = [UIColor lightGrayColor];
    }else if (self.state == AppointmentStateCoachCancel) {
        [cell.cancelButton setTitle:@"教练取消" forState:UIControlStateNormal];
        cell.cancelButton.userInteractionEnabled = NO;
        cell.cancelButton.backgroundColor = [UIColor lightGrayColor];
    }else if (self.state == AppointmentStateFinish) {
        [cell.cancelButton setTitle:@"课程已学完" forState:UIControlStateNormal];
        cell.cancelButton.userInteractionEnabled = NO;
        cell.cancelButton.backgroundColor = RGBColor(17, 216, 136);
    }else if (self.state == AppointmentStateWait || self.state == AppointmentStateCoachConfirm) {
        
        [cell.cancelButton setTitle:@"取消预约" forState:UIControlStateNormal];
        cell.cancelButton.backgroundColor = MAINCOLOR;
        
//        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(15, 200, kSystemWide-30, 150)];
//        _mapView.mapType = BMKMapTypeStandard;
//        _mapView.zoomLevel = 12;
//        [cell.contentView addSubview:_mapView];
//        [self geoCode];
        
    }else if (self.state == AppointmentStateSystemCancel) {
        [cell.cancelButton setTitle:@"系统取消" forState:UIControlStateNormal];
        cell.cancelButton.userInteractionEnabled = NO;
        cell.cancelButton.backgroundColor = RGBColor(205, 212, 217);
    }
    return cell;
}
- (void)studentCancelAppointment {
    CancelAppointmentViewController *cancelAppoint = [[CancelAppointmentViewController alloc] init];
    cancelAppoint.model = self.model;
    [self.navigationController pushViewController:cancelAppoint animated:YES];
}
#pragma mark - collectionViewDelegate
- (void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
    //    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    //    CLLocationCoordinate2D coor;
    //    coor.latitude = 39.915;
    //    coor.longitude = 116.404;
    //    annotation.coordinate = coor;
    //    annotation.title = @"这里是北京";
    //    [_mapView addAnnotation:annotation];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

@end
