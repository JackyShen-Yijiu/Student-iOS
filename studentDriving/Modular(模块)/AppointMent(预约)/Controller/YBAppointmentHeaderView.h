//
//  YBAppointmentHeaderView.h
//  studentDriving
//
//  Created by 大威 on 16/3/10.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBAppointmentHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *subjectTopLabel;
@property (weak, nonatomic) IBOutlet UILabel *buySubjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *guidingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *yuekaoBtn;

@property (nonatomic,weak) UIViewController *parentViewController;

- (void)setUpData;

@end
