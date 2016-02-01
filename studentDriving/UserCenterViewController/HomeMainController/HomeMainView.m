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
    
    
    CGFloat schoolCardButtonH = systemsW * 0.47;
    CGFloat schoolCardButtonW = systemsW * 0.37;
    CGFloat coachCardButtonW = systemsW * 0.28;
    CGFloat signButton = systemsW * 0.25;
    
    if (self = [super initWithFrame:frame]) {
       
        _kSearchType = searchType;
        switch (searchType) {
            case kSearchMainView:
            {
                // 首页视图
                // 创建telescopeView
//                UIView
                
                
                CGFloat coachCardX = systemsW * 0.103;
                CGFloat coachCardY = systemsH * 0.473;
                _coachCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _coachCardButton.frame = CGRectMake(coachCardX, coachCardY - 64, coachCardButtonW, coachCardButtonW);
                [_coachCardButton setBackgroundImage:[UIImage imageNamed:@"须知"] forState:UIControlStateNormal];
                _coachCardButton.tag = 101;
                [_coachCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];

                CGFloat schoolCardX = systemsW * 0.6625;
                CGFloat schoolCardY = systemsH * 0.378;
                _schoolCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _schoolCardButton.frame = CGRectMake(schoolCardX, schoolCardY - 64 , signButton, signButton);
                [_schoolCardButton setBackgroundImage:[UIImage imageNamed:@"活动"] forState:UIControlStateNormal];
                [_schoolCardButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                _schoolCardButton.tag = 102;
                [_schoolCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
             
                CGFloat signX = systemsW * 0.415;
                CGFloat signY = systemsH * 0.543;
                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _signButton.frame = CGRectMake(signX,signY - 64, schoolCardButtonW, schoolCardButtonH);
                [_signButton setBackgroundImage:[UIImage imageNamed:@"找驾校"] forState:UIControlStateNormal];
                _signButton.tag = 103;
               [_signButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                [self addSubview:_coachCardButton];
                [self addSubview:_schoolCardButton];
                [self addSubview:_signButton];
                

            }
                break;
            case KSubjectOneView:
                
            {
                // 科目一
                // 首页视图
                CGFloat signX = systemsW * 0.478;
                CGFloat signY = systemsH * 0.528;
                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _signButton.frame = CGRectMake(signX, signY - 64, schoolCardButtonW, schoolCardButtonH);
                [_signButton setBackgroundImage:[UIImage imageNamed:@"题库"] forState:UIControlStateNormal];
                _signButton.tag = 103;
                [_signButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];

                CGFloat coachCardX = systemsW * 0.131;
                CGFloat coachCardY = systemsH * 0.484;
                _coachCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _coachCardButton.frame = CGRectMake(coachCardX, coachCardY - 64 , coachCardButtonW, coachCardButtonW);
                [_coachCardButton setBackgroundImage:[UIImage imageNamed:@"模考"] forState:UIControlStateNormal];
                _coachCardButton.tag = 101;
                [_coachCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
               
                CGFloat schoolCardX = systemsW * 0.644;
                CGFloat schoolCardY = systemsH * 0.343;
                _schoolCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _schoolCardButton.frame = CGRectMake(schoolCardX, schoolCardY - 64, signButton, signButton);
                [_schoolCardButton setBackgroundImage:[UIImage imageNamed:@"错题"] forState:UIControlStateNormal];
                _schoolCardButton.tag = 102;
                [_schoolCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                [self addSubview:_signButton];
                [self addSubview:_coachCardButton];
                [self addSubview:_schoolCardButton];
                

                
            }
                break;
            case KSubjectTwoView:
            {
                // 科目二
                // 首页视图
                CGFloat coachCardX = systemsW * 0.0875;
                CGFloat coachCardY = systemsH * 0.335;
                _coachCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _coachCardButton.frame = CGRectMake(coachCardX, coachCardY - 64, schoolCardButtonW, schoolCardButtonH);
                [_coachCardButton setBackgroundImage:[UIImage imageNamed:@"科二预约"] forState:UIControlStateNormal];                _coachCardButton.tag = 102;
                [_coachCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                CGFloat signX = systemsW * 0.475;
                CGFloat signY = systemsH * 0.5898;
                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _signButton.frame = CGRectMake(signX, signY - 64,signButton, signButton);
                [_signButton setBackgroundImage:[UIImage imageNamed:@"科二预约列表"] forState:UIControlStateNormal];
                _signButton.tag = 103;
                [_signButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];

                CGFloat schoolCardX = systemsW * 0.603;
                CGFloat schoolCardY = systemsH * 0.327;
                _schoolCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _schoolCardButton.frame = CGRectMake(schoolCardX,schoolCardY - 64, coachCardButtonW, coachCardButtonW);
                [_schoolCardButton setBackgroundImage:[UIImage imageNamed:@"课件"] forState:UIControlStateNormal];
                _schoolCardButton.tag = 101;
                [_schoolCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
        
                [self addSubview:_coachCardButton];
                [self addSubview:_signButton];
                 [self addSubview:_schoolCardButton];

            }
                break;
            case KSubjectThreeView:
            {
                // 科目三
                // 首页视图
                
                CGFloat signX = systemsW * 0.369;
                CGFloat signY = systemsH * 0.305;
                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _signButton.frame = CGRectMake(signX, signY - 64, schoolCardButtonW, schoolCardButtonH);
                [_signButton setBackgroundImage:[UIImage imageNamed:@"科三预约列表"] forState:UIControlStateNormal];
                _signButton.tag = 103;
                [_signButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];

                CGFloat coachCardX = systemsW * 0.619;
                CGFloat coachCardY = systemsH * 0.607;
                _coachCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _coachCardButton.frame = CGRectMake(coachCardX,coachCardY - 64, coachCardButtonW, coachCardButtonW);
                [_coachCardButton setBackgroundImage:[UIImage imageNamed:@"课件"] forState:UIControlStateNormal];
                _coachCardButton.tag = 101;
                [_coachCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                CGFloat schoolCardX = systemsW * 0.1156;
                CGFloat schoolCardY = systemsH * 0.579;
                _schoolCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _schoolCardButton.frame = CGRectMake(schoolCardX, schoolCardY - 64, signButton, signButton);
                [_schoolCardButton setBackgroundImage:[UIImage imageNamed:@"科三预约"] forState:UIControlStateNormal];
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
                
                CGFloat schoolCardX = systemsW * 0.506;
                CGFloat schoolCardY = systemsH * 0.511;
                _schoolCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _schoolCardButton.frame = CGRectMake(schoolCardX, schoolCardY - 64, schoolCardButtonW, schoolCardButtonH);
                [_schoolCardButton setBackgroundImage:[UIImage imageNamed:@"题库"] forState:UIControlStateNormal];                _schoolCardButton.tag = 102;
                [_schoolCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                CGFloat signX = systemsW * 0.456;
                CGFloat signY = systemsH * 0.343;
                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _signButton.frame = CGRectMake(signX, signY - 64, signButton, signButton);
                [_signButton setBackgroundImage:[UIImage imageNamed:@"错题"] forState:UIControlStateNormal];
                _signButton.tag = 103;
                [_signButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                CGFloat coachCardX = systemsW * 0.1;
                CGFloat coachCardY = systemsH * 0.526;
                _coachCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _coachCardButton.frame = CGRectMake(coachCardX, coachCardY - 64, coachCardButtonW, coachCardButtonW);
                [_coachCardButton setBackgroundImage:[UIImage imageNamed:@"模考"] forState:UIControlStateNormal];
                _coachCardButton.tag = 101;
                [_coachCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                [self addSubview:_schoolCardButton];
                [self addSubview:_signButton];
                [self addSubview:_textImageView];
                [self addSubview:_coachCardButton];
                
               
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


#pragma mark --- lazy 加载
@end
