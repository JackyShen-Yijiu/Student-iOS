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
        
        _subjectLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
        _subjectTopLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
        
        [self setLabelTextColor:_buySubjectLabel];
        [self setLabelTextColor:_yiXueLabel];
        [self setLabelTextColor:_guidingLabel];
        [self setLabelTextColor:_wanChengLabel];
        
        self.yuekaoBtn.hidden = NO;
        self.yuekaoBtn.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yuekaoBtnDidClick)];
        [self.yuekaoBtn addGestureRecognizer:tap];
        
        _bottomView.backgroundColor = YBMainViewControlerBackgroundColor;
    }
    return self;
}

- (void)setLabelTextColor:(UILabel *)label {
    label.textColor = [UIColor colorWithHexString:@"b7b7b7"];
}

- (void)setUpData
{
    
    
    NSString *buyStr = @"";
    NSString *yiXueStr = @"";
    NSString *studycountent = @"";
    NSString *guiDingStr = @"";
    NSString *wanChengStr = @"";
    
    if ([AcountManager manager].userSubject.subjectId.integerValue == 2) {
        
        self.subjectLabel.text = [NSString stringWithFormat:@"%@",@"科目二"];

        NSInteger doneCourse = [AcountManager manager].subjecttwo.finishcourse.integerValue;
        NSInteger appointCourse = [AcountManager manager].subjecttwo.reservation.integerValue;
        NSInteger totalCourse = [AcountManager manager].subjecttwo.totalcourse.integerValue;
        NSInteger restCourse = totalCourse - doneCourse - appointCourse;
        
        guiDingStr = [NSString stringWithFormat:@"规定:%ld学时",(long)totalCourse];
        wanChengStr = [NSString stringWithFormat:@"完成:%ld学时",(long)doneCourse];
        // 如果没有完成规定的学时，则不能点击约考
        if (doneCourse < totalCourse) {
            _yuekaoBtn.userInteractionEnabled = NO;
            _yuekaoBtn.image = [UIImage imageNamed:@"YBAppointMentDetailsexam_off"];
            _shengXueShiLabel.text = [NSString stringWithFormat:@"还剩%d学时", totalCourse - doneCourse];
        }else {
            _yuekaoBtn.image = [UIImage imageNamed:@"YBAppointMentDetailsexam_on"];
            _shengXueShiLabel.text = @"";
        }
        
        NSInteger yiyuexueshiCount = [[AcountManager manager].subjecttwo.reservation integerValue] + [[AcountManager manager].subjecttwo.finishcourse integerValue];

        studycountent = [AcountManager manager].subjecttwo.progress;
        buyStr = [NSString stringWithFormat:@"购买:%ld课时",(long)[AcountManager manager].subjecttwo.buycoursecount.longValue];
        yiXueStr = [NSString stringWithFormat:@"已学:%ld课时",(long)yiyuexueshiCount];

    }else if ([AcountManager manager].userSubject.subjectId.integerValue == 3) {
        
        self.subjectLabel.text = [NSString stringWithFormat:@"%@",@"科目三"];

        NSInteger doneCourse = [AcountManager manager].subjectthree.finishcourse.integerValue;
        NSInteger appointCourse = [AcountManager manager].subjectthree.reservation.integerValue;
        NSInteger totalCourse = [AcountManager manager].subjectthree.totalcourse.integerValue;
        NSInteger restCourse = totalCourse - doneCourse - appointCourse;
        
        guiDingStr = [NSString stringWithFormat:@"规定:%ld学时",(long)totalCourse];
        wanChengStr = [NSString stringWithFormat:@"完成:%ld学时",(long)doneCourse];
        
        // 如果没有完成规定的学时，则不能点击约考
        if (doneCourse < totalCourse) {
            _yuekaoBtn.userInteractionEnabled = NO;
            _yuekaoBtn.image = [UIImage imageNamed:@"YBAppointMentDetailsexam_off"];
            _shengXueShiLabel.text = [NSString stringWithFormat:@"还剩%d学时", totalCourse - doneCourse];
        }else {
            _yuekaoBtn.image = [UIImage imageNamed:@"YBAppointMentDetailsexam_on"];
            _shengXueShiLabel.text = @"";
        }
        
        NSInteger yiyuexueshiCount = [[AcountManager manager].subjectthree.reservation integerValue] + [[AcountManager manager].subjectthree.finishcourse integerValue];
        NSLog(@"yiyuexueshiCount:%lu",(long)yiyuexueshiCount);
        
        studycountent = [AcountManager manager].subjectthree.progress;
        buyStr = [NSString stringWithFormat:@"购买:%ld课时",(long)[AcountManager manager].subjectthree.buycoursecount.longValue];
        yiXueStr = [NSString stringWithFormat:@"已学:%ld课时",(long)yiyuexueshiCount];

    }
    
    // 购买多少课、已学多少课时
    if (buyStr.length) {
        _buySubjectLabel.text = buyStr;
    }
    if (yiXueStr) {
        _yiXueLabel.text = yiXueStr;
    }
    
    self.subjectTopLabel.text = [NSString stringWithFormat:@"%@  %@",yiXueStr,studycountent];

    // 规定多少课、完成多少课时
    if (guiDingStr.length) {
        _guidingLabel.text = guiDingStr;
    }
    if (wanChengStr.length) {
        _wanChengLabel.text = wanChengStr;
    }
    
    if (![AcountManager isLogin]) {
        self.yuekaoBtn.hidden = YES;
    }
    
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
