//
//  KindlyReminderView.m
//  chooseView
//
//  Created by 胡东苑 on 15/12/13.
//  Copyright © 2015年 胡东苑. All rights reserved.
//

#import "KindlyReminderView.h"
#import "Masonry.h"

@interface KindlyReminderView ()

@property (nonatomic, strong) UILabel *titleLb;

@property (nonatomic, strong) UILabel *contentLb;

@end

@implementation KindlyReminderView


- (id)initWithContentStr:(NSString *)str frame:(CGRect)frame {
    self = [super init];
    if (self) {
        self.frame = frame;
        [self addUI];
        [self configeUI:str];
        [self updateUI];
    }
    return self;
}

- (void)addUI {
    _titleLb = [[UILabel alloc] init];
    _contentLb = [[UILabel alloc] init];
    [self addSubview:_titleLb];
    [self addSubview:_contentLb];
}

- (void)configeUI:(NSString *)str {
    _titleLb.text = @"温馨提示:";
    _contentLb.text = [NSString stringWithFormat:@"       %@",str];
    
    _titleLb.font = [UIFont systemFontOfSize:12];
    _contentLb.font = [UIFont systemFontOfSize:12];
    
    _contentLb.numberOfLines = 0;
    
    _titleLb.textColor = [UIColor redColor];
    _contentLb.textColor = [UIColor blackColor];
}

- (void)updateUI {
    __weak typeof(self) weakSelf = self;
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(100, 12));
    }];
    [_contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(_titleLb.mas_bottom).offset(11);
        make.width.mas_equalTo(weakSelf.frame.size.width -30);
    }];
    [_contentLb sizeToFit];
}


@end
