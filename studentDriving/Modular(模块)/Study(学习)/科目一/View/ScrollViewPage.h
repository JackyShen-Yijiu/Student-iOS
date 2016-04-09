//
//  ScrollViewPage.h
//  ScollViewPage
//
//  Created by allen on 15/9/18.
//  Copyright (c) 2015年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollViewPage : UIView<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,assign) NSInteger currentPage;
-(instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *) array;

@end
