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
@property (copy, nonatomic, readonly) NSString *commentcontent;
@property (strong, nonatomic, readonly) NSNumber *starlevel;
@property (nonatomic,strong,readonly)NSString * commenttime;
@end
