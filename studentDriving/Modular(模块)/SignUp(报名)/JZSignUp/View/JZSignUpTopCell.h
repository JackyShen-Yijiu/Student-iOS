//
//  JZSignUpTopCell.h
//  studentDriving
//
//  Created by ytzhang on 16/3/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZSignUpTopCell : UITableViewCell

typedef void(^signUpRowCell_TextFieldBlock)(UITextField *textField, JZSignUpTopCell *cell);

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UIView *lineView;

- (void)dvvBaseDoubleRowCell_setTextFieldDidBeginEditingBlock:(signUpRowCell_TextFieldBlock)didBeginEditingBlock;

- (void)dvvBaseDoubleRowCell_setTextFieldDidEndEditingBlock:(signUpRowCell_TextFieldBlock)didEndEditingBlock;

@end
