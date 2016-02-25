//
//  DVVBaseDoubleRowCell.h
//  studentDriving
//
//  Created by 大威 on 16/2/24.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVVBaseDoubleRowCell : UITableViewCell<UITextFieldDelegate>

typedef void(^DVVBaseDoubleRowCell_TextFieldBlock)(UITextField *textField, DVVBaseDoubleRowCell *cell);

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *detailTextField;

@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, strong) UIImageView *promptImageView;

@property (nonatomic, strong) UIImageView *separatorImageView;

- (void)showPrompt;

- (void)hiddenPrompt;

- (void)dvvBaseDoubleRowCell_setTextFieldDidBeginEditingBlock:(DVVBaseDoubleRowCell_TextFieldBlock)didBeginEditingBlock;

- (void)dvvBaseDoubleRowCell_setTextFieldDidEndEditingBlock:(DVVBaseDoubleRowCell_TextFieldBlock)didEndEditingBlock;


@end
