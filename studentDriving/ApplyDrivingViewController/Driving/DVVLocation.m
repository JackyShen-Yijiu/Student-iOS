//
//  DVVLocation.m
//  studentDriving
//
//  Created by 大威 on 16/1/25.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVLocation.h"
#import <BaiduMapAPI/BMKLocationService.h>
#import <BaiduMapAPI/BMKGeocodeSearch.h>

@interface DVVLocation ()<BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate>

@property (nonatomic, strong) BMKLocationService *locationService;
@property (nonatomic, strong) BMKGeoCodeSearch *geoCodeSearch;

@property (nonatomic, copy) DVVLocationSuccessBlock locationSuccess;
@property (nonatomic, copy) DVVLocationErrorBlock locationError;
@property (nonatomic, copy) DVVLocationReverseGeoCodeSuccessBlock addressSuccess;
@property (nonatomic, copy) DVVLocationReverseGeoCodeErrorBlock addressError;
@property (nonatomic, copy) DVVLocationGeoCodeSuccessBlock geoCodeSuccess;
@property (nonatomic, copy) DVVLocationGeoCodeErrorBlock geoCodeError;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end

@implementation DVVLocation

+ (instancetype)sharedLoaction {
    static DVVLocation *location = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        location = [DVVLocation new];
    });
    return location;
}

- (void)startLocation {
    
    
    self.locationService.delegate = self;
    // 再次定位的时候的时候不设置这个代理就不会走百度定位的代理方法（太坑了）
    self.geoCodeSearch.delegate = self;
    
    [_locationService startUserLocationService];
}

+ (void)getLocation:(DVVLocationSuccessBlock)success
              error:(DVVLocationErrorBlock)error {
    
    DVVLocation *location = [DVVLocation sharedLoaction];
    location.onlyGetLocation = YES;
    [location setLocationSuccessBlock:success];
    [location setLocationErrorBlock:error];
}
+ (void)reverseGeoCode:(DVVLocationReverseGeoCodeSuccessBlock)success
                 error:(DVVLocationReverseGeoCodeErrorBlock)error {
    
    DVVLocation *location = [self sharedLoaction];
    [location setReverseGeoCodeSuccessBlock:success];
    [location setReverseGeoCodeErrorBlock:error];
    [location startLocation];
}

#pragma mark - 位置坐标更新成功
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
//    NSLog(@"latitude === %lf   longitude === %lf", userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    
    _coordinate = userLocation.location.coordinate;
    
    if (_locationSuccess) {
        _locationSuccess(userLocation,
                         _coordinate.latitude,
                         _coordinate.longitude);
    }
    if (_onlyGetLocation) {
        [self emptyLocationService];
        return ;
    }
    
    // 反地理编码，获取城市名
    [self reverseGeoCodeWithLatitude:_coordinate.latitude
                           longitude:_coordinate.longitude];
}
#pragma mark - 位置坐标更新失败
- (void)didFailToLocateUserWithError:(NSError *)error {

    [self emptyLocationService];
    if (_onlyGetLocation) {
        if (_locationError) {
            _locationError();
        }
    }else {
        if (_addressError) {
            _addressError();
        }
    }
}
#pragma mark - 反地理编码
- (BOOL)reverseGeoCodeWithLatitude:(double)latitude
                         longitude:(double)longitude {
    
    CLLocationCoordinate2D point = (CLLocationCoordinate2D){ latitude, longitude };
    BMKReverseGeoCodeOption *reverseGeocodeOption = [BMKReverseGeoCodeOption new];
    reverseGeocodeOption.reverseGeoPoint = point;
    // 发起反向地理编码
    self.geoCodeSearch.delegate = self;
    BOOL flage = [self.geoCodeSearch reverseGeoCode:reverseGeocodeOption];
    if (flage) {
//        NSLog(@"反geo检索发送成功");
        return YES;
    }else {
//        NSLog(@"反geo检索发送失败");
        [self emptyLocationService];
        if (_addressError) {
            _addressError();
        }
        return NO;
    }
}
#pragma mark 反地理编码回调
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher
                           result:(BMKReverseGeoCodeResult *)result
                        errorCode:(BMKSearchErrorCode)error {
    
    if (error == BMK_SEARCH_NO_ERROR) {
//        NSLog(@"%@",result);
        BMKAddressComponent *addressComponent = result.addressDetail;
        // 城市名
        NSLog(@"city === %@",addressComponent.city);
        // 详细地址
        NSLog(@"address === %@", result.address);
        
        if (_addressSuccess) {
            _addressSuccess(result,
                            addressComponent.city,
                            result.address);
        }
    }else {
//        NSLog(@"抱歉，未找到结果");
        if (_addressError) {
            _addressError();
        }
    }
    [self emptyLocationService];
}

