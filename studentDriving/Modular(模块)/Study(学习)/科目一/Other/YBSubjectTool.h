//
//  YBSubjectTool.h
//  studentDriving
//
//  Created by JiangangYang on 16/4/9.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YBSubjectData;

typedef void (^zipArchiveBlock)(BOOL fileIsExit,BOOL archiveResult);

typedef void (^isExitBlock)(BOOL isExit);

@interface YBSubjectTool : NSObject

+ (NSArray *)getAllSubjectDataWithType:(subjectType)type;

// 获取指定科目指定章节的所有数据
+ (NSArray *)getAllSubjectDataWithType:(subjectType)type chapter:(NSString *)chapter;

// 获取指定科目的章节
+ (NSArray *)getAllSubjectChapterWithType:(subjectType)type;

// 判断错题是否在错题库中
+ (void)isExitWrongQuestionWithtype:(subjectType)type userid:(NSString *)userid webnoteid:(NSInteger)webnoteid isExitBlock:(isExitBlock)isExitBlock;

// 插入错题
+ (void)insertWrongQuestionwithtype:(subjectType)type userid:(NSString *)userid webnoteid:(NSInteger)webnoteid;
// 获取错题
+ (NSArray *)getAllWrongQuestionwithtype:(subjectType)type userid:(NSString *)userid;

// 获取随机考试题库
+ (NSArray *)getAllExamDataWithType:(subjectType)type;

/**
 *  根据语音时长格式化时长
 *
 *  @param duration 原始时长
 *
 *  @return 格式化后的时长
 */
+ (NSString *)duration:(NSString *)duration;

@end
