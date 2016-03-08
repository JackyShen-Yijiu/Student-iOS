//
//  DVVCoachDetailDMTagslist.h
//  studentDriving
//
//  Created by 大威 on 16/2/22.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

@interface DVVCoachDetailDMTagslist : NSObject<YYModel>

//"tagslist": [
//             {
//                 "_id": "569e23d387d6565c3369dbc9",
//                 "color": "#ffb814",
//                 "tagtype": 0,
//                 "tagname": "五星级教练"
//             }
//             ]

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, assign) NSInteger tagtype;
@property (nonatomic, copy) NSString *tagname;

@end
