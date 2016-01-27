//
//  StudentCommentModel.h
//  studentDriving
//
//  Created by bestseller on 15/10/30.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>
#import "CommentModel.h"
#import "UserIdModel.h"

@interface StudentCommentModel : MTLModel<MTLJSONSerializing>

@property (copy, nonatomic) NSString *infoId;
@property (strong, nonatomic) UserIdModel *userid;
@property (strong, nonatomic) CommentModel *comment;

@property (copy, nonatomic) NSString *finishtime;
@property (copy, nonatomic) NSString *timestamp;

@end

/*
 {
 "_id": "569da54529c74c473d8e91c6",
 "userid": {
     "_id": "564e1242aa5c58b901e4961a",
     "applyclasstypeinfo": {
         "id": "562dd1fd1cdf5c60873625f3",
         "name": "一步互联网驾校快班",
         "price": 4700
     },
     "carmodel": {
         "name": "小型汽车手动挡",
         "modelsid": 1,
         "code": "C1"
     },
     "headportrait": {
         "height": "",
         "width": "",
         "thumbnailpic": "",
         "originalpic": "http://7xnjg0.com1.z0.glb.clouddn.com/20160119/102159-564e1242aa5c58b901e4961a.png"
     },
     "name": "亚飞学员端"
     },
 "comment": {
     "timelevel": 0,
     "starlevel": 0,
     "commenttime": "2016-01-21T12:15:15.816Z",
     "commentcontent": "基金经理",
     "attitudelevel": 0,
     "abilitylevel": 0
 },
 "finishtime": "2016-01-21T13:06:20.856Z",
 "timestamp": 1453381580856
 },
*/