//
//  YBAppointMentNoCountentView.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/17.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBAppointMentNoCountentView.h"

@interface YBAppointMentNoCountentView ()
@property (nonatomic,weak) UILabel *label1;
@end

@implementation YBAppointMentNoCountentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBColor(238, 238, 238);
                
        // 创建图标
        UIImageView *img = [[UIImageView alloc] init];
        img.image = [UIImage imageNamed:@"app_error_robot.png"];
        img.frame = CGRectMake(kSystemWide/2-72/2, kSystemHeight/2-75/2-64, 72, 75);
        [self addSubview:img];

        UILabel *label1 = [[UILabel alloc] init];
        label1.font = [UIFont systemFontOfSize:12];
        label1.textColor = [UIColor grayColor];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.numberOfLines = 2;
        label1.frame = CGRectMake(20, CGRectGetMaxY(img.frame), kSystemWide-40, 50);
        label1.text = @"小步没有找到您的预约教练信息，点击右上角添加教练，开始您愉快的学车之旅吧";
        [self addSubview:label1];
        self.label1 = label1;
        
    }
    return self;
}

- (void)setMessage:(NSString *)message
{
    _message = message;
    
    self.label1.text = _message;

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
