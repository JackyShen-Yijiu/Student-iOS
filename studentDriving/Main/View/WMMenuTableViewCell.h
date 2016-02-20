//
//  WMMenuTableViewCell.h
//  QQSlideMenu
//
//  Created by wamaker on 15/6/12.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMMenuTableViewCell : UITableViewCell
- (void)setCellText:(NSString *)str withNormolImageStr:(NSString *)imageStr withSelectImageStr:(NSString *)selectImageStr;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
