//
//  YBSubjectTool.h
//  studentDriving
//
//  Created by JiangangYang on 16/4/9.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^zipArchiveBlock)(BOOL fileIsExit,BOOL archiveResult);

typedef NS_ENUM(NSInteger,subjectType){
    
    subjectOne=1,
    subjectTwo,
    subjectThree,
    subjectFour,
    
};

@interface YBSubjectTool : NSObject

// 获取所有的数据
+ (NSArray *)getAllSubjectDataWithType:(subjectType)type;

@end
