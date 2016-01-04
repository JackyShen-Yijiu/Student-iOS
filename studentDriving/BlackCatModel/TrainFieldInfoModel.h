//
//  TrainFieldlnfoModel.h
//  BlackCat
//
//  Created by bestseller on 15/10/19.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>
@interface TrainFieldInfoModel : MTLModel<MTLJSONSerializing>
@property (copy, readonly, nonatomic) NSString *TrainFieldInfoModelId;
@property (copy, readonly, nonatomic) NSString *name;
@end
