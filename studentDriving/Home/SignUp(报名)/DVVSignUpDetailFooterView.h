//
//  DVVSignUpDetailFooterView.h
//  studentDriving
//
//  Created by 大威 on 16/2/24.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVVSignUpDetailFooterView : UIView

@property (weak, nonatomic) IBOutlet UIView *toolBarView;
@property (weak, nonatomic) IBOutlet UIButton *onLineButton;
@property (weak, nonatomic) IBOutlet UILabel *onLineLabel;
@property (weak, nonatomic) IBOutlet UIButton *offLineButton;
@property (weak, nonatomic) IBOutlet UILabel *offLineLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *promptTitleLabel;

- (void)setOnLineButtonActionBlock:(dispatch_block_t)handle;
- (void)setOffLineButtonActionBlock:(dispatch_block_t)handle;

@end
