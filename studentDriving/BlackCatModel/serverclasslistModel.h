//
//  serverclasslistModel.h
//  studentDriving
//
//  Created by JiangangYang on 16/1/29.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "CarModel.h"

@interface serverclasslistModel : MTLModel<MTLJSONSerializing>

@property (copy, nonatomic) NSString *_id;
@property (copy, nonatomic) NSString *cartype;
@property (assign, nonatomic) NSInteger price;
@property (assign, nonatomic) NSInteger onsaleprice;
@property (copy, nonatomic) NSString *classdesc;
@property (strong, nonatomic) CarModel *carmodel;
@property (copy, nonatomic) NSString *classname;

@end

/*
{
    "_id": "56a9ba41fe60f807363001c9",
    "cartype": "桑塔纳3000",
    "price": 4980,
    "onsaleprice": 4680,
    "classdesc": "迎新春，本校特惠班型答谢想学车的你",
    "carmodel": {
        "modelsid": 1,
        "name": "手动挡汽车",
        "code": "C1"
    },
    "classname": "新春特惠班"
}
*/