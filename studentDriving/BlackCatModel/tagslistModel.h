//
//  tagslistModel.h
//  studentDriving
//
//  Created by JiangangYang on 16/1/29.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface tagslistModel : MTLModel<MTLJSONSerializing>

@property (copy, nonatomic) NSString *_id;
@property (copy, nonatomic) NSString *color;
@property (copy, nonatomic) NSString *tagname;
@property (assign, nonatomic) NSInteger tagtype;

@end