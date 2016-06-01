//
//  JZMyComplaintCell.h
//  studentDriving
//
//  Created by 雷凯 on 16/4/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JZMyComplaintData;

@interface JZMyComplaintCell : UITableViewCell

@property (nonatomic,strong) JZMyComplaintData *data;

+ (CGFloat)cellHeightDmData:(JZMyComplaintData *)dmData;

@end
