//
//  DVVCoachClassTypeView.h
//  studentDriving
//
//  Created by 大威 on 16/2/22.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassTypeDMData.h"
#import "YYModel.h"
#import "ClassTypeCell.h"

typedef void(^DVVCoachClassTypeViewCellBlock)(ClassTypeDMData *dmData);

@interface DVVCoachClassTypeView : UITableView

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *heightArray;
@property (nonatomic, assign) CGFloat totalHeight;

@property (nonatomic, strong) UIImageView *noDataMarkImageView;

- (CGFloat)dynamicHeight:(NSArray *)dataArray;

- (void)setDVVCoachClassTypeViewSignUpButtonActionBlock:(DVVCoachClassTypeViewCellBlock)handle;
- (void)setDVVCoachClassTypeViewCellDidSelectBlock:(DVVCoachClassTypeViewCellBlock)handel;

@end
