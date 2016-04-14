//
//  HowAddJiFenView.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "HowAddJiFenView.h"

#define kLKSize [UIScreen mainScreen].bounds.size

@implementation HowAddJiFenView

-(instancetype)initWithFrame:(CGRect)frame {
    
    
    if (self = [super initWithFrame:frame]) {
        
        self = [[NSBundle mainBundle] loadNibNamed:@"HowAddJiFenView" owner:self options:nil].lastObject;
        
        self.frame = frame;
        
        
      
        
        
    }
    
    return self;
}

@end
