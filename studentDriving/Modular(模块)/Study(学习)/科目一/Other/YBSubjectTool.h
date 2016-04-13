//
//  YBSubjectTool.h
//  studentDriving
//
//  Created by JiangangYang on 16/4/9.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^zipArchiveBlock)(BOOL fileIsExit,BOOL archiveResult);

@interface YBSubjectTool : NSObject

// 获取指定科目指定章节的所有数据
+ (NSArray *)getAllSubjectDataWithType:(subjectType)type chapter:(NSString *)chapter;

// 获取指定科目的章节
+ (NSArray *)getAllSubjectChapterWithType:(subjectType)type;

@end
