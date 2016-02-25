//
//  YBAppointMentDetailsFootView.h
//  studentDriving
//
//  Created by JiangangYang on 16/2/24.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMCourseModel;

typedef void (^BtnDidClickBlock)();

@interface YBAppointMentDetailsFootView : UIView

@property (nonatomic,strong) HMCourseModel  * courseModel;

@property (nonatomic,copy) BtnDidClickBlock didClick;

@end
