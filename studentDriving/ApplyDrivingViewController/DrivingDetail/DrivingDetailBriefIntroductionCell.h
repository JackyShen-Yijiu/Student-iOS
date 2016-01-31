//
//  DrivingDetailBriefIntroductionCell.h
//  studentDriving
//
//  Created by 大威 on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrivingDetailDMData.h"

typedef void(^ShowMoreButtonTouchDownBlock)(BOOL isShowMore);

@interface DrivingDetailBriefIntroductionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *showMoreImageView;
@property (weak, nonatomic) IBOutlet UILabel *briefIntroductionLabel;

@property (nonatomic, assign) BOOL isShowMore;

- (void)refreshData:(DrivingDetailDMData *)dmData;

+ (CGFloat)dynamicHeight:(NSString *)string isShowMore:(BOOL)isShowMore;

- (void)setShowMoreButtonTouchDownBlock:(ShowMoreButtonTouchDownBlock)handle;

@end
