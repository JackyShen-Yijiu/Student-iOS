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
    
    
    CGFloat schoolCardButtonH = systemsW * 0.48;
    CGFloat schoolCardButtonW = systemsW * 0.4;
    CGFloat coachCardButtonW = systemsW * 0.3;
    CGFloat signButton = systemsW * 0.3;
    
    if (self = [super initWithFrame:frame]) {
       
        _kSearchType = searchType;
        switch (searchType) {
            case kSearchMainView:
            {
                // 首页视图
                // 创建telescopeView
//                UIView
                
                _coachCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _coachCardButton.frame = CGRectMake(35, 195, coachCardButtonW, coachCardButtonW);
                [_coachCardButton setBackgroundImage:[UIImage imageNamed:@"优势"] forState:UIControlStateNormal];
                _coachCardButton.tag = 101;
                [_coachCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];

                
                _schoolCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _schoolCardButton.frame = CGRectMake(systemsW - schoolCardButtonW - 76, systemsH - 112 - 64 - schoolCardButtonH , schoolCardButtonW, schoolCardButtonH);
                [_schoolCardButton setBackgroundImage:[UIImage imageNamed:@"特惠班"] forState:UIControlStateNormal];
                [_schoolCardButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                _schoolCardButton.tag = 102;
                [_schoolCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
             
                
                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _signButton.frame = CGRectMake(systemsW - signButton - 36,120, signButton, signButton);

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
                [_coachCardButton setBackgroundImage:[UIImage imageNamed:@"模考"] forState:UIControlStateNormal];
                _coachCardButton.tag = 101;
                [_coachCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
               
                
                _schoolCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _schoolCardButton.frame = CGRectMake(systemsW - 75 - signButton, systemsH - 114 - signButton - 64, signButton, signButton);
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
                
                _coachCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _coachCardButton.frame = CGRectMake(18, systemsH / 2 - schoolCardButtonH, schoolCardButtonW, schoolCardButtonH);
                [_coachCardButton setBackgroundImage:[UIImage imageNamed:@"科二预约"] forState:UIControlStateNormal];                _coachCardButton.tag = 102;
                [_coachCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _signButton.frame = CGRectMake(0, 0,coachCardButtonW, coachCardButtonW);
                _signButton.center = CGPointMake(_coachCardButton.center.x + schoolCardButtonW, _coachCardButton.center.y + schoolCardButtonW);
                [_signButton setBackgroundImage:[UIImage imageNamed:@"科二预约列表"] forState:UIControlStateNormal];
                _signButton.tag = 103;
                [_signButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];

                _schoolCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _schoolCardButton.frame = CGRectMake(0,0, signButton, signButton);
                _schoolCardButton.center = CGPointMake(_coachCardButton.center.x + schoolCardButtonH, _coachCardButton.center.y - signButton / 2);
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
                
                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _signButton.frame = CGRectMake(systemsW - 51 -schoolCardButtonW, systemsH / 2 - schoolCardButtonH / 2
                                               , schoolCardButtonW, schoolCardButtonH);
            
                [_signButton setBackgroundImage:[UIImage imageNamed:@"科三预约列表"] forState:UIControlStateNormal];
                _signButton.tag = 103;
                [_signButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];

                
                _coachCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _coachCardButton.frame = CGRectMake(0,0, coachCardButtonW, coachCardButtonW);
                _coachCardButton.center = CGPointMake(_signButton.center.x - signButton + 20, _signButton.center.y - schoolCardButtonW );
                [_coachCardButton setBackgroundImage:[UIImage imageNamed:@"课件"] forState:UIControlStateNormal];
                _coachCardButton.tag = 101;
                [_coachCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                _schoolCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _schoolCardButton.frame = CGRectMake(0, 0, signButton, signButton);
                _schoolCardButton.center = CGPointMake(_signButton.center.x - schoolCardButtonW, _signButton.center.y - 10);
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
                
                _schoolCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _schoolCardButton.frame = CGRectMake(systemsW - 67 - schoolCardButtonW, systemsH / 2 - schoolCardButtonH - 50, schoolCardButtonW, schoolCardButtonH);
                [_schoolCardButton setBackgroundImage:[UIImage imageNamed:@"题库1"] forState:UIControlStateNormal];                _schoolCardButton.tag = 102;
                [_schoolCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];

                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _signButton.frame = CGRectMake(0, 0, signButton, signButton);
                _signButton.center = CGPointMake(_schoolCardButton.center.x + signButton - 30, _schoolCardButton.center.y + schoolCardButtonW);
                [_signButton setBackgroundImage:[UIImage imageNamed:@"错题"] forState:UIControlStateNormal];
                _signButton.tag = 103;
                [_signButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];

                _coachCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _coachCardButton.frame = CGRectMake(0, 0, coachCardButtonW, coachCardButtonW);
                _coachCardButton.center = CGPointMake(_schoolCardButton.center.x - signButton, _schoolCardButton.center.y + signButton);
                [_coachCardButton setBackgroundImage:[UIImage imageNamed:@"模考"] forState:UIControlStateNormal];
                _coachCardButton.tag = 101;
                [_coachCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                CGFloat telescopeH = 72;
                CGFloat telescopeW = 44;
                // 加载telescopeView
                UIImageView *telescopeView = [[UIImageView alloc] initWithFrame:CGRectMake(systemsW - 50, systemsH - 230, telescopeW, telescopeH)];
                telescopeView.image = [UIImage imageNamed:@"望远镜"];
                [self addSubview:telescopeView];
                
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
