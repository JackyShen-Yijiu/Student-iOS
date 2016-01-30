//
//  CoachListDMServerClassList.h
//  studentDriving
//
//  Created by 大威 on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoachListDMCarmodel.h"
#import "YYModel.h"

@interface CoachListDMServerClassList : NSObject<YYModel>

//"serverclasslist": [
//                    {
//                        "_id": "56a9ba41fe60f807363001c9",
//                        "cartype": "桑塔纳3000",
//                        "price": 4980,
//                        "onsaleprice": 4680,
//                        "carmodel": {
//                            "modelsid": 1,
//                            "name": "手动挡汽车",
//                            "code": "C1"
//                        },
//                        "classname": "新春特惠班"
//                    }
//                    ]
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *cartype;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, assign) NSInteger onsaleprice;
@property (nonatomic, strong) CoachListDMCarmodel *carmodel;
@property (nonatomic, strong) NSString *classname;

@end
