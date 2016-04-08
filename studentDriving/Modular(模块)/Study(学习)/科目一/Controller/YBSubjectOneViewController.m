//
//  YBSubjectOneViewController.m
//  studentDriving
//
//  Created by JiangangYang on 16/4/8.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBSubjectOneViewController.h"
#import "ScrollViewPage.h"

#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)                        RGBA(r, g, b, 1.0f)
#define Size  [UIScreen mainScreen].bounds.size

@implementation YBSubjectOneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"科目一题库";
    self.view.backgroundColor = YBMainViewControlerBackgroundColor;
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < 100; i++) {
        NSString *str = [NSString stringWithFormat:@"%d",i];
        [tempArray addObject:str];
    }
    ScrollViewPage *scrollView = [[ScrollViewPage alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-64) withArray:tempArray];
    [self.view addSubview:scrollView];

}

@end
