//
//  YBAppointmentDetailHeaderView.h
//  studentDriving
//
//  Created by 大威 on 16/3/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBAppointmentDetailHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *imageMarkLabel;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;

@property (nonatomic, readonly, assign) CGFloat defaultHeight;

@end
