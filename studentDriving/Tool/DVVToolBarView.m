//
//  DVVCycleShowImagesView.m
//  studentDriving
//
//  Created by 大威 on 15/12/14.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "DVVToolBarView.h"
#import "JGItemButton.h"

//文字颜色
#define TITLE_COLOR [UIColor orangeColor]

#define WIDTH self.bounds.size.width
#define HEIGHT self.bounds.size.height

@interface DVVToolBarView()

//执行点击事件的Block
@property(nonatomic,copy) DVVToolBarViewBlock itemBlock;

//跟随条
@property(nonatomic,strong) UILabel *followBarLabel;

@end

@implementation DVVToolBarView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        //调用初始化属性
        [self initialProperty];
    }
    return self;
}

#pragma mark - 初始化属性
- (void)initialProperty {
    
    //当前选中的按钮
    _selectButtonInteger = 0;
    
    //按钮
    _buttonNormalColor = [UIColor clearColor];
    _buttonSelectColor = [UIColor clearColor];
    
    //标题
    _titleArray=[NSArray new];
    _titleArray = @[ @"标题1", @"标题2", @"..." ];
    _titleFont = [UIFont systemFontOfSize:14];
    _titleNormalColor = [UIColor grayColor];
    _titleSelectColor = TITLE_COLOR;
    
    _buttonNormalImg = [UIImage imageNamed:@"selectDringBtnImg.png"];
    _buttonSelectImg = [UIImage imageNamed:@"selectDringBtnSelectImg.png"];
    
    //跟随条
    _followBarColor = TITLE_COLOR;
    _followBarHeight = 2;
    _followBarLocation = 0;
}

#pragma mark - 按钮的点击事件
- (void)btnClickAction:(UIButton *)sender {
    
    //加此判断，避免重复按一个按钮，重复触发事件
    if(sender.tag != _selectButtonInteger){
        
        for (UIButton *button in sender.superview.subviews) {
            
            //使跟随条跟随
            if (button.tag==12345) {
                //获取frame
                CGRect rect=button.frame;
                //现在要移动到的minX坐标
                CGFloat  newMinX=(sender.tag)*rect.size.width;
                
                rect.origin.x=newMinX;
                //动画
                [UIButton animateWithDuration:0.3 animations:^{
                    button.frame=rect;
                }];
            }else{
                if (button.tag == _selectButtonInteger) {
                    
                    //上次按下的背景色为正常情况下的颜色
                    button.backgroundColor = _buttonNormalColor;
                    //上次按下的字体色为正常情况下的颜色
                    [button setTitleColor:_titleNormalColor forState:UIControlStateNormal];
                    [button setImage:_buttonNormalImg forState:UIControlStateNormal];
                }
            }
        }
        //选中此按钮
        [self selectOneButton:sender.tag];
        
        //如果Block不为空时才调用，执行在其他类中的实现的内容
        if (_itemBlock) {
            
            _itemBlock(sender);
        }
    }
}

#pragma mark - 选中一个按钮
- (void)selectOneButton:(NSInteger)tag {
    
    for (UIButton *button in self.subviews) {
        
        if (button.tag == tag) {
            //改变背景色和字体颜色为选中时的颜色
            button.backgroundColor=_buttonSelectColor;
            [button setTitleColor:_titleSelectColor forState:UIControlStateNormal];
            [button setImage:_buttonSelectImg forState:UIControlStateNormal];

        }
    }
    //更改当前选中的按钮tag值
    _selectButtonInteger=tag;
}
#pragma mark - 实现在 .h中声明的，模拟点击一项的方法（参数为一个Block）
/**
 *  param handle 用户实现的Block
 */
- (void)dvvToolBarViewItemSelected:(DVVToolBarViewBlock)handle {
    
    //指向用户实现的Block
    _itemBlock = handle;
}

#pragma mark - 创建导航栏中的所有按钮
- (void)layoutSubviews {
    
    //设置导航栏中的按钮大小
    CGSize buttonSize = CGSizeMake(WIDTH/_titleArray.count, HEIGHT);
    
    //循环创建所有的按钮
    for (int i = 0; i < _titleArray.count; i++) {
        
        JGItemButton *itemButton = [self createOneButtonWithTitle:_titleArray[i] Size:buttonSize MinX:i*buttonSize.width Tag:i];
        
        [self addSubview:itemButton];
    }
    _followBarLabel = [UILabel new];
    //添加跟随的按钮
    CGFloat locationFloat = _selectButtonInteger * buttonSize.width;
    if (_followBarLocation) {
        _followBarLabel.frame = CGRectMake(locationFloat, 0, buttonSize.width, _followBarHeight);
    }else{
        _followBarLabel.frame = CGRectMake(locationFloat, buttonSize.height-_followBarHeight, buttonSize.width, _followBarHeight);
    }
    //颜色
    _followBarLabel.backgroundColor = _followBarColor;
    
    //将跟随条的tag值设为12345，避免和按钮的tag值起冲突
    _followBarLabel.tag = 12345;
    
    [self addSubview:_followBarLabel];
    
    //默认选中第一个按钮
    [self selectOneButton:_selectButtonInteger];
}

#pragma mark 创建一个按钮
- (JGItemButton *)createOneButtonWithTitle:(NSString *)title Size:(CGSize)size MinX:(CGFloat)mimX Tag:(NSInteger)tag {
    
    JGItemButton *btn = [JGItemButton new];
    //位置和大小
    btn.frame = CGRectMake(mimX, 0, size.width, size.height);
    //字体
    btn.titleLabel.font = _titleFont;
    //显示文字
    [btn setTitle:title forState:UIControlStateNormal];
    //显示文字颜色
    [btn setTitleColor:_titleNormalColor forState:UIControlStateNormal];
    // 显示箭头
    [btn setImage:_buttonNormalImg forState:UIControlStateNormal];
    //tag值
    btn.tag=tag;
    //点击事件
    [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchDown];
    
    return btn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
