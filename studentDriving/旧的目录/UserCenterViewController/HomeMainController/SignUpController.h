//
//  SignUpController.h
//  studentDriving
//
//  Created by ytzhang on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoachDetail.h"
#import "ClassTypeDMData.h"
#import "serverclasslistModel.h"

@interface SignUpController : UIViewController

// 教练信息
@property (nonatomic, strong) CoachDetail *coachDetailModel;
// 课程信息(价格必传 ID必传 \标题\描述\)
@property (nonatomic,strong) serverclasslistModel *serverclasslistModel;

@property (nonatomic, strong) NSString *classNameStr; // 班级类型
@property (nonatomic, strong) NSString *schoolNameStr; // 报考驾校
@property (nonatomic, strong) NSString *coachNameStr; // 报考教练
@property (nonatomic, assign) SignUpFormDetail signUpFormDetail;
@property (nonatomic, strong) ClassTypeDMData *classTypeDMDataModel;

@end
