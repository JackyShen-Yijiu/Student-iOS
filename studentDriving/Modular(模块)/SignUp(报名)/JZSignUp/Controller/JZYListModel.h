//
//  JZYListModel.h
//  studentDriving
//
//  Created by ytzhang on 16/3/15.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZYListModel : NSObject
/*
 {
 "type": 1,
 "msg": "",
 "data": [
 {
 "Ycode": "YB34EP",
 "name": "王小二",
 "date": "2015/12/31"
 }
 ]
 }
 */
@property (nonatomic, strong) NSString *Ycode;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *date;
@end
