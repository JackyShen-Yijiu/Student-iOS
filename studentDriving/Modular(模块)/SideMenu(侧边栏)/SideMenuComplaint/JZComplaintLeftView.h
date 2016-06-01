//
//  JZComplaintLeftView.h
//  studentDriving
//
//  Created by 雷凯 on 16/4/10.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol complaintPushCoachDetail <NSObject>
// push教练详情
- (void)initWithComplaintPushCoachDetail;
@end

@interface JZComplaintLeftView : UIView<UIImagePickerControllerDelegate,UITextViewDelegate>
/// 是否匿名
@property (weak, nonatomic) IBOutlet UISwitch *anonymitySwitch;
/// 手机号码
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTf;
/// 教练姓名
@property (strong, nonatomic) IBOutlet UILabel *coachNameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHight;

@property (weak, nonatomic) IBOutlet UIButton *addImageBtn;

///  第一张图片
@property (nonatomic, weak) UIImageView *firstImageView;
///  第二张图片
@property (nonatomic, weak) UIImageView *secondImageView;

@property (weak, nonatomic) IBOutlet UITextView *complaintInfoText;
@property (nonatomic, weak) UILabel *hoderLabel;

@property (weak, nonatomic) IBOutlet UIView *seeCoachView;
@property (weak, nonatomic) IBOutlet UIButton *putInBtn;

@property (weak, nonatomic) IBOutlet UIButton *bottomCoachName;

@property (nonatomic, strong) id complaintPushCoachDetailDelegate;




@end
