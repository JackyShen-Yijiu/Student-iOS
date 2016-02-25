//
//  DVVPromptNilDataView.m
//  studentDriving
//
//  Created by 大威 on 16/2/23.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVPromptNilDataView.h"

@implementation DVVPromptNilDataView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        CGFloat selfWidth = 300;
        
        CGFloat imageHeight = 75;
        
        CGFloat labelHeight = 30;
        
        _imageView = [UIImageView new];
        _imageView.frame = CGRectMake(0, 0, selfWidth, imageHeight);
        _imageView.contentMode = UIViewContentModeCenter;
        _imageView.image = [UIImage imageNamed:@"app_error_robot"];
        
        _promptLabel = [UILabel new];
        _promptLabel.frame = CGRectMake(0, imageHeight, selfWidth, labelHeight);
        _promptLabel.textAlignment = NSTextAlignmentCenter;
        _promptLabel.textColor = [UIColor lightGrayColor];
        _promptLabel.font = [UIFont systemFontOfSize:12];
        
        self.bounds = CGRectMake(0, 0, selfWidth, imageHeight + labelHeight);
        
        [self addSubview:self.imageView];
        [self addSubview:self.promptLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSLog(@"");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
