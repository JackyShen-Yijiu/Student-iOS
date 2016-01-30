//
//  DrivingDetailTrainingGroundCell.h
//  studentDriving
//
//  Created by 大威 on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVVHorizontalScrollImagesView.h"
#import "DrivingDetailDMData.h"

@interface DrivingDetailTrainingGroundCell : UITableViewCell

@property (nonatomic, strong) DVVHorizontalScrollImagesView *scrollImagesView;

- (void)refreshData:(DrivingDetailDMData *)dmData;

+ (CGFloat)defaultHeight;

@end
