//
//  JZExchangeRecordCell.h
//  studentDriving
//
//  Created by ytzhang on 16/4/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZRecordOrdrelist.h"
#import "YBIntegralMallModel.h"

@interface JZExchangeRecordCell : UITableViewCell
@property (nonatomic, strong) JZRecordOrdrelist *recordModel;

@property (nonatomic, strong) YBIntegralMallModel *integrtalMallModel;

@property (nonatomic, strong) UILabel *stateLabel;
@end
