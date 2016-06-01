//
//  JZMyWalletXianJinCell.h
//  studentDriving
//
//  Created by 雷凯 on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZMyWalletXianJinCell : UITableViewCell
///  现金来源
@property (weak, nonatomic) IBOutlet UILabel *xianJinSourceLabel;
///  日期
@property (weak, nonatomic) IBOutlet UILabel *xianJinDateLabel;
///  现金数

@property (weak, nonatomic) IBOutlet UILabel *xianJinNumLabel;


@end
