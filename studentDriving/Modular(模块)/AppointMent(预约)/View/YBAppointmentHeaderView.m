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
        
        if (YBIphone6Plus) {
            
            self.subjectLabel.font = [UIFont systemFontOfSize:14*YBRatio];
            self.subjectTopLabel.font = [UIFont systemFontOfSize:14*YBRatio];
            self.buySubjectLabel.font = [UIFont systemFontOfSize:12*YBRatio];
            self.guidingLabel.font = [UIFont systemFontOfSize:12*YBRatio];
            self.yiXueLabel.font = [UIFont systemFontOfSize:12*YBRatio];
            self.wanChengLabel.font = [UIFont systemFontOfSize:12*YBRatio];
            
        }
        
        _bottomView.backgroundColor = YBMainViewControlerBackgroundColor;
    }
    return self;
}

- (void)setLabelTextColor:(UILabel *)label {
    label.textColor = [UIColor colorWithHexString:@"b7b7b7"];
}

- (void)setUpData
{
    
    if ([AcountManager manager].userSubject.subjectId.integerValue == 2) {
        
        self.subjectLabel.text = [NSString stringWithFormat:@"%@",@"科目二"];

        NSInteger doneCourse = [AcountManager manager].subjecttwo.finishcourse.integerValue;
        NSInteger appointCourse = [AcountManager manager].subjecttwo.reservation.integerValue;
        NSInteger totalCourse = [AcountManager manager].subjecttwo.totalcourse.integerValue;
        NSInteger restCourse = totalCourse - doneCourse - appointCourse;
        
        NSInteger shengyuxueshi = [[AcountManager manager].subjecttwo.totalcourse integerValue] - [[AcountManager manager].subjecttwo.finishcourse integerValue];

        // 学习内容
        self.subjectTopLabel.text = [NSString stringWithFormat:@"%@",[AcountManager manager].subjecttwo.progress];
        // 规定
        self.buySubjectLabel.text = [NSString stringWithFormat:@"规定:%@学时",[AcountManager manager].subjecttwo.officialhours];
        // 购买
        self.guidingLabel.text = [NSString stringWithFormat:@"购买:%@课时",[AcountManager manager].subjecttwo.totalcourse];
        // 完成
        self.yiXueLabel.text = [NSString stringWithFormat:@"完成:%ld学时",(long)[AcountManager manager].subjecttwo.officialfinishhours];
        // 已学
        self.wanChengLabel.text = [NSString stringWithFormat:@"已学:%@课时",[AcountManager manager].subjecttwo.finishcourse];
        // 还需
        self.shengxueshiLabel.text = [NSString stringWithFormat:@"还需%ld学时",(long)shengyuxueshi];
        
        // 如果没有完成规定的学时，则不能点击约考
        if (shengyuxueshi>0) {
            _yuekaoBtn.userInteractionEnabled = NO;
            _yuekaoBtn.image = [UIImage imageNamed:@"YBAppointMentDetailsexam_off"];
        }else {
            _yuekaoBtn.userInteractionEnabled = YES;
            _yuekaoBtn.image = [UIImage imageNamed:@"YBAppointMentDetailsexam_on"];
        }

    }else if ([AcountManager manager].userSubject.subjectId.integerValue == 3) {
        
        self.subjectLabel.text = [NSString stringWithFormat:@"%@",@"科目三"];

        NSInteger doneCourse = [AcountManager manager].subjectthree.finishcourse.integerValue;
        NSInteger appointCourse = [AcountManager manager].subjectthree.reservation.integerValue;
        NSInteger totalCourse = [AcountManager manager].subjectthree.totalcourse.integerValue;
        NSInteger restCourse = totalCourse - doneCourse - appointCourse;
        
        NSInteger shengyuxueshi = [[AcountManager manager].subjectthree.totalcourse integerValue] - [[AcountManager manager].subjectthree.finishcourse integerValue];
        
        // 学习内容
        self.subjectTopLabel.text = [NSString stringWithFormat:@"%@",[AcountManager manager].subjectthree.progress];
        // 规定
        self.buySubjectLabel.text = [NSString stringWithFormat:@"规定:%@学时",[AcountManager manager].subjectthree.officialhours];
        // 购买
        self.guidingLabel.text = [NSString stringWithFormat:@"购买:%@课时",[AcountManager manager].subjectthree.totalcourse];
        // 完成
        self.yiXueLabel.text = [NSString stringWithFormat:@"完成:%ld学时",(long)[AcountManager manager].subjectthree.officialfinishhours];
        // 已学
        self.wanChengLabel.text = [NSString stringWithFormat:@"已学:%@课时",[AcountManager manager].subjectthree.finishcourse];
        // 还需
        self.shengxueshiLabel.text = [NSString stringWithFormat:@"还需%ld学时",(long)shengyuxueshi];
        
        
        // 如果没有完成规定的学时，则不能点击约考
        if (shengyuxueshi>0) {
            _yuekaoBtn.userInteractionEnabled = NO;
            _yuekaoBtn.image = [UIImage imageNamed:@"YBAppointMentDetailsexam_off"];
        }else {
            _yuekaoBtn.userInteractionEnabled = YES;
            _yuekaoBtn.image = [UIImage imageNamed:@"YBAppointMentDetailsexam_on"];
        }
        
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
