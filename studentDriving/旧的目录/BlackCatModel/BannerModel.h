//
//  BannerModel.h
//  studentDriving
//
//  Created by bestseller on 15/11/4.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>
#import "Logoimg.h"
@interface BannerModel : MTLModel<MTLJSONSerializing>
@property (copy,readonly,nonatomic) NSString *infoId;
@property (copy,readonly,nonatomic) NSString *createtime;
@property (strong,readonly,nonatomic) Logoimg *headportrait;
@property (strong,readonly,nonatomic) NSNumber *is_using;
@property (copy,readonly,nonatomic) NSString *linkurl;
@property (copy,readonly,nonatomic) NSString *newsname;
@property (strong,readonly,nonatomic) NSNumber *newtype;
@end
