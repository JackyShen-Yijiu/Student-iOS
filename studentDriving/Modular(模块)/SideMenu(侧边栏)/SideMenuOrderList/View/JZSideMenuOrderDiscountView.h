//
//  JZSideMenuOrderDiscountView.h
//  studentDriving
//
//  Created by ytzhang on 16/4/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol JZSideMenuOrderListDiscountDelegate <NSObject>

- (void)initWithNoDataOrderLsitDiscountBG;

@end


@interface JZSideMenuOrderDiscountView : UITableView

@property (nonatomic, strong) id <JZSideMenuOrderListDiscountDelegate> sideMenuOrderListDiscountDelegate;

- (void)begainRefresh;


@end
