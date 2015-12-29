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


@end

@implementation HomeMainView


- (instancetype)initWithFrame:(CGRect)frame SearchType:(kSearchType)searchType
{

    CGFloat coachCardButtonW = systemsW * 0.3;
    CGFloat schoolCardButton = systemsW * 0.4;
    CGFloat signButton = systemsW * 0.2;
    NSLog(@"%f",coachCardButtonW);
    if (self = [super initWithFrame:frame]) {
        /*
         *coachCard  ,driverSchoolCard  ,
         */
        _kSearchType = searchType;
        switch (searchType) {
            case kSearchMainView:
            {
                // 首页视图
                
                CGFloat coachCardButtonX = (systemsW - coachCardButtonW - schoolCardButton + 23) / 2 ;
                NSLog(@"coach = %f",coachCardButtonX);
                _coachCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _coachCardButton.frame = CGRectMake(coachCardButtonX, systemsH * 0.2, coachCardButtonW, coachCardButtonW);
                [self addButtonProperty:@"教练卡" button:_coachCardButton];
                [_coachCardButton setBackgroundImage:[UIImage imageNamed:@"驾校优势"] forState:UIControlStateNormal];
                _coachCardButton.tag = 101;
                [_coachCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];

                
                _schoolCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _schoolCardButton.frame = CGRectMake(_coachCardButton.frame.origin.x + 84, _coachCardButton.frame.origin.y + 98, schoolCardButton, schoolCardButton);
                [_schoolCardButton setBackgroundImage:[UIImage imageNamed:@"驾校优惠"] forState:UIControlStateNormal];
                [_schoolCardButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                _schoolCardButton.tag = 102;
                [_schoolCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
             
                
                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _signButton.frame = CGRectMake(_coachCardButton.frame.origin.x + 4, _coachCardButton.frame.origin.y + schoolCardButton + 20, signButton, signButton);
                [self addButtonProperty:@"报名" button:_signButton];
                [_signButton setBackgroundImage:[UIImage imageNamed:@"流程"] forState:UIControlStateNormal];
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
                
                CGFloat signButtonX = (systemsW - schoolCardButton - coachCardButtonW + 15) / 2 ;

                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _signButton.frame = CGRectMake(signButtonX, systemsH * 0.3, schoolCardButton, schoolCardButton);
                [self addButtonProperty:@"报名" button:_signButton];
                [_signButton setBackgroundImage:[UIImage imageNamed:@"题库1"] forState:UIControlStateNormal];
                _signButton.tag = 103;
                [_signButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];

                
                _coachCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _coachCardButton.frame = CGRectMake(_signButton.frame.origin.x + schoolCardButton - 15, _signButton.frame.origin.y + 88, coachCardButtonW, coachCardButtonW);
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
                [self addSubview:_coachCardButton];
                [self addSubview:_schoolCardButton];
                

                
            }
                break;
            case KSubjectTwoView:
            {
                // 科目二
                // 首页视图
        
                _coachCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                 CGFloat signButtonX = (systemsW - schoolCardButton - coachCardButtonW + 60) / 2 ;
                _coachCardButton.frame = CGRectMake(signButtonX, systemsH * 0.2, schoolCardButton, schoolCardButton);
                [self addButtonProperty:@"科目二" button:_coachCardButton];
                [_coachCardButton setBackgroundImage:[UIImage imageNamed:@"二预约"] forState:UIControlStateNormal];                _coachCardButton.tag = 102;
                [_coachCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _signButton.frame = CGRectMake(_coachCardButton.frame.origin.x + schoolCardButton - 50, _coachCardButton.frame.origin.y  + schoolCardButton - 16,coachCardButtonW, coachCardButtonW);
                [self addButtonProperty:@"报名" button:_signButton];
                [_signButton setBackgroundImage:[UIImage imageNamed:@"预约列表2"] forState:UIControlStateNormal];                _signButton.tag = 103;
                [_signButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];

                _schoolCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _schoolCardButton.frame = CGRectMake(_signButton.frame.origin.x - signButton - 30, _signButton.frame.origin.y + 50, signButton, signButton);
                [self addButtonProperty:@"视频" button:_schoolCardButton];
                [_schoolCardButton setBackgroundImage:[UIImage imageNamed:@"二课件"] forState:UIControlStateNormal];                _schoolCardButton.tag = 101;
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
                CGFloat signButtonX = (systemsW - schoolCardButton - coachCardButtonW - 10) / 2;
                _signButton.frame = CGRectMake(signButtonX, systemsW * 0.4
                                               , schoolCardButton, schoolCardButton);
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
                [self addSubview:_coachCardButton];
                [self addSubview:_schoolCardButton];
            

            }
                break;
                case KSubjectFourView:
            {
                // 科目四
                // 首页视图
    
                
                CGFloat signX = (systemsW - signButton - schoolCardButton - 10) / 2;
                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _signButton.frame = CGRectMake(signX, systemsH * 0.4, signButton, signButton);
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
