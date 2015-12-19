//
//  ChooseBtnView.h
//  chooseView
//
//  Created by 胡东苑 on 15/12/13.
//  Copyright © 2015年 胡东苑. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseBtnView : UIView

/**
 * which代表那个btn 左0，中1，右2  字符串代表标题
 */
- (id)initWithSelectedBtn:(NSInteger)whichBtn leftTitle:(NSString *)leftStr midTitle:(NSString *)midTitle rightTitle:(NSString *)rightStr frame:(CGRect)frame;

@end
