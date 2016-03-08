//
//  SCPAlert_CustomeView.m
//  SohuCloudPics
//
//  Created by sohu on 12-12-28.
//
//

#import "ToastAlertView.h"

@implementation ToastAlertView

- (id)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        
        UIFont *titleFont = [UIFont systemFontOfSize:16];
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        
        CGFloat alertWidth = screenWidth - 20;
        CGFloat alertHeight = [self autoHeightWithString:title Width:alertWidth Font:titleFont];
        // 测试出来的实际显示所需要的宽度
        CGFloat testWidth = [self autoWidthWithString:title Font:titleFont];
        
        CGRect rect = [[UIScreen mainScreen] bounds];
        _alertboxImageView = [[UIImageView alloc] init];
        _alertboxImageView.image = [UIImage imageNamed:@"popup_alert.png"];
        [self addSubview:_alertboxImageView];
        
        _title = [[UILabel alloc] init];
        _title.numberOfLines = 0;
        _title.textAlignment = NSTextAlignmentCenter;
        _title.backgroundColor = [UIColor clearColor];
        _title.font = titleFont;
        _title.textColor = [UIColor whiteColor];
        _title.text = title;
        [_alertboxImageView addSubview:_title];
        
        if (testWidth + 40 > screenWidth) {
            
            _alertboxImageView.frame = CGRectMake(0, 0, screenWidth - 20, alertHeight + 20);
            _title.frame = CGRectMake(10, 10, screenWidth - 40, alertHeight);
        }else {
            
            _alertboxImageView.frame = CGRectMake(0, 0, testWidth + 20, 60);
            _title.frame = CGRectMake(10, 10, testWidth, 40);
            _title.center = CGPointMake((testWidth + 20) / 2.f, 30);
        }
        _alertboxImageView.center = CGPointMake(rect.size.width / 2.f, rect.size.height / 2.f);
    }
    return self;
}

- (void)dismiss
{
    [self removeFromSuperview];
}

- (id)initWithTitle:(NSString *)title controller:(id)viewcontroller
{
    if (self = [super init]) {
        _controller = [viewcontroller isKindOfClass:[UIViewController class]]? viewcontroller :nil;
        CGRect rect = [[UIScreen mainScreen] bounds];
        _alertboxImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _alertboxImageView.image = [[UIImage imageNamed:@"popup_alert.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
        [self addSubview:_alertboxImageView];
        
        _title = [[UILabel alloc] initWithFrame:CGRectZero];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.backgroundColor = [UIColor clearColor];
        _title.font = [UIFont systemFontOfSize:16];
        _title.textColor = [UIColor whiteColor];
        _title.text = title;
        [_title sizeToFit];
        _alertboxImageView.frame = CGRectMake(0, 0, _title.frame.size.width + 56, 44);
        _alertboxImageView.center = CGPointMake(rect.size.width / 2.f, rect.size.height / 2.f);
        _title.center = CGPointMake(_alertboxImageView.frame.size.width /2.f, _alertboxImageView.frame.size.height/2.f);
        [_alertboxImageView addSubview:_title];
    }
    return self;
}

- (void)show
{
    UINavigationController * rsm = (UINavigationController *)[[UIApplication sharedApplication].delegate window].rootViewController;
    if (_controller && [rsm visibleViewController] == _controller) {
        UIWindow * win = [[UIApplication sharedApplication].delegate window];
        for (UIView * view in [win subviews]) {
            if ([view isKindOfClass:[ToastAlertView class]] ) {
                return;
            }
        }
        for (UIView * view in [_controller.view subviews]) {
            if ([view isKindOfClass:[ToastAlertView class]] ) {
                return;
            }
        }
        [_controller.view addSubview:self];
    }else{
        UIWindow * win = [[UIApplication sharedApplication].delegate window];
        for (UIView * view in [win subviews]) {
            if ([view isKindOfClass:[ToastAlertView class]] ) {
                return;
            }
        }
        [win addSubview:self];
    }
    
    double delayInSeconds = 1.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self dismiss];
    });
}

#pragma mark 一串字符在固定宽度下，正常显示所需要的高度 method
- (CGFloat)autoHeightWithString:(NSString *)string Width:(CGFloat)width Font:(UIFont *)font {
    
    //大小
    CGSize boundRectSize = CGSizeMake(width, MAXFLOAT);
    //绘制属性（字典）
    NSDictionary *fontDict = @{ NSFontAttributeName: font };
    //调用方法,得到高度
    CGFloat newFloat = [string boundingRectWithSize:boundRectSize
                                            options: NSStringDrawingUsesLineFragmentOrigin
                        | NSStringDrawingUsesFontLeading
                                         attributes:fontDict context:nil].size.height;
    return newFloat;
}
#pragma mark 一串字符在一行中正常显示所需要的宽度 method
- (CGFloat)autoWidthWithString:(NSString *)string Font:(UIFont *)font {
    
    //大小
    CGSize boundRectSize = CGSizeMake(MAXFLOAT, font.lineHeight);
    //绘制属性（字典）
    NSDictionary *fontDict = @{ NSFontAttributeName: font };
    //调用方法,得到高度
    CGFloat newFloat = [string boundingRectWithSize:boundRectSize
                                            options: NSStringDrawingUsesLineFragmentOrigin
                        | NSStringDrawingUsesFontLeading
                                         attributes:fontDict context:nil].size.width;
    return newFloat;
}


@end
