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
#import "JZAppointTestFirstController.h"
#import "YBHomeBaseController.h"

@implementation YBAppointmentHeaderView

+ (YBAppointmentHeaderView *)appointmentHeaderView
{
    NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"YBAppointmentHeaderView" owner:self options:nil];
    // 手机号码改变
    
    return xibArray.firstObject;
    
}

- (void)awakeFromNib
{
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSignUpList) name:kupdateSignUpListHeaderData object:nil];
    _subjectLabel.textColor = [UIColor colorWithHexString:@"2f2f2f"];
    _subjectTopLabel.textColor = [UIColor colorWithHexString:@"2f2f2f"];
    
    self.stateLabel.hidden = YES;

    //        [self setLabelTextColor:_yiXueLabel];
    //        [self setLabelTextColor:_guidingLabel];
    
    self.yuekaoBtn.hidden = NO;
    self.yuekaoBtn.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yuekaoBtnDidClick)];
    [self.yuekaoBtn addGestureRecognizer:tap];
    
    if (YBIphone6Plus) {
        
        self.subjectLabel.font = [UIFont systemFontOfSize:14*YBRatio];
        self.subjectTopLabel.font = [UIFont systemFontOfSize:14*YBRatio];
        
        self.guidingLabel.font = [UIFont systemFontOfSize:12*YBRatio];
        self.yiXueLabel.font = [UIFont systemFontOfSize:12*YBRatio];
    
        
    }
    
    
    
    CGFloat carIconW = 40;
    CGFloat carIconH = 32;
    if (YBIphone6Plus) {
        carIconW = 40 * YB_1_5_Ratio;
        carIconH = 32 * YB_1_5_Ratio;
    }
    self.leftImageView.width = carIconW;
    self.leftImageView.height = carIconH;

    
    self.bottomView.backgroundColor = YBMainViewControlerBackgroundColor;
    
}

- (void)setLabelTextColor:(UILabel *)label {
    label.textColor = JZ_FONTCOLOR_LIGHT;
}

- (void)setUpData
{
    
    NSLog(@"[AcountManager manager].userSubject.subjectId:%@",[AcountManager manager].userSubject.subjectId);
    
    self.stateLabel.hidden = YES;
    
    if ([AcountManager manager].userSubject.subjectId.integerValue==1) {
        
        self.stateLabel.hidden = NO;
        self.yuekaoBtn.hidden = YES;
        self.leftImageView.hidden = YES;
        
    }else if ([AcountManager manager].userSubject.subjectId.integerValue == 2) {
        
        self.subjectLabel.text = [NSString stringWithFormat:@"%@",@"科目二"];
        
        NSInteger shengyuxueshi = [[AcountManager manager].subjecttwo.totalcourse integerValue] - [[AcountManager manager].subjecttwo.finishcourse integerValue];
        NSLog(@"[[AcountManager manager].subjecttwo.officialhours integerValue]= %lu [[AcountManager manager].subjecttwo.totalcourse integerValue] = %lu",[[AcountManager manager].subjecttwo.officialhours integerValue],[[AcountManager manager].subjecttwo.totalcourse integerValue]);


        // 学习内容
        self.subjectTopLabel.text = [NSString stringWithFormat:@"上次学习: %@",[AcountManager manager].subjecttwo.progress];
        // 规定的
        self.guidingLabel.text = [NSString stringWithFormat:@"规定:%@课时",[AcountManager manager].subjecttwo.totalcourse];
        // 已学
        self.yiXueLabel.text = [NSString stringWithFormat:@"已学:%@课时",[AcountManager manager].subjecttwo.finishcourse];
 
        // 还需
        self.shengxueshiLabel.text = [NSString stringWithFormat:@"还需%ld学时",(long)shengyuxueshi];
        
        // 如果没有完成规定的学时，则不能点击约考
        if (shengyuxueshi > 0) {
            _yuekaoBtn.userInteractionEnabled = NO;
            _yuekaoBtn.image = [UIImage imageNamed:@"YBAppointMentDetailsexam_off"];
        }else {
            self.shengxueshiLabel.hidden = YES;
            _yuekaoBtn.userInteractionEnabled = YES;
            _yuekaoBtn.image = [UIImage imageNamed:@"YBAppointMentDetailsexam_on"];
        }

    }else if ([AcountManager manager].userSubject.subjectId.integerValue == 3) {
        
        self.subjectLabel.text = [NSString stringWithFormat:@"%@",@"科目三"];
        
        NSInteger shengyuxueshi = [[AcountManager manager].subjectthree.officialhours integerValue] - [AcountManager manager].subjectthree.officialfinishhours;
        
        // 学习内容
        self.subjectTopLabel.text = [NSString stringWithFormat:@"上次学习: %@",[AcountManager manager].subjectthree.progress];
        // 规定
        NSLog(@"[AcountManager manager].subjectthree.totalcourse = %zd",[AcountManager manager].subjectthree.totalcourse);
        self.guidingLabel.text = [NSString stringWithFormat:@"规定:%@课时",[AcountManager manager].subjectthree.totalcourse];
        // 已学
        self.yiXueLabel.text = [NSString stringWithFormat:@"已学:%@课时",[AcountManager manager].subjectthree.finishcourse];
        // 还需
        self.shengxueshiLabel.text = [NSString stringWithFormat:@"还需%ld学时",(long)shengyuxueshi];
        
        
        // 如果没有完成规定的学时，则不能点击约考
        if (shengyuxueshi>0) {
            _yuekaoBtn.userInteractionEnabled = NO;
            _yuekaoBtn.image = [UIImage imageNamed:@"YBAppointMentDetailsexam_off"];
        }else {
            self.shengxueshiLabel.hidden = YES;
            _yuekaoBtn.userInteractionEnabled = YES;
            _yuekaoBtn.image = [UIImage imageNamed:@"YBAppointMentDetailsexam_on"];
        }
        
    }

    if (![AcountManager isLogin]) {
        self.yuekaoBtn.hidden = YES;
    }
    
}

- (void)yuekaoBtnDidClick{
    
//    YBAppointTestViewController *appointVc = [[YBAppointTestViewController alloc] init];
//    appointVc.title = @"我要预约";
//    appointVc.hidesBottomBarWhenPushed = YES;
//    [self.parentViewController.navigationController pushViewController:appointVc animated:YES];
    
    JZAppointTestFirstController *appointVc = [[JZAppointTestFirstController alloc] init];
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
- (void)updateSignUpList{
    [self setUpData];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
