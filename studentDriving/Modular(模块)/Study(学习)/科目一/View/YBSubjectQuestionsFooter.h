//
//  YBSubjectQuestionsFooter.h
//  studentDriving
//
//  Created by JiangangYang on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YBSubjectData;
@interface YBSubjectQuestionsFooter : UIView

@property (nonatomic,strong) YBSubjectData *data;

@property (nonatomic ,assign) NSInteger currentPage;

@property (nonatomic,strong) UIButton *confimBtn;

@property (nonatomic,strong) UIView *contentView;

@end
