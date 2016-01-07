//
//  DVVSideMenuBlockView.m
//  studentDriving
//
//  Created by 大威 on 15/12/24.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "DVVSideMenuBlockView.h"
#import "DVVSideMenuBlockViewItemButton.h"
#import "AcountManager.h"

#define badgeLabelWidth 9

@interface DVVSideMenuBlockView()

@property (nonatomic, copy)DVVSideMenuBlockViewSelectedBlock itemSelectedBlock;

@property (nonatomic, strong) UILabel *badgeLabel;

@end

@implementation DVVSideMenuBlockView

- (instancetype)initWithTitleArray:(NSArray *)array
                   iconNormalArray:(NSArray *)iconNormalArray {
    self = [super init];
    if (self) {
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString *title = (NSString *)obj;
            DVVSideMenuBlockViewItemButton *button = [DVVSideMenuBlockViewItemButton new];
            button.tag = idx;
            [button setTitle:title forState:UIControlStateNormal];
            
            [button setImage:[UIImage imageNamed:[iconNormalArray objectAtIndex:idx]] forState:UIControlStateNormal];
            
            [self addSubview:button];
            button.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
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
            self.badgeLabel.center = CGPointMake(viewWidth, 0);
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
        self.badgeLabel.text = [NSString stringWithFormat:@"%li",unreadCount];
    }else{
//        [self hiddenMessCountInTabBar];
        [self removeBadge];
    }
//    UIApplication *application = [UIApplication sharedApplication];
//    [application setApplicationIconBadgeNumber:unreadCount];
}

#pragma mark 显示搜索的类型是驾校还是教练
- (void)setLocationShowType {
    
//    if ([AcountManager manager].userLocationShowType == kLocationShowTypeDriving) {
//        [self setShowTypeWithTitle:@"查找驾校"];
//    }else {
//        [self setShowTypeWithTitle:@"查找教练"];
//    }
}
- (void)setShowTypeWithTitle:(NSString *)title {
    for (DVVSideMenuBlockViewItemButton *button in self.subviews) {
        if (1 == button.tag) {
            [button setTitle:title forState:UIControlStateNormal];
        }
    }
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
        [_badgeLabel.layer setMasksToBounds:YES];
        [_badgeLabel.layer setCornerRadius:badgeLabelWidth / 2.f];
        _badgeLabel.font = [UIFont systemFontOfSize:badgeLabelWidth - 3];
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
