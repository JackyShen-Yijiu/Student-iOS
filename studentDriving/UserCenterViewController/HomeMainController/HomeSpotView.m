//
//  HomeSpotView.m
//  TestCar
//
//  Created by ytzhang on 15/12/13.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "HomeSpotView.h"

#import "AcountManager.h"
#import "SignUpListViewController.h"

#define systemsW [[UIScreen mainScreen] bounds].size.width

#define systemsH  [[UIScreen mainScreen] bounds].size.height

#define carOffsetX   ((systemsW - 10) * 0.2)
@interface HomeSpotView ()

@property (nonatomic,strong) NSMutableArray *lableitems; // 保存Label

@property (nonatomic,strong) NSMutableArray *imageArray; // 保存划过的痕迹图像

@end

@implementation HomeSpotView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
            }
    return self;
}

- (void)layoutSubviews{
    [self addView];
    [self addCarView];
}


- (void)menuScrollWithIndex:(NSUInteger)index
{
    
}


// 加载滑动的车
- (void)addCarView
{
    
    
    _carView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 70, 17)];
    _carView.userInteractionEnabled = YES;
    _carView.image = [UIImage imageNamed:@"兰博基尼"];
//    [_carView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"car"]]];
    
    for (int i = 0 ; i < 4 ; i++)
    {
        // 创建手势处理器，指定使用该控制器的handleSwipe:方法处理轻扫手势
        UISwipeGestureRecognizer* gesture = [[UISwipeGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(positionMove:)];
        // 设置该手势处理器只处理i 个手指的轻扫手势
        gesture.numberOfTouchesRequired = 1;
        // 指定该手势处理器只处理1 << i 方向的轻扫手势
        gesture.direction = 1 << i;
        // 为self.view 控件添加手势处理器  
        [_carView addGestureRecognizer:gesture];
    }
    _carView.layer.masksToBounds = YES;
    _carView.layer.cornerRadius  =  20 / 2;
//    self.userInteractionEnabled = YES;
    [self addSubview:_carView];
}

// 手势的执行方法
- (void)positionMove:(UISwipeGestureRecognizer *)sender
{
    
        if (sender.direction == UISwipeGestureRecognizerDirectionRight)
        {
            // 当开始向右滑动时判断是否超出边界
            if (sender.view.frame.origin.x == (systemsW - 10) * 0.9)
            {
                return;
            }
        CGFloat carX = _carView.frame.origin.x + carOffsetX;
            NSLog(@"%f",carOffsetX);
            //  调用代理方法
            if ([_delegate respondsToSelector:@selector(horizontalMenuScrollPageIndex:)]) {
                [_delegate horizontalMenuScrollPageIndex:carX];
            }
            
    }  else if(sender.direction == UISwipeGestureRecognizerDirectionLeft)
    {
         // 当开始向左滑动时判断是否超出边界
        if (sender.view.frame.origin.x == 0)
        {
            return;
        }
    CGFloat carX = _carView.frame.origin.x - carOffsetX;
    //  调用代理方法
        if ([_delegate respondsToSelector:@selector(horizontalMenuScrollPageIndex:)]) {
            [_delegate horizontalMenuScrollPageIndex:carX];
        }

    }
}
// 循环创建spotView和lineView
- (void)addView
{
    // 添加底部黑色视图
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, systemsW, 7)];
    backImageView.backgroundColor = [UIColor redColor];
    backImageView.image = [UIImage imageNamed:@"Loader"];
    
    CGFloat telescopeH = 72;
    CGFloat telescopeW = 44;
    // 加载telescopeView
    UIImageView *telescopeView = [[UIImageView alloc] initWithFrame:CGRectMake(systemsW  - 8, 0, -telescopeW, -telescopeH)];
    telescopeView.image = [UIImage imageNamed:@"望远镜"];
//    telescopeView.backgroundColor = [UIColor redColor];
    [backImageView addSubview:telescopeView];
    
    
    
    
    //添加划过的痕迹图像
    NSArray *imagViewArray = @[@"科目1条",@"科目2条",@"科目3条",@"科目4条"];
//    CGFloat imageViewH = (systemsW - 10) * 0.08;
    CGFloat imageViewH = 5;
//    CGFloat imageViewW = 80;
//    CGFloat imageView = (systemsW - 10) * (91 + 68 * i)/332;
    _imageArray = [NSMutableArray array];
    for (int i = 0;i < imagViewArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0, 0, (systemsW) * (91 + 68 * i)/332, imageViewH);
        imageView.image = [UIImage imageNamed:@"绿色-拷贝"];
        imageView.hidden = YES;
        imageView.tag = i + 301;
        [_imageArray addObject:imageView];
        [backImageView addSubview:imageView];
    }
    [self addSubview:backImageView];
    
    // 添加底部label
    CGFloat spotW = 50;
    CGFloat spotH = 20;
    CGFloat margin = (systemsW - 270) / 5;
    _lableitems = [NSMutableArray array];

    CGFloat labelY = backImageView.frame.origin.y + CGRectGetHeight(backImageView.frame) + 10;
    NSArray *arrayStr =  @[@"欢迎您",@"科目一",@"科目二",@"科目三",@"科目四"];

   
    for (int i = 0; i < 5; i++) {
        UILabel *label = [[UILabel alloc] init];
        if (i == 0) {
            label.frame = CGRectMake(15, labelY, spotW, spotH);
            label.text = arrayStr[i];
            label.tag = 201;

            label.textColor = [UIColor colorWithHexString:@"fcfcfc"];
            label.font = [UIFont systemFontOfSize:14];

            label.textColor = [UIColor orangeColor];
            label.font = [UIFont systemFontOfSize:10];
            [_lableitems addObject:label];
            [self addSubview:label];
        }else
        {
            label.frame = CGRectMake(i * margin + i * spotW + 15, labelY, spotW, spotH);
            label.text = arrayStr[i];

            label.textColor = [UIColor colorWithHexString:@"fcfcfc"];
            label.font = [UIFont systemFontOfSize:12];

            label.textColor = [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:10];
            label.tag = 201 + i;
            [_lableitems addObject:label];
            [self addSubview:label];
            

        }
        
    }
    
}
#pragma mark --- 滑动改变字体颜色和划过的痕迹
- (void)changLableColor:(CGFloat)offset
{
    // 改变字体颜色
    NSInteger i =  (offset - systemsW) / systemsW + 202;
    for (UILabel *resultLabel in _lableitems) {
        if(resultLabel.tag == i)
        {
            resultLabel.textColor = [UIColor colorWithHexString:@"ffff00"];
        }else
        {
            resultLabel.textColor = [UIColor colorWithHexString:@"fcfcfc"];
        }
    }
    // 设置划过的痕迹
    NSInteger j =  (offset - systemsW) / systemsW + 301;
    for (UIImageView *resultImageView in _imageArray) {
        if (resultImageView.tag == j) {
                resultImageView.hidden = NO;
            
        }else{
            
                resultImageView.hidden = YES;
            
        }
    }
    
    
}
@end
