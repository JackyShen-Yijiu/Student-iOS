//
//  ShowWarningBG.m
//  studentDriving
//
//  Created by zyt on 16/2/22.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "ShowWarningBG.h"

@interface ShowWarningBG ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *warnImageView;
@property (nonatomic, strong) UILabel *titleNameLabel;
@property (nonatomic, strong) NSString *titleName;

@end

@implementation ShowWarningBG

- (instancetype)initWithTietleName:(NSString *)titleName{
    if (self = [super init]) {
        self.titleName = titleName;
        [self initUI];
    }
    return self;
}
- (void)initUI{
    self.titleNameLabel.text = self.titleName;
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.warnImageView];
    [self.bgView addSubview:self.titleNameLabel];
}

- (void)show
{
    UINavigationController * rsm = (UINavigationController *)[[UIApplication sharedApplication].delegate window].rootViewController;
    if (_controller && [rsm visibleViewController] == _controller) {
        UIWindow * win = [[UIApplication sharedApplication].delegate window];
        for (UIView * view in [win subviews]) {
            if ([view isKindOfClass:[ShowWarningBG class]] ) {
                return;
            }
        }
        for (UIView * view in [_controller.view subviews]) {
            if ([view isKindOfClass:[ShowWarningBG class]] ) {
                return;
            }
        }
        [_controller.view addSubview:self];
    }else{
        UIWindow * win = [[UIApplication sharedApplication].delegate window];
        for (UIView * view in [win subviews]) {
            if ([view isKindOfClass:[ShowWarningBG class]] ) {
                return;
            }
        }
//         [_controller.view addSubview:self];
        [win addSubview:self];
    }
}
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor clearColor];
        _bgView.frame = CGRectMake(0, (kSystemHeight - 75 - 10 - 14) / 2, kSystemWide, 75 + 10 + 14);
        
    }
    return _bgView;
}
- (UIImageView *)warnImageView{
    if (_warnImageView == nil) {
        _warnImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kSystemWide - 72) / 2, 0, 72, 75)];
        _warnImageView.image = [UIImage imageNamed:@"app_error_robot"];
        
    }
    return _warnImageView;
    
}
- (UILabel *)titleNameLabel{
    if (_titleNameLabel == nil) {
        _titleNameLabel = [[UILabel alloc] initWithFrame:CGRectMake((kSystemWide - 200) / 2, 75 + 10, 200, 14)];
        _titleNameLabel.textColor = [UIColor colorWithHexString:@"bdbdbd"];
        _titleNameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleNameLabel;
}

@end
