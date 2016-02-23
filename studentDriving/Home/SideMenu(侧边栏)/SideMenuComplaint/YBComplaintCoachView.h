//
//  ComplaintCoachView.h
//  studentDriving
//
//  Created by zyt on 16/2/18.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol complaintPushCoachDetail <NSObject>
// push教练详情
- (void)initWithComplaintPushCoachDetail;
@end

@interface YBComplaintCoachView : UIView

@property (nonatomic, strong) id complaintPushCoachDetailDelegate;

@property (nonatomic, strong) UILabel *nameCoachLabel;

@property (nonatomic, strong) UILabel *bottomCoachName;


@property (nonatomic, strong) UIViewController *superController;
@end
