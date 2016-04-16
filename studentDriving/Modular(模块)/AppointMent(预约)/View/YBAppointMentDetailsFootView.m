//
//  YBAppointMentDetailsFootView.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/24.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBAppointMentDetailsFootView.h"
#import "HMCourseModel.h"
#import "YBAppointmentTool.h"

@interface YBAppointMentDetailsFootView()

@property (nonatomic,strong) UIButton *commitBtn;
@property (nonatomic,weak) UILabel *countLabel;

@end

@implementation YBAppointMentDetailsFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.backgroundColor = RGBColor(236, 236, 236);
        
//        UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(kSystemWide-10-90, 5, 90, 40)];
        _commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, 0, kSystemWide - 16*2, 44)];
        _commitBtn.layer.masksToBounds = YES;
        _commitBtn.layer.cornerRadius = 4;
        _commitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_commitBtn setTitle:@"取消预约" forState:UIControlStateNormal];
        [_commitBtn setTitle:@"取消预约" forState:UIControlStateHighlighted];
        [_commitBtn addTarget:self action:@selector(commitBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_commitBtn];
        
        
        _commitBtn.backgroundColor = YBNavigationBarBgColor;
        
        // 判断是否是在开始前24小时内
        
        
//        UILabel *countLabel = [[UILabel alloc] init];
//        countLabel.frame = CGRectMake(0, 0, kSystemWide-commitBtn.width-20, self.height);
//        countLabel.text = @"";
//        countLabel.font = [UIFont systemFontOfSize:12];
//        countLabel.textColor = [UIColor blackColor];
//        [self addSubview:countLabel];
//        self.countLabel = countLabel;
        
    }
    return self;
}

- (void)setCourseModel:(HMCourseModel *)courseModel
{
    _courseModel = courseModel;
   
    self.countLabel.text = [NSString stringWithFormat:@" %@",_courseModel.courseprocessdesc];
    
    if (![YBAppointmentTool checkCancelAppointmentWithBeginTime:_courseModel.courseBeginTime]) {
        
        _commitBtn.backgroundColor = JZ_FONTCOLOR_LIGHT;
        _commitBtn.userInteractionEnabled = NO;
    }
    
}

- (void)commitBtnDidClick
{
    self.didClick();
}
@end
