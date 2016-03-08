//
//  IWTabBar.h
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IWTabBar,IWTabBarButton;

@protocol IWTabBarDelegate <NSObject>

@optional
- (void)tabBar:(IWTabBar *)tabBar didSelectedButtonFrom:(NSUInteger)from to:(NSUInteger)to;

@end

@interface IWTabBar : UIView
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property (nonatomic, weak) id<IWTabBarDelegate> delegate;

- (void)buttonClick:(IWTabBarButton *)button;

- (NSMutableArray *)tabBarButtons;

@property (nonatomic, weak) IWTabBarButton *selectedButton;

@property (nonatomic, assign) NSUInteger curSelectedIndex;

@end
