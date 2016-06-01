//
//  YBSubjectQuestionsHeader.h
//  studentDriving
//
//  Created by JiangangYang on 16/4/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBMoviePlayerController.h"

@class YBSubjectData;

@interface YBSubjectQuestionsHeader : UIView

@property (nonatomic,strong) UILabel *titleLable;

@property (nonatomic,strong) MPMoviePlayerController *movie;

@property (nonatomic ,assign) NSInteger currentPage;

/**
 @method 播放电影
 */
-(void)reloadData:(YBSubjectData *)data;

- (void)playMovie:(YBSubjectData *)data;

@end
