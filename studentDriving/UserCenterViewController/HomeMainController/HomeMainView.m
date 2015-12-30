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
    
//    CGFloat coachCardButtonW = 96;
//    CGFloat schoolCardButton = 128;
//    CGFloat signButton = 68;
    
    
    CGFloat schoolCardButtonH = systemsW * 0.48;
    CGFloat schoolCardButtonW = systemsW * 0.4;
    CGFloat coachCardButtonW = systemsW * 0.3;
    CGFloat signButton = systemsW * 0.3;
    
    if (self = [super initWithFrame:frame]) {
        /*
         *coachCard  ,driverSchoolCard  ,
         */
        _kSearchType = searchType;
        switch (searchType) {
            case kSearchMainView:
            {
                // 首页视图
                _coachCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _coachCardButton.frame = CGRectMake(35, 195, coachCardButtonW, coachCardButtonW);
                [self addButtonProperty:@"教练卡" button:_coachCardButton];
                [_coachCardButton setBackgroundImage:[UIImage imageNamed:@"优势"] forState:UIControlStateNormal];
                _coachCardButton.tag = 101;
                [_coachCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];

                
                _schoolCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _schoolCardButton.frame = CGRectMake(systemsW - schoolCardButtonW - 76, systemsH - 112 - 64 - schoolCardButtonH , schoolCardButtonW, schoolCardButtonH);
//                _schoolCardButton.frame = CGRectMake(_coachCardButton.frame.origin.x + 84, _coachCardButton.frame.origin.y + 98, schoolCardButtonW, schoolCardButtonH);
                [_schoolCardButton setBackgroundImage:[UIImage imageNamed:@"特惠班"] forState:UIControlStateNormal];
                [_schoolCardButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                _schoolCardButton.tag = 102;
                [_schoolCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
             
                
                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _signButton.frame = CGRectMake(systemsW - signButton - 36,120, signButton, signButton);
                [self addButtonProperty:@"报名" button:_signButton];
                [_signButton setBackgroundImage:[UIImage imageNamed:@"合作"] forState:UIControlStateNormal];
                _signButton.tag = 103;
               [_signButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
               
                [self addSubview:_textImageView];
                [self addSubview:_coachCardButton];
                [self addSubview:_schoolCardButton];
                [self addSubview:_signButton];
                

            }
                break;
            case KSubjectOneView:
                
            {
                // 科目一
                // 首页视图

                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _signButton.frame = CGRectMake(38, systemsH - schoolCardButtonH - 185 - 64, schoolCardButtonW, schoolCardButtonH);
                [_signButton setBackgroundImage:[UIImage imageNamed:@"题库1"] forState:UIControlStateNormal];
                _signButton.tag = 103;
                [_signButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];

                
                _coachCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _coachCardButton.frame = CGRectMake(systemsW - 52 - coachCardButtonW, 121 , coachCardButtonW, coachCardButtonW);
                [self addButtonProperty:@"科目一" button:_coachCardButton];
                [_coachCardButton setBackgroundImage:[UIImage imageNamed:@"模考"] forState:UIControlStateNormal];
                _coachCardButton.tag = 101;
                [_coachCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
               
                
                _schoolCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _schoolCardButton.frame = CGRectMake(systemsW - 75 - signButton, systemsH - 114 - signButton - 64, signButton, signButton);
                [_schoolCardButton setBackgroundImage:[UIImage imageNamed:@"错题"] forState:UIControlStateNormal];
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
                
                _coachCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _coachCardButton.frame = CGRectMake(18, systemsH - schoolCardButtonH - 191, schoolCardButtonW, schoolCardButtonH);
                [self addButtonProperty:@"科目二" button:_coachCardButton];
                [_coachCardButton setBackgroundImage:[UIImage imageNamed:@"科二预约"] forState:UIControlStateNormal];                _coachCardButton.tag = 102;
                [_coachCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _signButton.frame = CGRectMake(systemsW - 95 - coachCardButtonW, 100,coachCardButtonW, coachCardButtonW);
                [self addButtonProperty:@"报名" button:_signButton];
                [_signButton setBackgroundImage:[UIImage imageNamed:@"科二预约列表"] forState:UIControlStateNormal];                _signButton.tag = 103;
                [_signButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];

                _schoolCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _schoolCardButton.frame = CGRectMake(systemsW - signButton - 47,systemsH - 265, signButton, signButton);
                [self addButtonProperty:@"视频" button:_schoolCardButton];
                [_schoolCardButton setBackgroundImage:[UIImage imageNamed:@"课件"] forState:UIControlStateNormal];                _schoolCardButton.tag = 101;
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
                _textImageView = [[UIImageView alloc] initWithFrame:CGRectMake((systemsW - imageViewW) / 2, imageY, imageViewW, imageViewH)];
                _textImageView.image = [UIImage imageNamed:@"文字"];
                
                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                CGFloat signButtonX = (systemsW - schoolCardButtonW - coachCardButtonW - 10) / 2;
                _signButton.frame = CGRectMake(signButtonX, systemsW * 0.4
                                               , schoolCardButtonW, schoolCardButtonW);
                [self addButtonProperty:@"报名" button:_signButton];
                [_signButton setBackgroundImage:[UIImage imageNamed:@"科二预约列表"] forState:UIControlStateNormal];
                _signButton.tag = 103;
                [_signButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];

                
                _coachCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _coachCardButton.frame = CGRectMake(_signButton.frame.origin.x + schoolCardButtonW + 10, _signButton.frame.origin.y - 30, coachCardButtonW, coachCardButtonW);
                [self addButtonProperty:@"科目三" button:_coachCardButton];
                [_coachCardButton setBackgroundImage:[UIImage imageNamed:@"课件"] forState:UIControlStateNormal];
                _coachCardButton.tag = 101;
                [_coachCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                _schoolCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _schoolCardButton.frame = CGRectMake(_signButton.frame.origin.x + schoolCardButtonW + 10, _signButton.frame.origin.y + schoolCardButtonW - 30, signButton, signButton);
                [self addButtonProperty:@"视频" button:_schoolCardButton];
                 [_schoolCardButton setBackgroundImage:[UIImage imageNamed:@"科二预约"] forState:UIControlStateNormal];
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
                
                CGFloat signX = (systemsW - signButton - schoolCardButtonW - 10) / 2;
                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _signButton.frame = CGRectMake(signX, systemsH * 0.4, signButton, signButton);
                [self addButtonProperty:@"报名" button:_signButton];
                [_signButton setBackgroundImage:[UIImage imageNamed:@"错题"] forState:UIControlStateNormal];
                _signButton.tag = 103;
                [_signButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];

                _coachCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _coachCardButton.frame = CGRectMake(_signButton.frame.origin.x + 10 + signButton, _signButton.frame.origin.y - 30, schoolCardButtonW, schoolCardButtonH);
                [self addButtonProperty:@"科目四" button:_coachCardButton];
                [_coachCardButton setBackgroundImage:[UIImage imageNamed:@"模考"] forState:UIControlStateNormal];                _coachCardButton.tag = 101;
                [_coachCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                _schoolCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _schoolCardButton.frame = CGRectMake(_coachCardButton.frame.origin.x - 50, _coachCardButton.frame.origin.y - 120, coachCardButtonW, coachCardButtonW);
                [self addButtonProperty:@"视频" button:_schoolCardButton];
                [_schoolCardButton setBackgroundImage:[UIImage imageNamed:@"题库1"] forState:UIControlStateNormal];                _schoolCardButton.tag = 102;
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
//    btn.layer.masksToBounds = YES;
//    btn.layer.cornerRadius  =  btn.frame.size.height / 2;
//    [btn setTitle:titleStr forState:UIControlStateNormal];
}

#pragma mark --- lazy 加载
@end
