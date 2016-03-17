//
//  JZCoachListMoel.h
//  studentDriving
//
//  Created by ytzhang on 16/3/17.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZCoachListMoel : NSObject
/*
 
 {
 "type": 1,
 "msg": "",
 "data": [
 {
 "coachid": "56aa4f33c6a1c2c706c1bb3a",
 "name": "阿其太",
 "driveschoolinfo": {
 "name": "一步互联网驾校",
 "id": "562dcc3ccb90f25c3bde40da"
 },
 "headportrait": {
 "originalpic": "",
 "thumbnailpic": "",
 "width": "",
 "height": ""
 },
 "starlevel": 5,
 "is_shuttle": true,
 "passrate": 98,
 "Seniority": "3",
 "latitude": 40.096263,
 "longitude": 116.127921,
 "subject": [
 {
 "_id": "56af31da3a9e3c9b0943c93a",
 "name": "科目二",
 "subjectid": 2
 },
 {
 "_id": "56af31da3a9e3c9b0943c939",
 "name": "科目三",
 "subjectid": 3
 }
 ],
 "commentcount": 0,
 "maxprice": 0,
 "minprice": 0,
 "carmodel": {
 "code": "C1",
 "name": "手动挡汽车",
 "modelsid": 1
 },
 "serverclasslist": []
 },
 */
@property (nonatomic, strong) NSDictionary *headportrait;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *subject;
@property (nonatomic, assign) NSInteger commentcount;

@property (nonatomic, assign) NSInteger starlevel;

@property (nonatomic, assign) NSInteger passrate;
@property (nonatomic, strong) NSString *Seniority;
@end
