//
//  ComplaintCoachView.m
//  studentDriving
//
//  Created by 大威 on 16/1/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "ComplaintCoachView.h"

@implementation ComplaintCoachView

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray  *xibArray = [[NSBundle mainBundle]loadNibNamed:@"ComplaintCoachView" owner:self options:nil];
        ComplaintCoachView *view=xibArray.firstObject;
        self = view;
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
