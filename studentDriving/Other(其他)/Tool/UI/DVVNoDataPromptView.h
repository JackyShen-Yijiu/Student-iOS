//
//  DVVNoDataPromptView.h
//  studentDriving
//
//  Created by 大威 on 16/2/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVVNoDataPromptView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

/**
 *  初始化
 *
 *  @param title      标题内容
 *  @param image      显示的图片
 *
 *  @return instancetype
 */
- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image;

/**
 *  初始化
 *
 *  @param title    标题内容
 *  @param image    显示的图片
 *  @param subTitle 副标题
 *
 *  @return instancetype
 */
- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                     subTitle:(NSString *)subTitle;

/**
 *  从父视图移除（有渐隐动画效果）
 */
- (void)remove;


@end
