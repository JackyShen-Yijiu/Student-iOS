//
//  DrivingCell.h
//  BlackCat
//
//  Created by bestseller on 15/9/30.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DrivingModel;
@interface DrivingCell : UITableViewCell
@property (strong, nonatomic) UILabel *distanceLabel;

@property (nonatomic, strong) UIImageView *starBackgroundImageView;
@property (nonatomic, strong) UIImageView *starImageView;
@property (nonatomic, assign) CGFloat star;
@property (nonatomic, strong) UILabel *commentLabel;

- (void)updateAllContentWith:(DrivingModel *)model;
@end
