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

@property (copy, nonatomic)NSString * height;
@property (copy, nonatomic)NSString *originalpic;
@property (copy, nonatomic)NSString *thumbnailpic;
@property (copy, nonatomic)NSString *width;

@end
