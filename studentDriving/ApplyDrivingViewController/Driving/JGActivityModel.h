//
//  JGActivityModel.h
//  studentDriving
//
//  Created by JiangangYang on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface JGActivityModel : MTLModel<MTLJSONSerializing>

@property (copy, readonly, nonatomic) NSString *address;

@property (copy, readonly, nonatomic) NSString *begindate;

@property (copy, readonly, nonatomic) NSString *contenturl;

@property (copy, readonly, nonatomic) NSString *enddate;

@property (copy, readonly, nonatomic) NSString *ID;

@property (copy, readonly, nonatomic) NSString *name;

@property (copy, readonly, nonatomic) NSString *titleimg;

@end


