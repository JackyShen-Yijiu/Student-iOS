//
//  CourseView.h
//  studentDriving
//
//  Created by 大威 on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassTypeViewModel.h"

typedef void(^ClassTypeViewBlock)(ClassTypeViewModel *viewModel);

@interface ClassTypeView : UITableView

@property (nonatomic,readonly, copy) NSString *schoolID;

@property (nonatomic, readonly, assign) CGFloat totalHeight;

- (void)setClassTypeNetworkSuccessBlock:(ClassTypeViewBlock)handle;

- (void)beginNetworkRequest:(NSString *)schoolID;
@end
