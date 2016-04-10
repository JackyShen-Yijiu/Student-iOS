//
//  YBTextView.h
//  studentDriving
//
//  Created by JiangangYang on 16/2/24.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBTextView : UITextView
@property (strong, nonatomic) UILabel *placeholderLabel;
- (instancetype)initWithFrame:(CGRect)frame withPlaceholder:(NSString *)placeholder;
@end
