//
//  DrivingDetailTableHeaderView.h
//  studentDriving
//
//  Created by 大威 on 16/2/18.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
// 轮播图
#import "DVVCycleShowImagesView.h"
#import "DrivingDetailDMData.h"

@interface DrivingDetailTableHeaderView : UIView

@property (nonatomic, copy) NSString *schoolID;

@property (nonatomic, strong) DVVCycleShowImagesView *cycleShowImagesView;

@property (nonatomic, strong) UIImageView *collectionImageView;

- (void)refreshData:(DrivingDetailDMData *)dmData;

+ (CGFloat)defaultHeight;

@end
