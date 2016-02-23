//
//  SignInViewModel.h
//  studentDriving
//
//  Created by 大威 on 16/1/8.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+DVVBaseViewModel.h"

@interface SignInViewModel : NSObject

// 所有的课程
@property (nonatomic, strong) NSMutableArray *dataArray;

// 今天需要学习的课程
@property (nonatomic, strong) NSMutableArray *todayArray;

// 二维码的信息字符串
//@property (nonatomic, copy) NSString *qrCodeString;

@end
