//
//  HomeMainView.m
//  TestCar
//
//  Created by ytzhang on 15/12/14.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "HomeMainView.h"
#import "CircularMotion.h"

#define systemsW [[UIScreen mainScreen] bounds].size.width

#define systemsH  [[UIScreen mainScreen] bounds].size.height


@interface HomeMainView ()

@property (nonatomic, strong) CircularMotion * oneCM;
@property (nonatomic, strong) CircularMotion * twoCM;
@property (nonatomic, strong) CircularMotion * threeCM;

@property (nonatomic, strong) UIButton *coachCardButton;

@property (nonatomic, strong) UIButton *schoolCardButton;

@property (nonatomic, strong) UIButton *signButton;

@property (nonatomic, strong) UIImageView *textImageView;

@end

@implementation HomeMainView


- (instancetype)initWithFrame:(CGRect)frame SearchType:(kSearchType)searchType
{
    CGFloat imageY = 20;
    CGFloat imageViewH = 42;
    CGFloat imageViewW = 186;
    
    CGFloat coachCardButtonW = 96;
    CGFloat schoolCardButton = 128;
    CGFloat signButton = 68;
    
    
    
    
    
    if (self = [super initWithFrame:frame]) {
        /*
         *coachCard  ,driverSchoolCard  ,
         */
        _kSearchType = searchType;
        switch (searchType) {
            case kSearchMainView:
            {
                // 首页视图
                
                _textImageView = [[UIImageView alloc] initWithFrame:CGRectMake((systemsW - imageViewW) / 2, imageY, imageViewW, imageViewH)];
                _textImageView.image = [UIImage imageNamed:@"文字"];
                
                CGFloat coachCardButtonX = (systemsW - coachCardButtonW - schoolCardButton + 23) / 2 ;
                _coachCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _coachCardButton.frame = CGRectMake(coachCardButtonX, 120, coachCardButtonW, coachCardButtonW);
                [self addButtonProperty:@"教练卡" button:_coachCardButton];
                [_coachCardButton setBackgroundImage:[UIImage imageNamed:@"驾校优势"] forState:UIControlStateNormal];
                _coachCardButton.tag = 101;
                [_coachCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];

                
                _schoolCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _schoolCardButton.frame = CGRectMake(_coachCardButton.frame.origin.x + 74, _coachCardButton.frame.origin.y + 48, schoolCardButton, schoolCardButton);
                [_schoolCardButton setBackgroundImage:[UIImage imageNamed:@"驾校优惠"] forState:UIControlStateNormal];
                [_schoolCardButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                _schoolCardButton.tag = 102;
                [_schoolCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
             
                
                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _signButton.frame = CGRectMake(_coachCardButton.frame.origin.x + 4, 228, signButton, signButton);
                [self addButtonProperty:@"报名" button:_signButton];
                [_signButton setBackgroundImage:[UIImage imageNamed:@"承诺"] forState:UIControlStateNormal];
                _signButton.tag = 103;
               [_signButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
               
                [self addSubview:_textImageView];
                [self addSubview:_coachCardButton];
                [self addSubview:_schoolCardButton];
                [self addSubview:_signButton];
                
                // 滚动
//                _oneCM = [CircularMotion new];
//                [_oneCM circularMotionWithView:_schoolCardButton Radius:10];
//                [_oneCM startMotionWithTimeInterval:0.01];
//                
//                _twoCM = [CircularMotion new];
//                [_twoCM circularMotionWithView:_coachCardButton Radius:7];
//                [_twoCM startMotionWithTimeInterval:0.01];
//                
//                _threeCM = [CircularMotion new];
//                [_threeCM circularMotionWithView:_signButton Radius:8];
//                [_threeCM startMotionWithTimeInterval:0.01];

            }
                break;
            case KSubjectOneView:
                
            {
                // 科目一
                // 首页视图
                _textImageView = [[UIImageView alloc] initWithFrame:CGRectMake((systemsW - imageViewW) / 2, imageY, imageViewW, imageViewH)];
                _textImageView.image = [UIImage imageNamed:@"文字"];
                
                
                CGFloat signButtonX = (systemsW - schoolCardButton - coachCardButtonW + 15) / 2 ;

                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _signButton.frame = CGRectMake(signButtonX, 150, schoolCardButton, schoolCardButton);
                [self addButtonProperty:@"报名" button:_signButton];
                [_signButton setBackgroundImage:[UIImage imageNamed:@"题库1"] forState:UIControlStateNormal];
                _signButton.tag = 103;
                [_signButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];

                
                _coachCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _coachCardButton.frame = CGRectMake(_signButton.frame.origin.x + schoolCardButton - 15, _signButton.frame.origin.y + 78, coachCardButtonW, coachCardButtonW);
                [self addButtonProperty:@"科目一" button:_coachCardButton];
                [_coachCardButton setBackgroundImage:[UIImage imageNamed:@"模考1"] forState:UIControlStateNormal];
                _coachCardButton.tag = 101;
                [_coachCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
               
                
                _schoolCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _schoolCardButton.frame = CGRectMake(_coachCardButton.frame.origin.x + 10, _signButton.frame.origin.y - 50, signButton, signButton);
                [self addButtonProperty:@"题库1" button:_schoolCardButton];
                [_schoolCardButton setBackgroundImage:[UIImage imageNamed:@"错题1"] forState:UIControlStateNormal];
                _schoolCardButton.tag = 102;
                [_schoolCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                [self addSubview:_signButton];
                [self addSubview:_textImageView];
                [self addSubview:_coachCardButton];
                [self addSubview:_schoolCardButton];
                

                
            }
                break;
            case KSubjectTwoView:
            {
                // 科目二
                // 首页视图
                
                _textImageView = [[UIImageView alloc] initWithFrame:CGRectMake((systemsW - imageViewW) / 2, imageY, imageViewW, imageViewH)];
                _textImageView.image = [UIImage imageNamed:@"文字"];
                _coachCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                 CGFloat signButtonX = (systemsW - schoolCardButton - coachCardButtonW + 60) / 2 ;
                _coachCardButton.frame = CGRectMake(signButtonX, 100, schoolCardButton, schoolCardButton);
                [self addButtonProperty:@"科目二" button:_coachCardButton];
                [_coachCardButton setBackgroundImage:[UIImage imageNamed:@"课件2"] forState:UIControlStateNormal];                _coachCardButton.tag = 101;
                [_coachCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _signButton.frame = CGRectMake(_coachCardButton.frame.origin.x + schoolCardButton - 60, _coachCardButton.frame.origin.y + schoolCardButton - 16,coachCardButtonW, coachCardButtonW);
                [self addButtonProperty:@"报名" button:_signButton];
                [_signButton setBackgroundImage:[UIImage imageNamed:@"预约列表2"] forState:UIControlStateNormal];                _signButton.tag = 103;
                [_signButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];

                _schoolCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _schoolCardButton.frame = CGRectMake(_signButton.frame.origin.x - signButton - 30, _signButton.frame.origin.y + 50, signButton, signButton);
                [self addButtonProperty:@"视频" button:_schoolCardButton];
                [_schoolCardButton setBackgroundImage:[UIImage imageNamed:@"预约2"] forState:UIControlStateNormal];                _schoolCardButton.tag = 102;
                [_schoolCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                
                [self addSubview:_textImageView];
                [self addSubview:_coachCardButton];
                [self addSubview:_signButton];
                 [self addSubview:_schoolCardButton];

            }
                break;
            case KSubjectThreeView:
            {
                // 科目三
                // 首页视图
                _textImageView = [[UIImageView alloc] initWithFrame:CGRectMake((systemsW - imageViewW) / 2, imageY, imageViewW, imageViewH)];
                _textImageView.image = [UIImage imageNamed:@"文字"];
                
                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                CGFloat signButtonX = (systemsW - schoolCardButton - coachCardButtonW - 10) / 2;
                _signButton.frame = CGRectMake(signButtonX, 150, schoolCardButton, schoolCardButton);
                [self addButtonProperty:@"报名" button:_signButton];
                [_signButton setBackgroundImage:[UIImage imageNamed:@"预约列表3"] forState:UIControlStateNormal];
                _signButton.tag = 103;
                [_signButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];

                
                _coachCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _coachCardButton.frame = CGRectMake(_signButton.frame.origin.x + schoolCardButton + 10, _signButton.frame.origin.y - 30, coachCardButtonW, coachCardButtonW);
                [self addButtonProperty:@"科目三" button:_coachCardButton];
                [_coachCardButton setBackgroundImage:[UIImage imageNamed:@"课件3"] forState:UIControlStateNormal];
                _coachCardButton.tag = 101;
                [_coachCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                _schoolCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _schoolCardButton.frame = CGRectMake(_signButton.frame.origin.x + schoolCardButton + 10, _signButton.frame.origin.y + schoolCardButton - 30, signButton, signButton);
                [self addButtonProperty:@"视频" button:_schoolCardButton];
                 [_schoolCardButton setBackgroundImage:[UIImage imageNamed:@"预约3"] forState:UIControlStateNormal];
                _schoolCardButton.tag = 102;
                [_schoolCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                [self addSubview:_signButton];
                [self addSubview:_textImageView];
                [self addSubview:_coachCardButton];
                [self addSubview:_schoolCardButton];
            

            }
                break;
                case KSubjectFourView:
            {
                // 科目四
                // 首页视图
                _textImageView = [[UIImageView alloc] initWithFrame:CGRectMake((systemsW - imageViewW) / 2, imageY, imageViewW, imageViewH)];
                _textImageView.image = [UIImage imageNamed:@"文字"];
                
                CGFloat signX = (systemsW - signButton - schoolCardButton - 10) / 2;
                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _signButton.frame = CGRectMake(signX, 250, signButton, signButton);
                [self addButtonProperty:@"报名" button:_signButton];
                [_signButton setBackgroundImage:[UIImage imageNamed:@"错题4"] forState:UIControlStateNormal];
                _signButton.tag = 103;
                [_signButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];

                _coachCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _coachCardButton.frame = CGRectMake(_signButton.frame.origin.x + 10 + signButton, _signButton.frame.origin.y - 30, schoolCardButton, schoolCardButton);
                [self addButtonProperty:@"科目四" button:_coachCardButton];
                [_coachCardButton setBackgroundImage:[UIImage imageNamed:@"科目4"] forState:UIControlStateNormal];                _coachCardButton.tag = 101;
                [_coachCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                _schoolCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _schoolCardButton.frame = CGRectMake(_coachCardButton.frame.origin.x - 50, _coachCardButton.frame.origin.y - 120, coachCardButtonW, coachCardButtonW);
                [self addButtonProperty:@"视频" button:_schoolCardButton];
                [_schoolCardButton setBackgroundImage:[UIImage imageNamed:@"课件4"] forState:UIControlStateNormal];                _schoolCardButton.tag = 102;
                [_schoolCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                [self addSubview:_signButton];
                [self addSubview:_textImageView];
                [self addSubview:_coachCardButton];
                [self addSubview:_schoolCardButton];
               
            }
                break;
                
            default:
                break;
        }
    }
    return self;
}
#pragma mark --- action 
- (void)dikClick:(UIButton *)btn
{
    if (_didClickBlock) {
        _didClickBlock(btn.tag);
    }
}

#pragma mark --- 设置button的共同属性
- (void)addButtonProperty:(NSString *)titleStr button:(UIButton *)btn
{
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius  =  btn.frame.size.height / 2;
//    [btn setTitle:titleStr forState:UIControlStateNormal];
}

#pragma mark --- lazy 加载
@end
