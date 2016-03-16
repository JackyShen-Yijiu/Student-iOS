//
//  SubjectThreeModel.h
//  studentDriving
//
//  Created by bestseller on 15/11/7.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>

@interface SubjectThreeModel : MTLModel<MTLJSONSerializing>
@property (strong, nonatomic, readonly) NSNumber *finishcourse;// 已学
@property (copy, nonatomic, readonly) NSString *progress;
@property (strong, nonatomic, readonly) NSNumber *reservation;
@property (strong, nonatomic, readonly) NSNumber *totalcourse;// 购买
@property (strong, nonatomic, readonly) NSNumber *missingcourse;
@property (strong, nonatomic, readonly) NSNumber *officialhours;// 规定
@property (nonatomic,strong,readonly) NSNumber *buycoursecount;
@property (nonatomic,assign,readonly) NSInteger officialfinishhours;//完成
@end

/*

 totalcourse:{type:Number,default:3},  //总共学时
 reservation:{type:Number,default:0},//  预约中的学时
 finishcourse:{type:Number,default:0},// 完成学习
 missingcourse:{type:Number,default:0}, // 漏课数量
 progress:{type:String,default:"未开始"}, // 学习进度
 reservationid:String, //学习进度id
 officialhours:{type:Number,default:0}, // 官方总学时
 officialfinishhours:{type:Number,default:0} // 官方完成学时
 
*/