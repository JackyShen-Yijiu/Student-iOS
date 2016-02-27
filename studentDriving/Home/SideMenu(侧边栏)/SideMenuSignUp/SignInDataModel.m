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


/* 
 {
 "_id" = 56ce75e5094a4b85079f68ef;
 begintime = "2016-02-28T21:00:00.000Z";
 cancelreason =             {
 };
 classdatetimedesc = "2016\U5e7402\U670829\U65e5 05:00--09:00";
 coachid =             {
 Gender = "\U7537";
 "_id" = 5666365ef14c20d07ffa6ae8;
 coachid = 5666365ef14c20d07ffa6ae8;
 driveschoolinfo =                 {
 id = 562dcc3ccb90f25c3bde40da;
 name = "\U4e00\U6b65\U4e92\U8054\U7f51\U9a7e\U6821";
 };
 headportrait =                 {
 height = "";
 originalpic = "http://7xnjg0.com1.z0.glb.clouddn.com/5666365ef14c20d07ffa6ae81455620521999";
 thumbnailpic = "";
 width = "";
 };
 name = "Jacky ";
 };
 courseprocessdesc = "\U79d1\U76ee\U4e8c\U7b2c126--129\U8bfe\U65f6";
 endtime = "2016-02-29T01:00:00.000Z";
 reservationcreatetime = "2016-02-25T03:32:53.585Z";
 reservationstate = 3;
 shuttleaddress = "";
 subject =             {
 name = "\U79d1\U76ee\U4e8c";
 subjectid = 2;
 };
 trainfieldlinfo =             {
 id = 561636cc21ec29041a9af88e;
 name = "\U4e00\U6b65\U9a7e\U6821\U7b2c\U4e00\U8bad\U7ec3\U573a";
 };
 },

 */
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{ @"ID": @"_id",
              @"beginTime": @"begintime",
              @"endTime": @"endtime",
              @"courseProcessDesc": @"courseprocessdesc",
              @"coachDataModel": @"coachid"
              };
}


@end
