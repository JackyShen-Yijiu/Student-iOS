//
//  YBStudeyProgressView.h
//  studentDriving
//
//  Created by JiangangYang on 16/2/17.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KOAProgressBar;

@interface YBStudeyProgressView : UIView

@property (nonatomic,weak) KOAProgressBar *progressSliderView;
@property (nonatomic,weak) UILabel *topLabel;

@end
