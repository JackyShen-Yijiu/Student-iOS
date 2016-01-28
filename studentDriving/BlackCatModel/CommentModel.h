//
//  CommentModel.h
//  studentDriving
//
//  Created by bestseller on 15/10/30.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>
@interface CommentModel : MTLModel<MTLJSONSerializing>
@property (strong, nonatomic) NSNumber *abilitylevel;
@property (strong, nonatomic) NSNumber *attitudelevel;
@property (nonatomic,copy)NSString * commentcontent;
@property (nonatomic,copy)NSString * commenttime;
@property (nonatomic,strong)NSNumber * starlevel;
@property (nonatomic,strong)NSNumber * timelevel;
@end

/*
 {
 "timelevel": 0,
 "starlevel": 0,
 "commenttime": "2016-01-21T12:15:15.816Z",
 "commentcontent": "基金经理",
 "attitudelevel": 0,
 "abilitylevel": 0
 },
*/