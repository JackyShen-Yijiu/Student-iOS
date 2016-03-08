//
//  Applyclasstypeinfo.h
//  studentDriving
//
//  Created by JiangangYang on 16/1/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <MTLJSONAdapter.h>

@interface Applyclasstypeinfo : MTLModel<MTLJSONSerializing>
@property (copy, nonatomic) NSString *ID;
@property (strong, nonatomic) NSNumber *price;
@property (copy, nonatomic) NSString *name;
@end
/*
 "applyclasstypeinfo": {
     "id": "562dd1fd1cdf5c60873625f3",
     "name": "一步互联网驾校快班",
     "price": 4700
 },
 */