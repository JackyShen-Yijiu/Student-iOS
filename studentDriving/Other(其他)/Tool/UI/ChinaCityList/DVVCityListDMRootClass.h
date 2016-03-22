//
//  DVVCityListDMRootClass.h
//  studentDriving
//
//  Created by 大威 on 16/2/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVVCityListDMData.h"

@interface DVVCityListDMRootClass : NSObject

@property (nonatomic, strong) NSArray * data;
@property (nonatomic, copy) NSString * msg;
@property (nonatomic, assign) NSInteger type;

@end
