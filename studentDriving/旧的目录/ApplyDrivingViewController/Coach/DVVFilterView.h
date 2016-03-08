//
//  DVVFilterView.h
//  studentDriving
//
//  Created by 大威 on 16/1/6.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVVToolBarView.h"

@interface DVVFilterView : UIView

@property (nonatomic, strong) NSString *leftButtonTitleString;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) DVVToolBarView *toolBarView;

@end
