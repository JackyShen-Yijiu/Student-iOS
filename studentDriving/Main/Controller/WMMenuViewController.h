//
//  WMMenuViewController.h
//  QQSlideMenu
//
//  Created by wamaker on 15/6/12.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBBaseViewController.h"

@protocol WMMenuViewControllerDelegate <NSObject>
@optional
- (void)didSelectItem:(NSString *)title indexPath:(NSIndexPath *)indexPath;

@end

@interface WMMenuViewController : YBBaseViewController
@property (weak, nonatomic) id<WMMenuViewControllerDelegate> delegate;

@end
