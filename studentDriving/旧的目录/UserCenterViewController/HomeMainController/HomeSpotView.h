//
//  HomeSpotView.h
//  TestCar
//
//  Created by ytzhang on 15/12/13.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^offsetViewBlock)(CGFloat carFloat);

@protocol HomeSpotViewDelegate <NSObject>
- (void)horizontalMenuScrollPageIndex:(CGFloat)offSet;
@end

@interface HomeSpotView : UIView

@property (nonatomic,strong) offsetViewBlock offsetBlock;
@property (nonatomic,strong) UIImageView *carView;
@property (weak, nonatomic) id<HomeSpotViewDelegate>delegate;


- (void)menuScrollWithIndex:(NSUInteger)index;

- (void)changLableColor:(CGFloat)offset; // 改变UIlabel的字体颜色
@end
