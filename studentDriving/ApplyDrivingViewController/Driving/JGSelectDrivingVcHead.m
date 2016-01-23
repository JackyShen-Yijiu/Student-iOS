//
//  JGSelectDrivingVcHead.m
//  studentDriving
//
//  Created by JiangangYang on 16/1/23.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JGSelectDrivingVcHead.h"

#define selectHeadViewH 35

@implementation JGSelectDrivingVcHead

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];

        NSArray *titleArray = [NSArray arrayWithObjects:@"班型选择",@"距离最近",@"评分最高",@"价格最高", nil];
        NSArray *titleImg = [NSArray arrayWithObjects:@"iconfont-xiaoyuanqiandao.png",@"iconfont-xiaoyuanqiandao.png",@"iconfont-xiaoyuanqiandao.png",@"iconfont-xiaoyuanqiandao.png", nil];
        
        for (int i = 0; i<titleArray.count; i++) {
            
            UIButton *btn = [[UIButton alloc] init];
            [btn setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitle:[titleArray objectAtIndex:i] forState:UIControlStateSelected];
            [btn setTitle:[titleArray objectAtIndex:i] forState:UIControlStateHighlighted];
            [btn setImage:[UIImage imageNamed:[titleImg objectAtIndex:i]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:[titleImg objectAtIndex:i]] forState:UIControlStateSelected];
            [btn setImage:[UIImage imageNamed:[titleImg objectAtIndex:i]] forState:UIControlStateHighlighted];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            btn.backgroundColor = [UIColor clearColor];
            btn.tag = i+100;
            
            CGFloat btnH = selectHeadViewH;
            CGFloat btnW = kSystemWide/titleArray.count;
            CGFloat btnX = i * btnW;
            CGFloat btnY = 0;
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
            
            [btn addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            if (i<titleArray.count-1) {
                
                // 分割线
                UIView *delive = [[UIView alloc] init];
                delive.backgroundColor = [UIColor lightGrayColor];
                delive.alpha = 0.3;
                
                CGFloat deliveX = i * btnW;
                CGFloat deliveY = 5;
                CGFloat deliveW = 0.5;
                CGFloat deliveH = btnH - 2 * deliveY;
                delive.frame = CGRectMake(deliveX, deliveY, deliveW, deliveH);
                
                [self addSubview:delive];
                
            }
            
        }
        
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, selectHeadViewH-1, kSystemWide, 0.5)];
        footView.backgroundColor = [UIColor lightGrayColor];
        footView.alpha = 0.3;
        [self addSubview:footView];
        
        
    }
    return self;
}

- (void)btnDidClick:(UIButton *)btn
{
    _selectDriving(btn.tag-100);
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
@end
