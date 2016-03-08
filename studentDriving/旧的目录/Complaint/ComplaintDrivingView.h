//
//  ComplaintDrivingView.h
//  studentDriving
//
//  Created by 大威 on 16/1/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComplaintDrivingView : UIView<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *realNameButton;
@property (weak, nonatomic) IBOutlet UIButton *anonymousButton;

@property (weak, nonatomic) IBOutlet UILabel *drivingNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIButton *photo_1_button;
@property (weak, nonatomic) IBOutlet UIButton *photo_2_button;

@property (weak, nonatomic) IBOutlet UIButton *okButton;

@property (nonatomic, strong) UIViewController *superController;

@end
