//
//  JZSignUpFooterView.m
//  studentDriving
//
//  Created by ytzhang on 16/3/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZSignUpFooterView.h"

@implementation JZSignUpFooterView
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"JZSignUpFooterView"owner:self options:nil];
        self = xibArray.firstObject;
        
    }
    return self;
}

@end
