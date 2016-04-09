//
//  MallOrderCell.h
//  studentDriving
//
//  Created by zyt on 16/2/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MallOrderListModel.h"

typedef void (^DidClickBlock)(NSInteger tag);
@interface MallOrderCell : UITableViewCell
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) DidClickBlock didclickBlock;
@property (nonatomic, strong) MallOrderListModel *listModel;
@end
