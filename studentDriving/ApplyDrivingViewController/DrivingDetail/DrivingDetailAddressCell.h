//
//  DrivingDetailAddressCell.h
//  studentDriving
//
//  Created by 大威 on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrivingDetailDMData.h"
// 轮播图
#import "DVVCycleShowImagesView.h"

@interface DrivingDetailAddressCell : UITableViewCell

@property (nonatomic, copy) NSString *schoolID;

@property (nonatomic, strong) DVVCycleShowImagesView *cycleShowImagesView;

@property (nonatomic, strong) UIImageView *collectionImageView;

@property (weak, nonatomic) IBOutlet UILabel *drivingNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

+ (CGFloat)defaultHeight;

- (void)refreshData:(DrivingDetailDMData *)dmData;

@end
