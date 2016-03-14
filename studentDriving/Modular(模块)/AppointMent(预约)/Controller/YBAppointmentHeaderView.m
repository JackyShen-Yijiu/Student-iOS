//
//  YBAppointmentHeaderView.m
//  studentDriving
//
//  Created by 大威 on 16/3/10.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBAppointmentHeaderView.h"
#import "YBAppointTestViewController.h"
#import "NSUserStoreTool.h"

@implementation YBAppointmentHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"YBAppointmentHeaderView" owner:self options:nil];
        self = xibArray.firstObject;
    }
    return self;
}

- (void)setUpData
{
        
    if ([AcountManager manager].subjecttwo.progress) {

        self.subjectLabel.text = [NSString stringWithFormat:@"%@",@"科目一"];
        self.subjectTopLabel.text = [NSString stringWithFormat:@"%@",@"科目一"];
    }
    if ([AcountManager manager].subjectthree.progress) {

        self.subjectLabel.text = [NSString stringWithFormat:@"%@",@"科目二"];
        self.subjectTopLabel.text = [NSString stringWithFormat:@"%@",@"科目二"];
    }
    
    NSMutableString *subStr = [NSMutableString string];
    if ([AcountManager manager].subjecttwo.reservation && [AcountManager manager].subjecttwo.finishcourse) {
        
        NSInteger yiyuexueshiCount = [[AcountManager manager].subjecttwo.reservation integerValue] + [[AcountManager manager].subjecttwo.finishcourse integerValue];
        //
        //        [subStr appendString:[NSString stringWithFormat:@"已约学时:%ld课时",(long)yiyuexueshiCount]];
        //
        //        NSString *officiahours = [NSString stringWithFormat:@"%@",[AcountManager manager].subjecttwo.officialhours];
        //        if (officiahours&&![officiahours isEqualToString:@"0"]) {
        //            [subStr appendString:[NSString stringWithFormat:@"    官方学时:%@课时",[AcountManager manager].subjecttwo.officialhours]];
        //        }
        //
        [subStr appendString:[NSString stringWithFormat:@"购买:%@课时",(long)[AcountManager manager].subjecttwo.buycoursecount]];
        [subStr appendString:[NSString stringWithFormat:@"     已学:%ld课时",yiyuexueshiCount]];
        
    }else if ([AcountManager manager].subjectthree.reservation && [AcountManager manager].subjectthree.finishcourse) {
        
        NSInteger yiyuexueshiCount = [[AcountManager manager].subjectthree.reservation integerValue] + [[AcountManager manager].subjectthree.finishcourse integerValue];
        NSLog(@"yiyuexueshiCount:%lu",yiyuexueshiCount);
        
        //        [subStr appendString:[NSString stringWithFormat:@"已约学时:%ld课时",(long)yiyuexueshiCount]];
        //
        //        NSString *officiahours = [NSString stringWithFormat:@"%@",[AcountManager manager].subjectthree.officialhours];
        //        if (officiahours&&![officiahours isEqualToString:@"0"]) {
        //            [subStr appendString:[NSString stringWithFormat:@"    官方学时:%@课时",[AcountManager manager].subjectthree.officialhours]];
        //        }
        [subStr appendString:[NSString stringWithFormat:@"购买:%@课时",(long)[AcountManager manager].subjectthree.buycoursecount]];
        [subStr appendString:[NSString stringWithFormat:@"     已学:%ld课时",yiyuexueshiCount]];
        
    }
    // 购买多少课、已学多少课时
    if (subStr && [subStr length]!=0) {
        self.buySubjectLabel.text = subStr;
    }
    
    //
    //
    NSMutableString *detailStr = [NSMutableString string];
    //    if ([AcountManager manager].subjecttwo.missingcourse) {
    //
    //        NSInteger loukeCount = [[AcountManager manager].subjecttwo.missingcourse integerValue];;
    //        NSLog(@"loukeCount:%ld",(long)loukeCount);
    //        [detailStr appendString:[NSString stringWithFormat:@"漏课:%ld课时",(long)loukeCount]];
    //
    //        totalcourse
    //
    //    }else if ([AcountManager manager].subjectthree.missingcourse) {
    //
    //        NSInteger loukeCount = [[AcountManager manager].subjectthree.missingcourse integerValue];
    //        NSLog(@"loukeCount:%ld",(long)loukeCount);
    //        [detailStr appendString:[NSString stringWithFormat:@"漏课:%ld课时",(long)loukeCount]];
    //
    //    }
    
    if ([AcountManager manager].userSubject.subjectId.integerValue == 2) {
        
        NSInteger doneCourse = [AcountManager manager].subjecttwo.finishcourse.integerValue;
        NSInteger appointCourse = [AcountManager manager].subjecttwo.reservation.integerValue;
        NSInteger totalCourse = [AcountManager manager].subjecttwo.totalcourse.integerValue;
        NSInteger restCourse = totalCourse - doneCourse - appointCourse;
        
        [detailStr appendString:[NSString stringWithFormat:@"规定:%ld课时",totalCourse]];
        [detailStr appendString:[NSString stringWithFormat:@"     完成:%ld课时",doneCourse]];
        
    }else if ([AcountManager manager].userSubject.subjectId.integerValue == 3) {
        
        NSInteger doneCourse = [AcountManager manager].subjectthree.finishcourse.integerValue;
        NSInteger appointCourse = [AcountManager manager].subjectthree.reservation.integerValue;
        NSInteger totalCourse = [AcountManager manager].subjectthree.totalcourse.integerValue;
        NSInteger restCourse = totalCourse - doneCourse - appointCourse;
        
        [detailStr appendString:[NSString stringWithFormat:@"规定:%ld课时",totalCourse]];
        [detailStr appendString:[NSString stringWithFormat:@"     完成:%ld课时",doneCourse]];
        
    }
    
    // 规定多少课、完成多少课时
    if (detailStr&&[detailStr length]!=0) {
        self.guidingLabel.text = detailStr;
    }
    
    if (![AcountManager isLogin]) {
        self.yuekaoBtn.hidden = YES;
    }
    self.yuekaoBtn.hidden = NO;
    self.yuekaoBtn.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yuekaoBtnDidClick)];
    [self.yuekaoBtn addGestureRecognizer:tap];
    
}

- (void)yuekaoBtnDidClick{
    
    YBAppointTestViewController *appointVc = [[YBAppointTestViewController alloc] init];
    appointVc.title = @"我要预约";
    appointVc.hidesBottomBarWhenPushed = YES;
    [self.parentViewController.navigationController pushViewController:appointVc animated:YES];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
