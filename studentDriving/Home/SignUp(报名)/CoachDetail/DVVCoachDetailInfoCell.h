//
//  DVVCoachDetailInfoCell.h
//  studentDriving
//
//  Created by 大威 on 16/2/20.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVVCoachDetailDMData.h"
#import "DVVHorizontalScrollImagesView.h"

@interface DVVCoachDetailInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImageView;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;

@property (nonatomic, strong) DVVHorizontalScrollImagesView *scrollImagesView;

@property (nonatomic, strong) UIImageView *lineImageView;

+ (CGFloat)dynamicHeight:(DVVCoachDetailDMData *)dmData type:(NSUInteger)type;

- (void)refreshData:(DVVCoachDetailDMData *)dmData;

@end
