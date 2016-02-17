//
//  YBAppointMentNoCountentView.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/17.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBAppointMentNoCountentView.h"

@implementation YBAppointMentNoCountentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBColor(238, 238, 238);
                
        // 创建图标
        UIImageView *img = [[UIImageView alloc] init];
        img.image = [UIImage imageNamed:@"机器人"];
        img.frame = CGRectMake(kSystemWide/2-50/2, kSystemHeight/2-74/2-64, 56, 74);
        [self addSubview:img];

        UILabel *label1 = [[UILabel alloc] init];
        label1.font = [UIFont systemFontOfSize:12];
        label1.textColor = [UIColor grayColor];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.numberOfLines = 2;
        label1.frame = CGRectMake(20, CGRectGetMaxY(img.frame), kSystemWide-40, 50);
        label1.text = @"小步没有找到您的预约教练信息，点击右上角添加教练，开始您愉快的学车之旅吧";
        [self addSubview:label1];
        
        
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
