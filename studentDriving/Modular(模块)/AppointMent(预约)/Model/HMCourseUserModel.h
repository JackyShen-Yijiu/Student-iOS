//
//  HMCourseUserModel.h
//  studentDriving
//
//  Created by JiangangYang on 16/2/22.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMPortraitInfoModel.h"
#import "HMSchoolInfoModel.h"

@interface HMCourseUserModel : NSObject
+ (HMCourseUserModel *)converJsonDicToModel:(NSDictionary *)dic;

@property(nonatomic,strong)NSString * coachid;

@property(nonatomic,strong)NSString * _id;

@property(nonatomic,strong)NSString * name;

@property(nonatomic,strong)HMPortraitInfoModel * headportrait;

@property(nonatomic,strong)HMSchoolInfoModel* driveschoolinfo;

@property(nonatomic,strong)NSString * Gender;

@end
