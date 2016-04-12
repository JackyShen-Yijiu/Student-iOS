//
//  JZOrderMallNumberCell.h
//  studentDriving
//
//  Created by ytzhang on 16/4/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBIntegralMallModel.h"

@protocol JZMallNumberDelegate <NSObject>

- (void)mallNumberWith:(NSInteger)numberMall;

@end

@interface JZOrderMallNumberCell : UITableViewCell

@property (nonatomic, strong) YBIntegralMallModel *integrtalMallModel;

@property (nonatomic,assign) id<JZMallNumberDelegate> JZMallNumberDelegate;

@end
