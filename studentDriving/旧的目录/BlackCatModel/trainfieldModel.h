//
//  trainfieldModel.h
//  studentDriving
//
//  Created by JiangangYang on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface trainfieldModel : MTLModel<MTLJSONSerializing>

@property (copy, nonatomic) NSString *_id;
@property (copy, nonatomic) NSString *fieldname;
@property (strong, nonatomic) NSArray *pictures;
@property (copy, nonatomic) NSString *phone;

@end
