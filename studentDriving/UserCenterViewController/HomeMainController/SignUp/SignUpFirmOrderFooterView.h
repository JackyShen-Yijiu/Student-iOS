//
//  SignUpFirmOrderFooterView.h
//  studentDriving
//
//  Created by ytzhang on 16/1/29.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpFirmOrderFooterView : UIView
@property (nonatomic, strong) UILabel *discountLabel;
@property (nonatomic, strong) UILabel *realPayLabel;
@property (nonatomic, strong) UILabel *discountPayLabel;
- (UIView *)initWithFrame:(CGRect)frame Discount:(NSString *)discountMoney realMoney:(NSString *)realMoney schoolName:(NSString *)schoolName;
@end
