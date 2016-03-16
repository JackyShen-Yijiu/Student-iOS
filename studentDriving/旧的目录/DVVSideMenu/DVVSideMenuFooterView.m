//
//  DVVSideMenuFooterView.m
//  DVVSideMenu
//
//  Created by 大威 on 15/12/22.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import "DVVSideMenuFooterView.h"

@implementation DVVSideMenuFooterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.contactUsLabel];
        [self addSubview:self.markLabel];
//        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];
    }
    return self;
}

#pragma mark - action
#pragma mark 联系我们
- (void)contactUsLabelAction {
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4006269255"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:callWebview];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    CGFloat selfWidth = rect.size.width;
    _contactUsLabel.frame = CGRectMake(15, 0, selfWidth - 15, 20);
    _markLabel.frame = CGRectMake(15, 20, selfWidth - 15, 20);
}

#pragma mark - lazy load
- (UILabel *)contactUsLabel {
    if (!_contactUsLabel) {
        _contactUsLabel = [UILabel new];
        _contactUsLabel.font = [UIFont systemFontOfSize:12];
        _contactUsLabel.textColor = [UIColor colorWithWhite:1 alpha:1];
        _contactUsLabel.backgroundColor = [UIColor clearColor];
        _contactUsLabel.text = @"联系我们：400-101-6669";
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contactUsLabelAction)];
        [_contactUsLabel addGestureRecognizer:tapGesture];
        _contactUsLabel.userInteractionEnabled = YES;
    }
    return _contactUsLabel;
}
- (UILabel *)markLabel {
    if (!_markLabel) {
        _markLabel = [UILabel new];
        _markLabel.font = [UIFont systemFontOfSize:12];
        _markLabel.textColor = [UIColor colorWithWhite:1 alpha:1];
        _markLabel.backgroundColor = [UIColor clearColor];
        _markLabel.text = @"北京一步科技有限公司荣誉出品";
    }
    return _markLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
