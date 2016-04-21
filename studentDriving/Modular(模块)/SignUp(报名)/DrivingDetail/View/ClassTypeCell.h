//
//  ClassTypeCell.h
//  studentDriving
//
//  Created by 大威 on 16/1/29.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassTypeDMData.h"

typedef void(^DVVCoachClassTypeViewBlock)(ClassTypeDMData *dmData);

@interface ClassTypeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *markLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *introductionLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

@property (nonatomic, strong) UIImageView *lineImageView;

- (void)refreshData:(ClassTypeDMData *)dmData;

+ (CGFloat)dynamicHeight:(NSString *)string;

- (void)dvvCoachClassTypeView_setSignUpButtonActionBlock:(DVVCoachClassTypeViewBlock)handle;
@end
