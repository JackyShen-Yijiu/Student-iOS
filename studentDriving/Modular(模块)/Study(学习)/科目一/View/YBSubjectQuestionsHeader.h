//
//  YBSubjectQuestionsHeader.h
//  studentDriving
//
//  Created by JiangangYang on 16/4/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YBSubjectData;
@interface YBSubjectQuestionsHeader : UIView
@property (nonatomic,strong)UILabel *titleLable;
@property (nonatomic ,assign) NSInteger currentPage;
@property (nonatomic,strong) YBSubjectData *data;
@end