+ (void)geoCodeWithCity:(NSString *)city address:(NSString *)address success:(DVVLocationGeoCodeSuccessBlock)success error:(DVVLocationGeoCodeErrorBlock)error {
    
    DVVLocation *location = [DVVLocation sharedLoaction];
    [location setGeoCodeSuccessBlock:success];
    [location setGeoCodeErrorBlock:error];
    [location geoCodeWithCity:city address:address];
}

#pragma mark - 正地理编码
- (BOOL)geoCodeWithCity:(NSString *)city address:(NSString *)address {
    BMKGeoCodeSearchOption *geoCodeSearchOption = [BMKGeoCodeSearchOption new];
    geoCodeSearchOption.city = city;
    geoCodeSearchOption.address = address;
//    geoCodeSearchOption.city= @"北京市";
//    geoCodeSearchOption.address = @"海淀区上地10街10号";
    self.geoCodeSearch.delegate = self;
    BOOL flag = [self.geoCodeSearch geoCode:geoCodeSearchOption];
    if(flag) {
//        NSLog(@"geo检索发送成功");
        return YES;
    }else {
        [self emptyLocationService];
        if (_geoCodeError) {
            _geoCodeError();
        }
//        NSLog(@"geo检索发送失败");
        return NO;
    }
}

#pragma mark 正地理编码回调
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //        NSLog(@"result.location.latitude===%f, result.location.longitude===%f",result.location.latitude,result.location.longitude);
        
        _coordinate = result.location;
        if (_geoCodeSuccess) {
            _geoCodeSuccess(result,
                            result.location,
                            result.location.latitude,
                            result.location.longitude);
        }
    }else {
//        NSLog(@"抱歉，未找到结果");
        if (_geoCodeError) {
            _geoCodeError();
        }
    }
    [self emptyLocationService];
}

#pragma mark - empty location service
- (void)emptyLocationService {
    
    // 停止位置更新服务
    [_locationService stopUserLocationService];
    _locationService.delegate = nil;
    _geoCodeSearch.delegate = nil;
}

#pragma mark - lazy load
- (BMKLocationService *)locationService {
    if (!_locationService) {
        _locationService = [BMKLocationService new];
        [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        [BMKLocationService setLocationDistanceFilter:10000.f];
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

#pragma mark - set block
- (void)setLocationSuccessBlock:(DVVLocationSuccessBlock)handle {
    _locationSuccess = handle;
}
- (void)setLocationErrorBlock:(DVVLocationErrorBlock)handle {
    _locationError = handle;
}
- (void)setReverseGeoCodeSuccessBlock:(DVVLocationReverseGeoCodeSuccessBlock)handle {
    _addressSuccess = handle;
}
- (void)setReverseGeoCodeErrorBlock:(DVVLocationReverseGeoCodeErrorBlock)handle {
    _addressError = handle;
}
- (void)setGeoCodeSuccessBlock:(DVVLocationGeoCodeSuccessBlock)handle {
    _geoCodeSuccess = handle;
}
- (void)setGeoCodeErrorBlock:(DVVLocationGeoCodeErrorBlock)handle {
    _geoCodeError = handle;
}

@end
