//
//  DVVLocation.h
//  studentDriving
//
//  Created by 大威 on 16/1/25.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DVVLocationSuccessBlock)(BMKUserLocation *userLocation,
                                       double latitude,
                                       double longitude);
typedef void(^DVVLocationErrorBlock)();

typedef void(^DVVLocationAddressSuccessBlock)(BMKReverseGeoCodeResult *result,
                                              NSString *city,
                                              NSString *address);
typedef void(^DVVLocationAddressErrorBlock)();

@interface DVVLocation : NSObject

@property (nonatomic, assign) BOOL onlyGetLocation;

- (void)startLocation;

- (void)setLocationSuccessBlock:(DVVLocationSuccessBlock)handle;
- (void)setLocationErrorBlock:(DVVLocationErrorBlock)handle;

- (void)setAddressSuccessBlock:(DVVLocationAddressSuccessBlock)handle;
- (void)setAddressErrorBlock:(DVVLocationAddressErrorBlock)handle;

+ (void)getUserLocation:(DVVLocationSuccessBlock)success
                  error:(DVVLocationErrorBlock)error;

+ (void)getUserAddress:(DVVLocationAddressSuccessBlock)success
                 error:(DVVLocationAddressErrorBlock)error;

@end
