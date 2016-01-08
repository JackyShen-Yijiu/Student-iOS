//
//  SignInDataModel.m
//  studentDriving
//
//  Created by 大威 on 16/1/8.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "SignInDataModel.h"

@implementation SignInDataModel

/**
 *  服务器给的是属性和自己定义的不一致，用这个方法转换一下，才能解析到数据
 *
 *  @return 需要转换的数据字典
 */
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{ @"ID": @"_id",
              @"beginTime": @"begintime",
              @"endTime": @"endtime",
              @"coachDataModel": @"coachid" };
}


@end
