//
//  DVVBaseTextField.h
//  DVVBaseTextField
//
//  Created by 大威 on 16/3/4.
//  Copyright © 2016年 DaWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVVBaseTextField : UITextField

/** 左边显示的图片 */
@property (nonatomic, strong) UIImage *leftImage;
/** 提示文字 */
@property (nonatomic, strong) NSString *placeHolderString;
/** 边框颜色 */
@property (nonatomic, strong) UIColor *borderColor;

/** 圆角大小 */
@property (nonatomic, assign) CGFloat cornerRadius;

/** 提示语的颜色 */
@property (nonatomic, strong) UIColor *placeHolderColor;
/** 提示语的字体大小 */
@property (nonatomic, strong) UIFont *placeHolderFont;

/** 默认的高度 */
@property (nonatomic, readonly, assign) CGFloat defaultHeight;


- (instancetype)initWithLeftImage:(UIImage *)leftImage
                      placeholder:(NSString *)placeHolder
                      borderColor:(UIColor *)borderColor;

- (instancetype)initWithLeftImage:(UIImage *)leftImage
                      placeholder:(NSString *)placeHolder
                      borderColor:(UIColor *)borderColor
                     cornerRadius:(CGFloat)cornerRadius;

@end
