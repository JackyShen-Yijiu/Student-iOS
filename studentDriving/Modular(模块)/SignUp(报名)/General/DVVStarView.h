//
//  DVVStarView.h
//  studentDriving
//
//  Created by 大威 on 16/2/17.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVVStarView : UIView

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *foregroundImageView;
@property (nonatomic, strong) UIImage *foregroundImage;
@property (nonatomic, assign) CGSize size;

- (void)dvv_setBackgroundImage:(NSString *)background
               foregroundImage:(NSString *)foreground
                         width:(CGFloat)width
                        height:(CGFloat)height;

- (void)dvv_setStar:(CGFloat)starValue;

@end
