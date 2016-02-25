//
//  YBAppointMentDetailsFootView.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/24.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBAppointMentDetailsFootView.h"
#import "HMCourseModel.h"

@interface YBAppointMentDetailsFootView()
@property (nonatomic,weak) UIButton *commitBtn;
@property (nonatomic,weak) UILabel *countLabel;
@end

@implementation YBAppointMentDetailsFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBColor(236, 236, 236);
        
        UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(kSystemWide-10-90, 5, 90, 40)];
        commitBtn.backgroundColor = YBNavigationBarBgColor;
        commitBtn.layer.masksToBounds = YES;
        commitBtn.layer.cornerRadius = 3;
        [commitBtn setTitle:@"取消预约" forState:UIControlStateNormal];
        [commitBtn setTitle:@"取消预约" forState:UIControlStateHighlighted];
        [commitBtn addTarget:self action:@selector(commitBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:commitBtn];
        self.commitBtn = commitBtn;
        
        UILabel *countLabel = [[UILabel alloc] init];
        countLabel.frame = CGRectMake(0, 0, kSystemWide-commitBtn.width-20, self.height);
        countLabel.text = @"";
        countLabel.font = [UIFont systemFontOfSize:12];
        countLabel.textColor = [UIColor blackColor];
        [self addSubview:countLabel];
        self.countLabel = countLabel;
        
    }
    return self;
}

- (void)setCourseModel:(HMCourseModel *)courseModel
{
    _courseModel = courseModel;
   
    self.countLabel.text = [NSString stringWithFormat:@" %@",_courseModel.courseprocessdesc];
    
}

- (void)commitBtnDidClick
{
    self.didClick();
}
@end
