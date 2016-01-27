//
//  DrivingSelectMotorcycleTypeView.h
//  studentDriving
//
//  Created by 大威 on 15/12/15.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DrivingSelectMotorcycleTypeViewSelectedItemBlock)(NSInteger carTypeId, NSString *selectedTitle);

@interface DrivingSelectMotorcycleTypeView : UIView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataList;

- (void)setSelectedItemBlock:(DrivingSelectMotorcycleTypeViewSelectedItemBlock)handle;

- (void)show;

@property (nonatomic,assign)BOOL isShow;

- (void)closeSelf;

@end
