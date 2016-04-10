//
//  DVVConfirmOrderFooterView.h
//  studentDriving
//
//  Created by 大威 on 16/2/25.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVVConfirmOrderFooterView : UIView

@property (weak, nonatomic) IBOutlet UIView *toolBarView;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UIButton *firstImageButton;
@property (weak, nonatomic) IBOutlet UIButton *secondImageButton;
@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet UIButton *secondButton;

@property (weak, nonatomic) IBOutlet UILabel *promptTitleLabel;

- (void)setFirstButtonActionBlock:(dispatch_block_t)handle;
- (void)setSecondButtonActionBlock:(dispatch_block_t)handle;

@end
