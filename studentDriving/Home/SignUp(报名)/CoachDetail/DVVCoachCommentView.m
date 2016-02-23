//
//  DVVCoachCommentView.m
//  studentDriving
//
//  Created by 大威 on 16/2/23.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVCoachCommentView.h"

@implementation DVVCoachCommentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.bounces = NO;
        self.dataSource = self;
        self.delegate = self;
        // 如果是固定高度的话在这里设置比较好
        self.rowHeight = 88.f;
        self.tableFooterView = self.bottomButton;
        
//        [self registerClass:[CoachListCell class] forCellReuseIdentifier:kCellIdentifier];
        
//        [self configViewModel];
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
