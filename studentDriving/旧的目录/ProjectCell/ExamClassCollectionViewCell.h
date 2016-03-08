//
//  ExamClassCollectionViewCell.h
//  BlackCat
//
//  Created by bestseller on 15/9/30.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExamClassModel.h"

@interface ExamClassCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) ExamClassModel *model;
@property (strong, nonatomic) UILabel *drivingName;
@property (strong, nonatomic) UILabel *drivingAdress;
@property (strong, nonatomic) UILabel *moneyLabel;

- (CGFloat)getLabelWidthWithString:(NSString *)string;
@end
