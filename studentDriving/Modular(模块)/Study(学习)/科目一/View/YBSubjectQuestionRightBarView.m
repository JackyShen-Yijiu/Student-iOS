//
//  YBSubjectQuestionRightBarView.m
//  studentDriving
//
//  Created by JiangangYang on 16/4/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBSubjectQuestionRightBarView.h"
#import "YBSubjectQuestionRightButton.h"

@implementation YBSubjectQuestionRightBarView

- (instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray *)titleArray withImgArray:(NSArray *)imgArray
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat rightBtnW = frame.size.width/titleArray.count;
        CGFloat rightBtnH = 40;
        
        for (int i = 0; i < titleArray.count; i++) {
        
            YBSubjectQuestionRightButton *rightBtn = [[YBSubjectQuestionRightButton alloc] init];
            
            rightBtn.titleLabel.font = [UIFont systemFontOfSize:10];
            [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            rightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            [rightBtn setImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
            [rightBtn setTitle:titleArray[i] forState:UIControlStateNormal];
        
            CGFloat rightBtnX = rightBtnW * i;
            CGFloat rightBtnY = 0;
           
            rightBtn.frame = CGRectMake(rightBtnX, rightBtnY, rightBtnW, rightBtnH);
            
            rightBtn.tag = i;
            
            [self addSubview:rightBtn];
            
        }
        
    }
    return self;
}

@end
