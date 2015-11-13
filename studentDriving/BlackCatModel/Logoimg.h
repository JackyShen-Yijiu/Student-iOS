//
//  logoimg.h
//  BlackCat
//
//  Created by bestseller on 15/10/9.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>
@interface Logoimg : MTLModel<MTLJSONSerializing>
@property (copy, nonatomic,readonly)NSString * height;
@property (copy, nonatomic,readonly)NSString *originalpic;
@property (copy, nonatomic,readonly)NSString *thumbnailpic;
@property (copy, nonatomic,readonly)NSString *width;
@end
