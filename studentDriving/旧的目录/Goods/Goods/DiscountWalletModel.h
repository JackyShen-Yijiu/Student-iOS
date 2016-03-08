//
//  DiscountWalletModel.h
//  studentDriving
//
//  Created by ytzhang on 15/12/31.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscountWalletModel : NSObject

@property (nonatomic,strong) NSString *_id;

@property (nonatomic,assign) NSNumber *state;

@property (nonatomic,assign) NSNumber *couponcomefrom;

@property (nonatomic,strong) NSString *createtime;

@end
