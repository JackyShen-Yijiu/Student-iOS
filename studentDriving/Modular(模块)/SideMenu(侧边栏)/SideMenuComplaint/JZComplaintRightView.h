//
//  JZComplaintRightView.h
//  studentDriving
//
//  Created by 雷凯 on 16/4/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZComplaintRightView : UIView

///  文本框的高
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHight;

///// 手机号码
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTf;


///  是否匿名
@property (weak, nonatomic) IBOutlet UISwitch *anonymitySwitch;

///  驾校名称
@property (weak, nonatomic) IBOutlet UILabel *schoolNameLabel;


@property (nonatomic, weak) UILabel *hoderLabel;
///  第一张图片
@property (nonatomic, weak) UIImageView *firstImageView;
///  第二张图片
@property (nonatomic, weak) UIImageView *secondImageView;

@property (weak, nonatomic) IBOutlet UITextView *complaintInfoText;

@property (weak, nonatomic) IBOutlet UIButton *addImgBtn;
@property (weak, nonatomic) IBOutlet UIButton *putInBtn;
@property (weak, nonatomic) IBOutlet UIButton *bottomSchoolName;



@end
