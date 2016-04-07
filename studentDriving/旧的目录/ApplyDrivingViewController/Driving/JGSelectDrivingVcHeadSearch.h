//
//  JGSelectDrivingVcHeadSearch.h
//  studentDriving
//
//  Created by 大威 on 15/12/14.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DVVSearchView.h"

@interface JGSelectDrivingVcHeadSearch : UIView<UITextFieldDelegate>

@property (nonatomic, assign) CGFloat defaultHeight;

@property (nonatomic, strong) DVVSearchView *searchView;

@end
