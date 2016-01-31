//
//  DVVLocation.h
//  studentDriving
//
//  Created by 大威 on 16/1/25.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>

// 位置坐标
typedef void(^DVVLocationSuccessBlock)(BMKUserLocation *userLocation,
                                       double latitude,
                                       double longitude);
typedef void(^DVVLocationErrorBlock)();

// 反地理编码
typedef void(^DVVLocationReverseGeoCodeSuccessBlock)(BMKReverseGeoCodeResult *result,
                                                     NSString *city,
                                                     NSString *address);
typedef void(^DVVLocationReverseGeoCodeErrorBlock)();
// 正地理编码
typedef void(^DVVLocationGeoCodeSuccessBlock)(BMKGeoCodeResult *result,
                                              CLLocationCoordinate2D coordinate,
                                              double latitude,
                                              double longitude);
typedef void(^DVVLocationGeoCodeErrorBlock)();

@interface DVVLocation : NSObject

@property (nonatomic, assign) BOOL onlyGetLocation;

- (void)startLocation;

- (void)setLocationSuccessBlock:(DVVLocationSuccessBlock)handle;
- (void)setLocationErrorBlock:(DVVLocationErrorBlock)handle;

- (void)setReverseGeoCodeSuccessBlock:(DVVLocationReverseGeoCodeSuccessBlock)handle;
- (void)setReverseGeoCodeErrorBlock:(DVVLocationReverseGeoCodeErrorBlock)handle;

- (void)setGeoCodeSuccessBlock:(DVVLocationGeoCodeSuccessBlock)handle;
- (void)setGeoCodeErrorBlock:(DVVLocationGeoCodeErrorBlock)handle;

- (BOOL)geoCodeWithCity:(NSString *)city address:(NSString *)address;

+ (void)getLocation:(DVVLocationSuccessBlock)success
              error:(DVVLocationErrorBlock)error;

+ (void)reverseGeoCode:(DVVLocationReverseGeoCodeSuccessBlock)success
                 error:(DVVLocationReverseGeoCodeErrorBlock)error;

+ (void)geoCodeWithCity:(NSString *)city
                address:(NSString *)address
                success:(DVVLocationGeoCodeSuccessBlock)success
                  error:(DVVLocationGeoCodeErrorBlock)error;

+ (instancetype)sharedLoaction;

@end
