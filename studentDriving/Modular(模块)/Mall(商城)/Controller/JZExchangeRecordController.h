//
//  ExchangeRecordController.h
//  studentDriving
//
//  Created by ytzhang on 16/4/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZRecordViewModel.h"

@interface JZExchangeRecordController : UIViewController

@property (nonatomic, strong) JZRecordViewModel *viewModel;

@property (nonatomic, assign) BOOL isFormallOrder;
@property (nonatomic, strong) UIViewController *pareVC;
- (void)beginRefresh;
@end
