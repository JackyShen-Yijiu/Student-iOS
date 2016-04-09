//
//  SignUpDetailCell.h
//  studentDriving
//
//  Created by zyt on 16/2/24.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CoachDMData;
@class CoachModel;
typedef void (^DidClickBlock)(NSInteger tag);
@interface SignUpDetailCell : UITableViewCell

- (void)refreshData:(CoachDMData *)coachModel;
- (void)receivedCellModelWith:(CoachModel *)coachModel;

@property (nonatomic,assign) BOOL isSelectCoachVc;
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) DidClickBlock didclickBlock;
@end

