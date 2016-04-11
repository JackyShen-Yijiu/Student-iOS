//
//  JZComplaintLeftView.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/10.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZComplaintLeftView.h"
#define kLKSize [UIScreen mainScreen].bounds.size

@implementation JZComplaintLeftView


-(instancetype)initWithFrame:(CGRect)frame {
    
    
    if (self = [super initWithFrame:frame]) {
        
        self = [[NSBundle mainBundle] loadNibNamed:@"JZComplaintLeftView" owner:self options:nil].lastObject;
        
        self.frame = CGRectMake(0, 108, kLKSize.width, 133);
        
//        self.userInteractionEnabled = YES;
//        self.anonymitySwitch.userInteractionEnabled = YES;
//        
//        [self.anonymitySwitch addTarget:self action:@selector(switchClick) forControlEvents:UIControlEventTouchUpInside];
//        
//        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(switchClick)];
//        
//        [self addGestureRecognizer:tap];
        
    }
    
    return self;
}

//-(void)awakeFromNib
//{
//            self.frame = CGRectMake(0, 108, kLKSize.width, 133);
//    
//            self.userInteractionEnabled = YES;
////            self.anonymitySwitch.userInteractionEnabled = YES;
////    
////            [self.anonymitySwitch addTarget:self action:@selector(switchClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(switchClick)];
//    
//            [self addGestureRecognizer:tap];
//    
//    
//}

-(void)switchClick {
    
    NSLog(@"点击了");
}


@end
