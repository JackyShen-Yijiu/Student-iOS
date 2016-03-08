//
//  HMCourseUserModel.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/22.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "HMCourseUserModel.h"

@implementation HMCourseUserModel
+ (HMCourseUserModel *)converJsonDicToModel:(NSDictionary *)dic
{
    if (!dic || ![dic isKindOfClass:[NSDictionary class]] ||![dic allKeys].count) {
        return nil;
    }
    HMCourseUserModel * model = [[HMCourseUserModel alloc] init];
   
    model.coachid = [dic objectStringForKey:@"coachid"];

    model._id = [dic objectStringForKey:@"_id"];

    model.name = [dic objectStringForKey:@"name"];

    model.headportrait = [HMPortraitInfoModel converJsonDicToModel:[dic objectInfoForKey:@"headportrait"]];

    model.driveschoolinfo = [HMSchoolInfoModel converJsonDicToModel:[dic objectInfoForKey:@"driveschoolinfo"]];

    model.Gender = [dic objectStringForKey:@"Gender"];

    return model;
}
@end
