//
//  SubjectModel.h
//  BlackCat
//
//  Created by bestseller on 15/10/19.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>
@interface SubjectModel : MTLModel<MTLJSONSerializing>
//@property (copy, readonly, nonatomic) NSString *cancelId;
@property (copy, readonly, nonatomic) NSString *name;
@property (strong, readonly, nonatomic) NSNumber *subjectId;
@end
