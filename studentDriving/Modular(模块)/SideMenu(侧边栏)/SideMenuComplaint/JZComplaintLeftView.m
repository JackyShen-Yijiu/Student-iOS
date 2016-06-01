//
//  JZComplaintLeftView.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/10.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZComplaintLeftView.h"
#define kLKSize [UIScreen mainScreen].bounds.size

@implementation JZComplaintLeftView


-(instancetype)initWithFrame:(CGRect)frame {
    
    
    if (self = [super initWithFrame:frame]) {
        
        self = [[NSBundle mainBundle] loadNibNamed:@"JZComplaintLeftView" owner:self options:nil].lastObject;
        
        self.frame = CGRectMake(0, 0, kLKSize.width, kLKSize.height-54);
        
        [self.anonymitySwitch bringSubviewToFront:self];

        
        self.textViewHight.constant = kLKSize.height - 389;

        
        
        UILabel *hoderLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.complaintInfoText.frame.origin.x + 16, self.complaintInfoText.frame.origin.y +14, 250, 14)];
        self.hoderLabel = hoderLabel;
        
        [self addSubview:hoderLabel];
        
        self.hoderLabel.textColor = RGBColor(202, 202, 202);
        
        self.hoderLabel.text = @"请输入投诉内容(500字以内)";
        
        self.hoderLabel.font = [UIFont systemFontOfSize:14];
        
        self.phoneNumTf.text = [AcountManager manager].userMobile;
        
//        self.bottomCoachName.titleLabel.text = [NSString stringWithFormat:@"投诉 %@教练",[[AcountManager manager] applycoach].name];
        self.coachNameLabel.text = [[AcountManager manager] applycoach].name;
        
        [self.bottomCoachName setTitle:[NSString stringWithFormat:@"投诉 %@教练",self.coachNameLabel.text] forState:UIControlStateNormal];
        
        
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeCoachClick)];
        
        
        [self.seeCoachView addGestureRecognizer:tap];
        
        
        self.complaintInfoText.delegate = self;

    }
    
    return self;
}
-(void)seeCoachClick {
    if ([self.complaintPushCoachDetailDelegate respondsToSelector:@selector(initWithComplaintPushCoachDetail)]) {
        [self.complaintPushCoachDetailDelegate initWithComplaintPushCoachDetail];

    }
}
-(UIImageView *)firstImageView {
    
    if (!_firstImageView) {
        
        UIImageView *firstImageView = [[UIImageView alloc]init];
        
        _firstImageView = firstImageView;
        
        
        [self addSubview:firstImageView];
    }
    
    return _firstImageView;
}

-(UIImageView *)secondImageView {
    
    if (!_secondImageView) {
        
        UIImageView *secondImageView = [[UIImageView alloc]init];
        
        _secondImageView = secondImageView;
        
        
        [self addSubview:secondImageView];
    }
    
    return _secondImageView;
}


#pragma mark - textView的代理方法
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    self.hoderLabel.hidden = YES;
    
    [self.hoderLabel removeFromSuperview];
    
//    self.hoderLabel.hidden = YES;
//    
//    [self.hoderLabel removeFromSuperview];
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView{
    if([textView.text length]>500)
    {
        [self obj_showTotasViewWithMes:@"已超过最大字数"];
        return;
    }
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
}







@end
