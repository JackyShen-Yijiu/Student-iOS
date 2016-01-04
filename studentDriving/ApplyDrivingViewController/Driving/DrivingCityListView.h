//
//  DrivingCityListView.h
//  studentDriving
//
//  Created by 大威 on 15/12/17.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DrivingCityListViewSelectedItemBlock)(NSString *cityName);

@interface DrivingCityListView : UIView

<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataList;

- (void)setSelectedItemBlock:(DrivingCityListViewSelectedItemBlock)handle;

- (void)show;

@end
