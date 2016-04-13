//
//  MyJiFenHeaderTypeView.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/13.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "MyJiFenHeaderTypeView.h"
#define kLKSize [UIScreen mainScreen].bounds.size
@implementation MyJiFenHeaderTypeView
-(instancetype)initWithFrame:(CGRect)frame {
    
    
    if (self = [super initWithFrame:frame]) {
        
        
        self = [[NSBundle mainBundle] loadNibNamed:@"MyJiFenHeaderTypeView" owner:self options:nil].lastObject;
        
        self.frame = frame;
        
        
    }
    
    return self;
}


@end