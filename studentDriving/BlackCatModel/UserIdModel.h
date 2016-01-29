//
//  UserIdModel.h
//  studentDriving
//
//  Created by bestseller on 15/10/29.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "MTLModel.h"
#import "Logoimg.h"
#import "CarModel.h"
#import "Applyclasstypeinfo.h"
#import <MTLJSONAdapter.h>

@interface UserIdModel : MTLModel<MTLJSONSerializing>
@property (copy, nonatomic) NSString *userId;
@property (strong, nonatomic) Logoimg *headportrait;
@property (strong, nonatomic) CarModel *carmodel;
@property (strong, nonatomic) Applyclasstypeinfo *applyclasstypeinfo;
@property (copy, nonatomic) NSString *name;
@end

/*
 
 "_id": "564e1242aa5c58b901e4961a",
 "applyclasstypeinfo": {
 "id": "562dd1fd1cdf5c60873625f3",
 "name": "一步互联网驾校快班",
 "price": 4700
 },
 "carmodel": {
 "name": "小型汽车手动挡",
 "modelsid": 1,
 "code": "C1"
 },
 "headportrait": {
 "height": "",
 "width": "",
 "thumbnailpic": "",
 "originalpic": "http://7xnjg0.com1.z0.glb.clouddn.com/20160119/102159-564e1242aa5c58b901e4961a.png"
 },
 "name": "亚飞学员端"
 
 */