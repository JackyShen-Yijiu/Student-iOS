//
//  SchoolClassDetailMessageCell.h
//  studentDriving
//
//  Created by ytzhang on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchoolClassDetailMessageCell : UITableViewCell
@property (nonatomic, strong) UIView *cellTopLineView;
@property (nonatomic, strong) UILabel *classTextLabel; // 班级详情title
@property (nonatomic, strong) UIView *topLineView;

@property (strong, nonatomic) UILabel *schoolLabel;
@property (strong, nonatomic) UILabel *schoolClassLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *studyLabel;
@property (strong, nonatomic) UILabel *featuredTutorials;
@property (strong, nonatomic) UILabel *carType;
@property (strong, nonatomic) UILabel *price;
@property (nonatomic, strong) UILabel *priceDetailLabel; // 价格详情
@property (strong, nonatomic) UILabel *personCount;
@property (nonatomic, strong) UIView *bottomLineView;


- (void)receiveVipList:(NSArray *)list;

- (void)setUp;
@end