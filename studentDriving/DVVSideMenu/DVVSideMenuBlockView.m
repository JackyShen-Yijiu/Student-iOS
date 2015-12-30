//
//  DVVSideMenuBlockView.m
//  studentDriving
//
//  Created by 大威 on 15/12/24.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "DVVSideMenuBlockView.h"
#import "DVVSideMenuBlockViewItemButton.h"

#define badgeLabelWidth 20

@interface DVVSideMenuBlockView()

@property (nonatomic, copy)DVVSideMenuBlockViewSelectedBlock itemSelectedBlock;

@property (nonatomic, strong) UILabel *badgeLabel;

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

#pragma mark 显示、隐藏小红点
- (void)showBadge {
    for (UIView *view in self.subviews) {
        if (2 == view.tag) {
            CGFloat viewWidth = view.frame.size.width;
            self.badgeLabel.center = CGPointMake(viewWidth - badgeLabelWidth / 2.f, badgeLabelWidth / 2.f);
            [view addSubview:self.badgeLabel];
        }
    }
}
- (void)removeBadge {
    [self.badgeLabel removeFromSuperview];
}

-(void)setupUnreadMessageCount
{
    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    if (unreadCount > 0) {
//        [self showMessCountInTabBar:unreadCount];
        [self showBadge];
    }else{
//        [self hiddenMessCountInTabBar];
        [self removeBadge];
    }
//    UIApplication *application = [UIApplication sharedApplication];
//    [application setApplicationIconBadgeNumber:unreadCount];
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
    CGFloat buttonSpace = 1;
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

#pragma mark - lazy load
- (UILabel *)badgeLabel {
    if (!_badgeLabel) {
        _badgeLabel = [UILabel new];
        _badgeLabel.backgroundColor = [UIColor redColor];
        _badgeLabel.frame = CGRectMake(0, 0, badgeLabelWidth, badgeLabelWidth);
    }
    return _badgeLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
