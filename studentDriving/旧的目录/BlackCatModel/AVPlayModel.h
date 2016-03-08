//
//  AVPlayModel.h
//  studentDriving
//
//  Created by bestseller on 15/11/6.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>
#import "SubjectModel.h"
@interface AVPlayModel : MTLModel<MTLJSONSerializing>
@property (copy, readonly, nonatomic) NSString *infoId;
@property (copy, readonly, nonatomic) NSString *name;
@property (copy, readonly, nonatomic) NSString *pictures;
@property (strong,readonly, nonatomic) NSNumber *seqindex;
@property (strong,readonly, nonatomic) SubjectModel *subject;
@property (copy, readonly, nonatomic) NSString *videourl;
@end
