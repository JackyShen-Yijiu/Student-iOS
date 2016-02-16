//
//  DVVSignUpToolBarView.h
//  studentDriving
//
//  Created by 大威 on 16/2/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVVSignUpToolBarView : UIView

//预定义一个Block类型
typedef void(^DVVSignUpToolBarViewBlock)(UIButton *button);

//当前选中的按钮（默认为 0 ）
@property(nonatomic,assign) NSInteger selectButtonInteger;

//按钮正常情况下的颜色
@property(nonatomic,strong) UIColor *buttonNormalColor;
//按钮选中时的颜色
@property(nonatomic,strong) UIColor *buttonSelectColor;

//存放全部标题的数组
@property(nonatomic,strong) NSArray *titleArray;
//标题字体大小
@property(nonatomic,strong) UIFont *titleFont;
//标题正常情况下的颜色
@property(nonatomic,strong) UIColor *titleNormalColor;
//标题选中时的颜色
@property(nonatomic,strong) UIColor *titleSelectColor;

//跟随条的位置（0：下方；1：上方）
@property(nonatomic,assign) BOOL followBarLocation;
//跟随条的颜色
@property(nonatomic,strong) UIColor *followBarColor;
//跟随条的高度
@property(nonatomic,assign) CGFloat followBarHeight;

@property(nonatomic,assign) CGFloat minWidth;

//模拟点击一项的方法(参数为一个Block)
- (void)dvvToolBarViewItemSelected:(DVVSignUpToolBarViewBlock)handle;

- (void)selectItem:(NSUInteger)tag;

@end
