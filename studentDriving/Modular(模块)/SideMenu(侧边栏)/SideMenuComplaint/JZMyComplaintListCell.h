//
//  JZMyComplaintListCell.h
//  studentDriving
//
//  Created by 雷凯 on 16/4/15.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZMyComplaintListCell : UITableViewCell
//// 投诉的名称
@property (weak, nonatomic) IBOutlet UILabel *complaintName;
/// 投诉详情
@property (weak, nonatomic) IBOutlet UILabel *complaintDetail;
/// 投诉的时间
@property (weak, nonatomic) IBOutlet UILabel *complaintTime;
/// 投诉的第一张图片
@property (weak, nonatomic) IBOutlet UIImageView *complaintFirstImg;
/// 投诉的第二张图片
@property (weak, nonatomic) IBOutlet UIImageView *complaintSecondImg;

@end
