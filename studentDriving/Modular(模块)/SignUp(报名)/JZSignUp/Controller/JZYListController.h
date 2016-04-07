//
//  JZYListController.h
//  studentDriving
//
//  Created by ytzhang on 16/3/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZYListModel.h"

@protocol didCellBackYModelDelegate <NSObject>

- (void)initWithYlistModel:(JZYListModel *)ylistModel;

@end
@interface JZYListController : UIViewController
@property(nonatomic,weak)id<didCellBackYModelDelegate>delegate;
@end
