//
//  YBBaoMingDuiHuanQuanTableView.h
//  studentDriving
//
//  Created by JiangangYang on 16/2/26.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBBaoMingDuiHuanQuanTableView : UIView
@property(nonatomic,weak) UIViewController *parentViewController;

@property (nonatomic,strong) NSArray *dataArray;
- (void)reloadData;
@end
