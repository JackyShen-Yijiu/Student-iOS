//
//  StudentCommentModel.h
//  studentDriving
//
//  Created by bestseller on 15/10/30.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>
#import "CommentModel.h"
#import "UserIdModel.h"
@interface StudentCommentModel : MTLModel<MTLJSONSerializing>
@property (copy, nonatomic, readonly) NSString *infoId;
@property (strong, nonatomic, readonly) CommentModel *comment;
@property (strong, nonatomic, readonly) UserIdModel *userid;
@end
