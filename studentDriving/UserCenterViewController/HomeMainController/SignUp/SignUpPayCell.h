//
//  SignUpPayCell.h
//  studentDriving
//
//  Created by ytzhang on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBBaseTableCell.h"
typedef void(^clickPayWayBlock) (NSInteger tag);

@interface SignUpPayCell : YBBaseTableCell
@property (nonatomic,copy) clickPayWayBlock clickPayWayBlock;
@property (nonatomic,strong) UIButton *payLineUPButton;
@property (nonatomic, strong) UIButton *payLineDownButton;
@property (nonatomic, strong) UILabel *payLineUPLabel;
@property (nonatomic, strong) UILabel *payLineDownLabel;
@end
