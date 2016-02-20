//
//  JGActivityModel.h
//  studentDriving
//
//  Created by JiangangYang on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Mantle/Mantle.h>

typedef NS_ENUM(NSInteger,activityState){
    
    activitystateRead,// 0:未开始,敬请期待,准备中
    activitystateIng,// 1:正在进行
    activitystateComplete,// 2:已过期,已结束
    
};

@interface JGActivityModel : MTLModel<MTLJSONSerializing>

@property (copy, readonly, nonatomic) NSString *address;

@property (copy, readonly, nonatomic) NSString *begindate;

@property (copy, readonly, nonatomic) NSString *contenturl;

@property (copy, readonly, nonatomic) NSString *enddate;

@property (copy, readonly, nonatomic) NSString *ID;

@property (copy, readonly, nonatomic) NSString *name;

@property (copy, readonly, nonatomic) NSString *titleimg;

@property (assign, readonly, nonatomic) activityState activitystate;

@end


