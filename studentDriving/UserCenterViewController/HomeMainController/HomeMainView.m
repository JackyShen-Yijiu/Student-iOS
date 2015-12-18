//
//  HomeMainView.m
//  TestCar
//
//  Created by ytzhang on 15/12/14.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "HomeMainView.h"

@interface HomeMainView ()
@property (nonatomic, strong) UIButton *coachCardButton;

@property (nonatomic, strong) UIButton *schoolCardButton;

@property (nonatomic, strong) UIButton *signButton;

@end

@implementation HomeMainView


- (instancetype)initWithFrame:(CGRect)frame SearchType:(kSearchType)searchType
{
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
                _coachCardButton.frame = CGRectMake(20, 100, 121, 121);
                [self addButtonProperty:@"教练卡" button:_coachCardButton];
                [_coachCardButton setBackgroundImage:[UIImage imageNamed:@"驾校优势"] forState:UIControlStateNormal];
                _coachCardButton.tag = 101;
                [_coachCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];

                
                _schoolCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _schoolCardButton.frame = CGRectMake(_coachCardButton.frame.origin.x + 116, 50, 160, 160);
                [_schoolCardButton setBackgroundImage:[UIImage imageNamed:@"驾校优惠"] forState:UIControlStateNormal];
                [_schoolCardButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                _schoolCardButton.tag = 102;
                [_schoolCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
             
                
                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _signButton.frame = CGRectMake(_coachCardButton.frame.origin.x, 250, 85, 85);
                [self addButtonProperty:@"报名" button:_signButton];
                [_signButton setBackgroundImage:[UIImage imageNamed:@"承诺"] forState:UIControlStateNormal];
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
                _coachCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _coachCardButton.frame = CGRectMake(0, 100, 100, 100);
                [self addButtonProperty:@"科目一" button:_coachCardButton];
                [_coachCardButton setBackgroundImage:[UIImage imageNamed:@"模考1"] forState:UIControlStateNormal];
                _coachCardButton.tag = 101;
                [_coachCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
               
                
                _schoolCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _schoolCardButton.frame = CGRectMake(200, 50, 100, 100);
                [self addButtonProperty:@"题库1" button:_schoolCardButton];
                [_schoolCardButton setBackgroundImage:[UIImage imageNamed:@"错题1"] forState:UIControlStateNormal];
                _schoolCardButton.tag = 102;
                [_schoolCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _signButton.frame = CGRectMake(150, 250, 100, 100);
                [self addButtonProperty:@"报名" button:_signButton];
                [_signButton setBackgroundImage:[UIImage imageNamed:@"题库1"] forState:UIControlStateNormal];
                _signButton.tag = 103;
                [_signButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                [self addSubview:_coachCardButton];
                [self addSubview:_schoolCardButton];
                [self addSubview:_signButton];

                
            }
                break;
            case KSubjectTwoView:
            {
                // 科目二
                _coachCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _coachCardButton.frame = CGRectMake(0, 100, 100, 100);
                [self addButtonProperty:@"科目二" button:_coachCardButton];
                [_coachCardButton setBackgroundImage:[UIImage imageNamed:@"课件2"] forState:UIControlStateNormal];                _coachCardButton.tag = 101;
                [_coachCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                _schoolCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _schoolCardButton.frame = CGRectMake(200, 50, 100, 100);
                [self addButtonProperty:@"视频" button:_schoolCardButton];
                [_schoolCardButton setBackgroundImage:[UIImage imageNamed:@"预约2"] forState:UIControlStateNormal];                _schoolCardButton.tag = 102;
                [_schoolCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _signButton.frame = CGRectMake(150, 250, 100, 100);
                [self addButtonProperty:@"报名" button:_signButton];
                [_signButton setBackgroundImage:[UIImage imageNamed:@"预约列表2"] forState:UIControlStateNormal];                _signButton.tag = 103;
                [_signButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                [self addSubview:_coachCardButton];
                [self addSubview:_schoolCardButton];
                [self addSubview:_signButton];

            }
                break;
            case KSubjectThreeView:
            {
                // 科目三
                _coachCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _coachCardButton.frame = CGRectMake(0, 100, 100, 100);
                [self addButtonProperty:@"科目三" button:_coachCardButton];
                [_coachCardButton setBackgroundImage:[UIImage imageNamed:@"课件3"] forState:UIControlStateNormal];
                _coachCardButton.tag = 101;
                [_coachCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                _schoolCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _schoolCardButton.frame = CGRectMake(200, 50, 100, 100);
                [self addButtonProperty:@"视频" button:_schoolCardButton];
                 [_schoolCardButton setBackgroundImage:[UIImage imageNamed:@"预约3"] forState:UIControlStateNormal];
                _schoolCardButton.tag = 102;
                [_schoolCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _signButton.frame = CGRectMake(150, 250, 100, 100);
                [self addButtonProperty:@"报名" button:_signButton];
                [_signButton setBackgroundImage:[UIImage imageNamed:@"预约列表3"] forState:UIControlStateNormal];
                _signButton.tag = 103;
                [_signButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                [self addSubview:_coachCardButton];
                [self addSubview:_schoolCardButton];
                [self addSubview:_signButton];

            }
                break;
                case KSubjectFourView:
            {
                // 科目四
                _coachCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _coachCardButton.frame = CGRectMake(0, 100, 100, 100);
                [self addButtonProperty:@"科目四" button:_coachCardButton];
                [_coachCardButton setBackgroundImage:[UIImage imageNamed:@"科目4"] forState:UIControlStateNormal];                _coachCardButton.tag = 101;
                [_coachCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                _schoolCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _schoolCardButton.frame = CGRectMake(200, 50, 100, 100);
                [self addButtonProperty:@"视频" button:_schoolCardButton];
                [_schoolCardButton setBackgroundImage:[UIImage imageNamed:@"课件4"] forState:UIControlStateNormal];                _schoolCardButton.tag = 102;
                [_schoolCardButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
                _signButton.frame = CGRectMake(150, 250, 100, 100);
                [self addButtonProperty:@"报名" button:_signButton];
                [_signButton setBackgroundImage:[UIImage imageNamed:@"错题4"] forState:UIControlStateNormal];
                _signButton.tag = 103;
                [_signButton addTarget:self action:@selector(dikClick:) forControlEvents:UIControlEventTouchUpInside];
                
                [self addSubview:_coachCardButton];
                [self addSubview:_schoolCardButton];
                [self addSubview:_signButton];

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
