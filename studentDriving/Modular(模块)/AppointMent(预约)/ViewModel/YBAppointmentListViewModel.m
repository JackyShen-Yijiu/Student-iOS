//
//  YBAppointmentListViewModel.m
//  studentDriving
//
//  Created by 大威 on 16/3/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBAppointmentListViewModel.h"
#import "YYModel.h"

@implementation YBAppointmentListViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _todayArray = [NSMutableArray array];
        _nextArray = [NSMutableArray array];
        _completedArray = [NSMutableArray array];
    }
    return self;
}

- (void)dvv_networkRequestRefresh {
    
    NSString *  userId = [AcountManager manager].userid;
    if (userId==nil) {
        
        return;
    }
    
    NSString *urlString = [NSString stringWithFormat:BASEURL,KAppointgetmyreservation];
    
    NSString *  userid = [AcountManager manager].userid;
    
    NSDictionary * dic = @{
                           @"subjectid":[NSString stringWithFormat:@"%ld",(long)[[AcountManager manager].userSubject.subjectId integerValue]],
                           @"userid":userid,
                           @"reservationstate":@"0"
                           };
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:dic WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        [self dvv_networkCallBack];
        
        NSLog(@"loadData dic:%@ data:%@",dic,data);
        
        
        NSInteger type = [[data objectForKey:@"type"] integerValue];
        
        NSArray *array = [data objectArrayForKey:@"data"];
        
//        NSString *message = [data objectForKey:@"msg"];
        
        if (type == 1) {
            
            NSArray *tempArray = [[BaseModelMethod getCourseListArrayFormDicInfo:array] mutableCopy];
            
            // 清空数据
            [_todayArray removeAllObjects];
            [_nextArray removeAllObjects];
            [_completedArray removeAllObjects];
            
            for (HMCourseModel *model in tempArray) {
                
                NSLog(@"加载model.sigintime:%@",model.sigintime);
                
                // 如果是学员取消、待评论则不显示
                if ([[model getStatueString] isEqualToString:@"学员取消"] ||
                    [[model getStatueString] isEqualToString:@"待评论"]) {
                    continue ;
                }
                
                NSLog(@"model.courseBeginTime:%@",model.courseBeginTime);
                NSLog(@"getYearLocalDateFormateUTCDate model.courseBeginTime:%@",[NSString getYearLocalDateFormateUTCDate:model.courseBeginTime]);
                
                int compareDataNum = [YBObjectTool compareDateWithSelectDateStr:[NSString getYearLocalDateFormateUTCDate:model.courseBeginTime]];
                NSLog(@"[NSString getYearLocalDateFormateUTCDate:model.courseBeginTime]:%@ compareDataNum:%d",[NSString getYearLocalDateFormateUTCDate:model.courseBeginTime],compareDataNum);
                
                // 如果已完成就直接添加（因为当天的也有已完成的）
//                if ([[model getStatueString] isEqualToString:@"已完成"] || [[model getStatueString] isEqualToString:@"已漏课"]) {
//                    [_completedArray addObject:model];
//                    continue ;
//                }
                if (compareDataNum==0) {// 当前
                    [_todayArray addObject:model];
                }else if (compareDataNum==1){// 大于当前日期
                    NSLog(@"%lu", (long)model.courseStatue);
                    [_nextArray addObject:model];
                }else if (compareDataNum==-1){// 小于当前日期
                    NSLog(@"------------------小于当前日期--------------");
                    [_completedArray addObject:model];
                }
            }
            
            [self dvv_refreshSuccess];
            
        }else{
            [self dvv_nilResponseObject];
        }
        
    }withFailure:^(id data) {
        [self dvv_networkCallBack];
        [self dvv_networkError];
    }];

}



@end
