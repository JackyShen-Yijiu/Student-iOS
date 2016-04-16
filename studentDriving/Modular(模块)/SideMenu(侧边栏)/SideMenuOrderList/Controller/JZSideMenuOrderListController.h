//
//  JZSideMenuOrderListController.h
//  studentDriving
//
//  Created by ytzhang on 16/4/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZSideMenuOrderToorBarView.h"

@interface JZSideMenuOrderListController : UIViewController

@property (nonatomic, strong) JZSideMenuOrderToorBarView *toolBarView;

@property (nonatomic,assign) BOOL isOpenSignUpOrderList;

@end
