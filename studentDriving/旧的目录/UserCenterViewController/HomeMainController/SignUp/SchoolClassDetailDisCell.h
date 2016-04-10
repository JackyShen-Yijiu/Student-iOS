//
//  SchoolClassDetailDisCell.h
//  studentDriving
//
//  Created by ytzhang on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassTypeDMData.h"

@interface SchoolClassDetailDisCell : UITableViewCell
@property (nonatomic, strong) UILabel *textDetailLabel;
@property (strong, nonatomic) UILabel *schoolDetailIntroduction;
@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) ClassTypeDMData *classTypeModel;
- (CGFloat)heightWithcell:(ClassTypeDMData *)tableView;
@end
