//
//  HMOrderModel.m
//  HeiMao_B
//
//  Created by kequ on 15/10/25.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HMCourseModel.h"

@implementation HMCourseModel

+ (HMCourseModel *)converJsonDicToModel:(NSDictionary *)dic
{

    if (!dic || ![dic isKindOfClass:[NSDictionary class]] ||![dic allKeys].count) {
        return nil;
    }
    HMCourseModel *  model = [[HMCourseModel alloc] init];
    model.courseId = [dic objectStringForKey:@"_id"];
    model.courseStatue = [[dic objectForKey:@"reservationstate"] integerValue];
    model.reservationcreatetime = [dic objectStringForKey:@"reservationcreatetime"];
    model.coursePikerAddres = [dic objectStringForKey:@"shuttleaddress"];
    model.courseprocessdesc = [dic objectStringForKey:@"courseprocessdesc"];
    model.courseTime = [dic objectStringForKey:@"classdatetimedesc"];
    model.courseBeginTime = [dic objectStringForKey:@"begintime"];
    model.courseEndtime = [dic objectStringForKey:@"endtime"];
    model.userModel = [HMCourseUserModel converJsonDicToModel:[dic objectInfoForKey:@"coachid"]];
    model.subject = [HMSubjectModel converJsonDicToModel:[dic objectInfoForKey:@"subject"]];
    model.courseTrainInfo = [HMTrainaddressModel converJsonDicToModel:[dic objectInfoForKey:@"trainfieldlinfo"]];
    model.cancelreason = [dic objectInfoForKey:@"cancelreason"];
    
//    
//    model.courseProgress = [dic objectStringForKey:@"courseprocessdesc"];
//    
//    model.comment = [dic objectStringForKey:@"comment"];
//  
//    model.coachcomment = [dic objectStringForKey:@"coachcomment"];
//    
//    model.cancelreason = [dic objectStringForKey:@"cancelreason"];
//    
//    model.officialDesc = [dic objectStringForKey:@"officialDesc"];
//    
//    model.courseTrainInfo = [HMTrainaddressModel converJsonDicToModel:[dic objectInfoForKey:@"trainfieldlinfo"]];
//
//    model.subjectthree = [JGSubjectthreeModel converJsonDicToModel:[dic objectInfoForKey:@"subjectthree"]];
//
//    model.isPickerUp = [[dic objectForKey:@"is_shuttle"] boolValue];
//    
//    model.studentInfo = [HMStudentModel converJsonDicToModel:[dic objectInfoForKey:@"userid"]];
//    model.classType = [HMClassInfoModel converJsonDicToModel:[dic objectInfoForKey:@"subject"]];
//
//    // 剩余课时
//    model.leavecoursecount = [[dic objectForKey:@"leavecoursecount"] intValue];
//    model.missingcoursecount = [[dic objectForKey:@"missingcoursecount"] intValue];
//    // 倒车入科(学习内容)
//    model.learningcontent = [dic objectStringForKey:@"learningcontent"];

    return model;
}

- (NSString *)getStatueString
{
    NSString * str = @"";
    switch (self.courseStatue) {
          
        case KCourseStatueapplying:   // 预约中->请求中
            return @"请求中";
            break;
        case KCourseStatueapplycancel :// 学生取消->删除此订单
            return @"";
            break;
        case KCourseStatueapplyconfirm:  // 已确定->新接收
            return @"新接收";
            break;
        case KCourseStatueapplyrefuse:      // 教练拒绝或者取消->教练取消
            return @"教练取消";
            break;
        case KCourseStatueunconfirmfinish: //  无此状态
            return @"";
            break;
        case KCourseStatueucomments:    // 待评论->待评论
            return @"待评论";
            break;
        case KCourseStatuefinish: // 订单完成->已完成
            return @"已完成";
            break;
        case KCourseStatuesystemcancel: // 系统取消->已完成
            return @"已完成";
            break;
        case KCourseStatuesignin: // 已签到->已签到
            return @"已签到";
            break;
        case KCourseStatuenosignin: // 未签到->已漏课
            return @"已漏课";
            break;
             
           
//            
//        case  KCourseStatueapplying :   // 预约中
//            return @"待接受";
//            break;
//        case  KCourseStatueapplycancel :// 学生取消
//            return @"学生取消";
//            break;
//        case  KCourseStatueapplyconfirm:  // 已确定
//            return @"已接受";
//            break;
//        case  KCourseStatueapplyrefuse:      // 教练（拒绝或者取消）
//            return @"已取消";
//            break;
//        case  KCourseStatueunconfirmfinish: //  待确认完成  (v1.1 中没有该字段)
//            return @"待确认完成";
//            break;
//        case  KCourseStatueucomments:    // 待评论
//            return @"待评价";
//            break;
//        case  KCourseStatuefinish: // 订单完成
//            return @"订单完成";
//            break;
//        case  KCourseStatuesystemcancel: // 系统取消
//            return @"系统取消";
//            break;
//        case  KCourseStatuesignin: // 已签到
//            return @"已签到";
//            break;
//        case  KCourseStatuenosignin: // 未签到
//            return @"已漏课";
//            break;
        
    }
    return str;
}
@end
