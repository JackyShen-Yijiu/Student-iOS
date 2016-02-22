//
//  JGActivityCell.h
//  studentDriving
//
//  Created by JiangangYang on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JGActivityModel;

@interface JGActivityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *activityImgView;

@property (weak, nonatomic) IBOutlet UILabel *activityLabel;

@property (weak, nonatomic) IBOutlet UIImageView *stateImgViww;

@property (weak, nonatomic) IBOutlet UILabel *activityTimeLabel;

@property (nonatomic,strong)JGActivityModel *activityModel;

@end
