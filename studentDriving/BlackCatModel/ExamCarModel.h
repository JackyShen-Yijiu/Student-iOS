//
//  ExamCarModel.h
//  BlackCat
//
//  Created by bestseller on 15/10/20.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>
@interface ExamCarModel : MTLModel<MTLJSONSerializing>
@property (copy, nonatomic) NSString *code;
@property (strong, nonatomic) NSNumber *modelsid;
@property (copy, nonatomic) NSString *name;
@end
