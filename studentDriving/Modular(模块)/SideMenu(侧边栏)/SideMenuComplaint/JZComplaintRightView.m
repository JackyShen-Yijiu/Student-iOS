//
//  JZComplaintRightView.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZComplaintRightView.h"
#define kLKSize [UIScreen mainScreen].bounds.size

@implementation JZComplaintRightView

-(instancetype)initWithFrame:(CGRect)frame {
    
    
    if (self = [super initWithFrame:frame]) {
        
        self = [[NSBundle mainBundle] loadNibNamed:@"JZComplaintRightView" owner:self options:nil].lastObject;
        
        self.frame = CGRectMake(0, 0, kLKSize.width, kLKSize.height-54);
        self.transform = CGAffineTransformMakeTranslation(kLKSize.width,0);
        
        [self.anonymitySwitch bringSubviewToFront:self];
        self.textViewHight.constant = kLKSize.height - 389;
        
        [self.anonymitySwitch addTarget:self action:@selector(switchClick) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *hoderLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.complaintInfoText.frame.origin.x + 16, self.complaintInfoText.frame.origin.y +14, 250, 14)];
        self.hoderLabel = hoderLabel;
        
        [self addSubview:hoderLabel];
        
        self.hoderLabel.textColor = RGBColor(202, 202, 202);
        
        self.hoderLabel.text = @"请输入投诉内容(500字以内)";
        
        self.hoderLabel.font = [UIFont systemFontOfSize:14];
        self.phoneNumTf.text = [AcountManager manager].userMobile;
//        self.bottomSchoolName.titleLabel.text = [NSString stringWithFormat:@"投诉 %@",[[AcountManager manager]applyschool].name];
        

        
        self.schoolNameLabel.text = [[AcountManager manager]applyschool].name;
          [self.bottomSchoolName setTitle:[NSString stringWithFormat:@"投诉 %@",self.schoolNameLabel.text] forState:UIControlStateNormal];

        
        
         self.complaintInfoText.delegate = self;
        
        
    }
    
    return self;
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





-(void)switchClick {
    
    NSLog(@"点击了");
}
#pragma mark - textView的代理方法
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    self.hoderLabel.hidden = YES;
    
    [self.hoderLabel removeFromSuperview];
    
   
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
