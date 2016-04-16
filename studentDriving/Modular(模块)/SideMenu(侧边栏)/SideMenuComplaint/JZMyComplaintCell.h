//
//  JZMyComplaintCell.h
//  studentDriving
//
//  Created by 雷凯 on 16/4/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZMyComplaintCell : UITableViewCell
//// 投诉的名称
@property (weak, nonatomic)  UILabel *complaintName;
/// 投诉详情
@property (weak, nonatomic)  UILabel *complaintDetail;
/// 投诉的时间
@property (weak, nonatomic)  UILabel *complaintTime;
/// 投诉的第一张图片
@property (weak, nonatomic)  UIImageView *complaintFirstImg;
/// 投诉的第二张图片
@property (weak, nonatomic)  UIImageView *complaintSecondImg;
@end
