//
//  YBJianglijifenTableView.h
//  studentDriving
//
//  Created by JiangangYang on 16/2/26.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBJianglijifenTableView : UIView
@property(nonatomic,weak) UIViewController *parentViewController;
@property (nonatomic, strong) UITableView *dataTabelView;

@property (nonatomic,strong) NSArray *jianglijifenArrray;
@property (nonatomic,strong) NSArray *kequxianjineduArray;

// YES:奖励积分 NO:不是奖励积分
@property (nonatomic,assign) BOOL isJianglijifen;

- (void)reloadData;

@end
