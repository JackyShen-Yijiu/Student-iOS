//
//  BaseContainViewController.h
//  BlackCat
//
//  Created by bestseller on 15/9/15.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLBaseViewController.h"
@protocol BaseContainViewControllerDelegate <NSObject>

- (void)horizontalScrollPageIndex:(NSUInteger)index;

@end
@interface BaseContainViewController : BLBaseViewController
@property (weak, nonatomic) id<BaseContainViewControllerDelegate>delegate;
- (id)initWIthChildViewControllerItems:(NSArray *)itemsVc;
- (void)replaceVcWithIndex:(NSUInteger)index;
@end
