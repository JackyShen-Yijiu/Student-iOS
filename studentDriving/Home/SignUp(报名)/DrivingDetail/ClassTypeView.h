//
//  CourseView.h
//  studentDriving
//
//  Created by 大威 on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassTypeViewModel.h"
#import "ClassTypeDMData.h"
#import "DVVPromptNilDataView.h"

typedef void(^ClassTypeViewBlock)(ClassTypeViewModel *viewModel);
typedef void(^ClassTypeViewCellBlock)(ClassTypeDMData *dmData);

@interface ClassTypeView : UITableView

@property (nonatomic,readonly, copy) NSString *schoolID;

@property (nonatomic, readonly, assign) CGFloat totalHeight;

@property (nonatomic, strong) DVVPromptNilDataView *promptNilDataView;

- (void)setClassTypeNetworkSuccessBlock:(ClassTypeViewBlock)handle;

- (void)beginNetworkRequest:(NSString *)schoolID;

- (void)setClassTypeSignUpButtonActionBlock:(ClassTypeViewCellBlock)handle;
- (void)setClassTypeViewCellDidSelectBlock:(ClassTypeViewCellBlock)handel;

@end
