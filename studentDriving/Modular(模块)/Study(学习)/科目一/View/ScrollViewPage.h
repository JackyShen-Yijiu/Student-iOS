//
//  ScrollViewPage.h
//  ScollViewPage
//
//  Created by allen on 15/9/18.
//  Copyright (c) 2015年 Allen. All rights reserved.
//

// 顶部视频播放：
// 答题状态本地替换数组数据模型思想
//

#import <UIKit/UIKit.h>

@interface ScrollViewPage : UIView<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,assign) NSInteger currentPage;
-(instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *) array;
@end
