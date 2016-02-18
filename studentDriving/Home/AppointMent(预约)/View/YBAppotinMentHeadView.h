//
//  YBAppotinMentHeadView.h
//  studentDriving
//
//  Created by JiangangYang on 16/2/18.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMCourseModel.h"

@interface YBAppotinMentHeadView : UIView

@property(nonatomic,strong)HMCourseModel * model;

+ (CGFloat)height;

@end
