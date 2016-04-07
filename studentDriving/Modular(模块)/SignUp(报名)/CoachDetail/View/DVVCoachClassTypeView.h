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
#import "DVVNoDataPromptView.h"

typedef void(^DVVCoachClassTypeViewBlock)(ClassTypeDMData *dmData);

@interface DVVCoachClassTypeView : UITableView

@property (nonatomic, copy) NSString *coachID;
@property (nonatomic, copy) NSString *coachName;
@property (nonatomic, copy) NSString *schoolID;
@property (nonatomic, copy) NSString *schoolName;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *heightArray;
@property (nonatomic, assign) CGFloat totalHeight;

@property (nonatomic, strong) DVVNoDataPromptView *noDataPromptView;

- (CGFloat)dynamicHeight:(NSArray *)dataArray;

- (void)dvvCoachClassTypeView_setSignUpButtonActionBlock:(DVVCoachClassTypeViewBlock)handle;
- (void)dvvCoachClassTypeView_setCellDidSelectBlock:(DVVCoachClassTypeViewBlock)handle;

@end
