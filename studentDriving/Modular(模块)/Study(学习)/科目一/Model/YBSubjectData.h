//
//  YBSubjectData.h
//  studentDriving
//
//  Created by JiangangYang on 16/4/9.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBSubjectData : NSObject

@property (nonatomic, assign) NSInteger ID;

// 1:正确错误 2：单选4个选项 3：4个选项,多选
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger intNumber;
@property (nonatomic, assign) NSInteger strTppe;
@property (nonatomic, assign) NSInteger strType_l;

@property (nonatomic, copy) NSString *license_type;
@property (nonatomic, copy) NSString *question;

@property (nonatomic, copy) NSString *answer1;
@property (nonatomic, copy) NSString *answer2;
@property (nonatomic, copy) NSString *answer3;
@property (nonatomic, copy) NSString *answer4;
@property (nonatomic, copy) NSString *answer5;
@property (nonatomic, copy) NSString *answer6;
@property (nonatomic, copy) NSString *answer7;

@property (nonatomic,assign) NSInteger answer_true;

@property (nonatomic, copy) NSString *explain;

@property (nonatomic, assign) NSInteger kemu;

@property (nonatomic, copy) NSString *explain_form;

@property (nonatomic, copy) NSString *moretypes;

@property (nonatomic, copy) NSString *chapterid;

@property (nonatomic, copy) NSString *img_url;
@property (nonatomic, copy) NSString *video_url;

@property (nonatomic, assign) NSInteger diff_degree;

@end
