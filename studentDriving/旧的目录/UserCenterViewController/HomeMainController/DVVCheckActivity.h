//
//  DVVCheckActivity.h
//  studentDriving
//
//  Created by 大威 on 16/1/7.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVVCheckActivity : NSObject

/**
 *  检查今天是否需要显示活动
 *
 *  @return YES: 需要显示    NO: 不需要
 */
+ (BOOL)checkActivity;

/**
 *  测试时先调用此方法
 */
+ (void)test;

@end
