//
//  DVVConfirmOrderFooterView.m
//  studentDriving
//
//  Created by 大威 on 16/2/25.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVConfirmOrderFooterView.h"

@interface DVVConfirmOrderFooterView ()

@property (nonatomic, copy) dispatch_block_t firstButtonActionBlock;
@property (nonatomic, copy) dispatch_block_t secondButtonActionBlock;

@end

@implementation DVVConfirmOrderFooterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"DVVConfirmOrderFooterView" owner:self options:nil];
        self = xibArray.firstObject;
        
        [_firstImageButton setImage:[UIImage imageNamed:@"ic_single_selection_no"] forState:UIControlStateNormal];
        [_firstImageButton setImage:[UIImage imageNamed:@"ic_single_selection_yes"] forState:UIControlStateSelected];
        
        [_secondImageButton setImage:[UIImage imageNamed:@"ic_single_selection_no"] forState:UIControlStateNormal];
        [_secondImageButton setImage:[UIImage imageNamed:@"ic_single_selection_yes"] forState:UIControlStateSelected];
        
        // 阴影效果
        _toolBarView.layer.shadowColor = [UIColor blackColor].CGColor;
        _toolBarView.layer.shadowOffset = CGSizeMake(0, 2);
        _toolBarView.layer.shadowOpacity = 0.3;
        _toolBarView.layer.shadowRadius = 2;
        
        // 提示标题颜色
        _promptTitleLabel.textColor = YBNavigationBarBgColor;
        
        // 默认选中支付宝支付
        [self firstButtonAction:nil];
        
        CGSize size = [UIScreen mainScreen].bounds.size;
        
        self.frame = CGRectMake(0, 0, size.width, 170);
        
        self.backgroundColor = [UIColor colorWithHexString:@"EEEEEE"];
        
        // 暂时没做微信支付，先给隐藏了
        _secondImageButton.hidden = YES;
        _secondLabel.hidden = YES;
        _secondButton.hidden = YES;
    }
    return self;
}

- (IBAction)firstButtonAction:(UIButton *)sender {
    _firstImageButton.selected = YES;
    _firstLabel.textColor = YBNavigationBarBgColor;
    
    _secondImageButton.selected = NO;
    _secondLabel.textColor = [UIColor blackColor];
    
    if (_firstButtonActionBlock) {
        _firstButtonActionBlock();
    }
}

- (IBAction)secondButtonAction:(UIButton *)sender {
    _secondImageButton.selected = YES;
    _secondLabel.textColor = YBNavigationBarBgColor;
    
    _firstImageButton.selected = NO;
    _firstLabel.textColor = [UIColor blackColor];
    
    if (_secondButtonActionBlock) {
        _secondButtonActionBlock();
    }
}

#pragma mark - set block

- (void)setFirstButtonActionBlock:(dispatch_block_t)handle {
    _firstButtonActionBlock = handle;
}

- (void)setSecondButtonActionBlock:(dispatch_block_t)handle {
    _secondButtonActionBlock = handle;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
