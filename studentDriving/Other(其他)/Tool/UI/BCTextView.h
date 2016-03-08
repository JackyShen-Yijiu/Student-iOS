//
//  BCTextView.h
//  studentDriving
//
//  Created by bestseller on 15/10/29.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCTextView : UITextView
@property (strong, nonatomic) UILabel *placeholder;
- (instancetype)initWithFrame:(CGRect)frame withPlaceholder:(NSString *)placeholder;
@end
