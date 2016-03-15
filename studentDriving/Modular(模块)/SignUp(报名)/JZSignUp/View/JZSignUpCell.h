//
//  JZSignUpCell.h
//  studentDriving
//
//  Created by ytzhang on 16/3/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
          
@interface JZSignUpCell : UITableViewCell <UITextFieldDelegate>

typedef void(^SignUpRowCell_TextFieldBlock)(UITextField *textField, JZSignUpCell *cell);

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITextField *desTextFiled;

@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UIView *lineView;

- (void)dvvBaseDoubleRowCell_setTextFieldDidBeginEditingBlock:(SignUpRowCell_TextFieldBlock)didBeginEditingBlock;

- (void)dvvBaseDoubleRowCell_setTextFieldDidEndEditingBlock:(SignUpRowCell_TextFieldBlock)didEndEditingBlock;

@end
