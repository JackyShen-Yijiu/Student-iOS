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
@property (nonatomic, copy) DVVLocationAddressSuccessBlock addressSuccess;
@property (nonatomic, copy) DVVLocationAddressErrorBlock addressError;

@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
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
    [_locationService startUserLocationService];
}

+ (void)getUserLocation:(DVVLocationSuccessBlock)success
                  error:(DVVLocationErrorBlock)error {
    
//    static DVVLocation *location = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        location = [self new];
//    });
    DVVLocation *location = [DVVLocation sharedLoaction];
    location.onlyGetLocation = YES;
    [location setLocationSuccessBlock:success];
    [location setLocationErrorBlock:error];
}
+ (void)getUserAddress:(DVVLocationAddressSuccessBlock)success
                 error:(DVVLocationAddressErrorBlock)error {
    
//    static DVVLocation *location = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        location = [self new];
//    });
    DVVLocation *location = [DVVLocation sharedLoaction];
    [location setAddressSuccessBlock:success];
    [location setAddressErrorBlock:error];
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
    self.geoCodeSearch.delegate = self;
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
    BOOL flage = [self.geoCodeSearch reverseGeoCode:reverseGeocodeOption];
    if (flage) {
//        NSLog(@"反geo检索发送成功");
        return YES;
    }else {
//        NSLog(@"反geo检索发送失败");
        [self emptyAll];
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
        
        [self emptyAll];
        
        if (_addressSuccess) {
            _addressSuccess(result,
                            addressComponent.city,
                            result.address);
        }
    }else {
//        NSLog(@"抱歉，未找到结果");
        [self emptyAll];
        if (_addressError) {
            _addressError();
        }
    }
}

#pragma mark - empty
- (void)emptyAll {
    
    // 停止位置更新服务
    [_locationService stopUserLocationService];
    _locationService.delegate = nil;
    _geoCodeSearch.delegate = nil;
}
- (void)emptyLocationService {
    
    // 停止位置更新服务
    [_locationService stopUserLocationService];
    _locationService.delegate = nil;
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
- (void)setAddressSuccessBlock:(DVVLocationAddressSuccessBlock)handle {
    _addressSuccess = handle;
}
- (void)setAddressErrorBlock:(DVVLocationAddressErrorBlock)handle {
    _addressError = handle;
}

@end
