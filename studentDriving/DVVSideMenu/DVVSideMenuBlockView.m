//
//  DVVSideMenuBlockView.m
//  studentDriving
//
//  Created by 大威 on 15/12/24.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "DVVSideMenuBlockView.h"
#import "DVVSideMenuBlockViewItemButton.h"

@interface DVVSideMenuBlockView()

@property (nonatomic, copy)DVVSideMenuBlockViewSelectedBlock itemSelectedBlock;

@end

@implementation DVVSideMenuBlockView

- (instancetype)initWithTitleArray:(NSArray *)array {
    self = [super init];
    if (self) {
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString *title = (NSString *)obj;
            DVVSideMenuBlockViewItemButton *button = [DVVSideMenuBlockViewItemButton new];
            button.tag = idx;
            [button setTitle:title forState:UIControlStateNormal];
            [self addSubview:button];
            button.backgroundColor = [UIColor clearColor];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
        }];
    }
    return self;
}

- (void)buttonAction:(UIButton *)button {
    if (_itemSelectedBlock) {
        _itemSelectedBlock(button);
    }
}

- (void)dvvSideMenuBlockViewItemSelected:(DVVSideMenuBlockViewSelectedBlock)handle {
    _itemSelectedBlock = handle;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    CGFloat selfWidth = rect.size.width;
    CGFloat selfHeight = rect.size.height;
    
    CGFloat tempFloat = selfWidth;
    // 视图的左侧内边距
    CGFloat leftMargin = 12;
    // 按钮的间距
    CGFloat buttonSpace = 3;
    // 一行按钮的个数
    NSUInteger buttonNum = 3;
    // 按钮的边长
    CGFloat buttonSideLength = 0;
    if (selfHeight < selfWidth ) {
        tempFloat = selfHeight;
        buttonSideLength = (tempFloat - buttonSpace * (buttonNum + 1)) / buttonNum;
    }else {
        buttonSideLength = (tempFloat - leftMargin * 2 - buttonSpace * (buttonNum + 1)) / buttonNum;
    }
    
    if (selfHeight < selfWidth) {
        leftMargin = (selfWidth - selfHeight) / 2.f;
    }
    
    NSUInteger arrayNum = self.titleArray.count;
    NSUInteger line = 0;
    if (arrayNum % buttonNum) {
        line = arrayNum / buttonNum + 1;
    }else {
        line = arrayNum / buttonNum;
    }
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = (UIButton *)obj;
        button.frame = CGRectMake(leftMargin + buttonSpace +(buttonSpace + buttonSideLength) * (button.tag % 3),
                                  buttonSpace + (buttonSpace + buttonSideLength) * (button.tag / 3),
                                  buttonSideLength,
                                  buttonSideLength);
        [button setBackgroundImage:[UIImage imageNamed:[_iconNormalArray objectAtIndex:idx]] forState:UIControlStateNormal];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
