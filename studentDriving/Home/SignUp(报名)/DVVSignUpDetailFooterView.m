//
//  DVVSignUpDetailFooterView.m
//  studentDriving
//
//  Created by 大威 on 16/2/24.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVSignUpDetailFooterView.h"
#import "NSString+Helper.h"

@interface DVVSignUpDetailFooterView ()

@property (nonatomic, copy) dispatch_block_t onLineButtonActionBlock;
@property (nonatomic, copy) dispatch_block_t offLineButtonActionBlock;

@end

@implementation DVVSignUpDetailFooterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"DVVSignUpDetailFooterView" owner:self options:nil];
        self = xibArray.firstObject;
        
        [_onLineButton setImage:[UIImage imageNamed:@"ic_single_selection_no"] forState:UIControlStateNormal];
        [_onLineButton setImage:[UIImage imageNamed:@"ic_single_selection_yes"] forState:UIControlStateSelected];
        
        [_offLineButton setImage:[UIImage imageNamed:@"ic_single_selection_no"] forState:UIControlStateNormal];
        [_offLineButton setImage:[UIImage imageNamed:@"ic_single_selection_yes"] forState:UIControlStateSelected];
        
        // 阴影效果
        _toolBarView.layer.shadowColor = [UIColor blackColor].CGColor;
        _toolBarView.layer.shadowOffset = CGSizeMake(0, 2);
        _toolBarView.layer.shadowOpacity = 0.3;
        _toolBarView.layer.shadowRadius = 2;
        
        // 提示标题颜色
        _promptTitleLabel.textColor = YBNavigationBarBgColor;
        
        CGSize size = [UIScreen mainScreen].bounds.size;
        
        CGFloat contentHeight = [NSString autoHeightWithString:_contentLabel.text width:size.width - 16*2 font:[UIFont systemFontOfSize:10]];
        
        self.frame = CGRectMake(0, 0, size.width, 98 + contentHeight + 16);
        
        // 初始选中线上支付
        [self onLineButtonAction:nil];
    }
    return self;
}
- (IBAction)onLineButtonAction:(UIButton *)sender {
    _onLineButton.selected = YES;
    _onLineLabel.textColor = YBNavigationBarBgColor;
    
    _offLineButton.selected = NO;
    _offLineLabel.textColor = [UIColor blackColor];
    
    if (_onLineButtonActionBlock) {
        _onLineButtonActionBlock();
    }
}
- (IBAction)offLineButtonActon:(UIButton *)sender {
    _offLineButton.selected = YES;
    _offLineLabel.textColor = YBNavigationBarBgColor;
    
    _onLineButton.selected = NO;
    _onLineLabel.textColor = [UIColor blackColor];
    
    if (_offLineButtonActionBlock) {
        _offLineButtonActionBlock();
    }
}

#pragma mark - set block

- (void)setOnLineButtonActionBlock:(dispatch_block_t)handle {
    _onLineButtonActionBlock = handle;
}

- (void)setOffLineButtonActionBlock:(dispatch_block_t)handle {
    _offLineButtonActionBlock = handle;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
