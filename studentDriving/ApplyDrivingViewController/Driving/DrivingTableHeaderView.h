//
//  DrivingTableHeaderView.h
//  studentDriving
//
//  Created by 大威 on 15/12/14.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVVCycleShowImagesView.h"
#import "DVVToolBarView.h"
#import "DVVSearchView.h"

@interface DrivingTableHeaderView : UIView<UITextFieldDelegate>

@property (nonatomic, assign) CGFloat defaultHeight;
@property (nonatomic, strong) DVVCycleShowImagesView *cycleShowImagesView;
@property (nonatomic, strong) UIButton *motorcycleTypeButton;
@property (nonatomic, strong) DVVToolBarView *filterView;
//@property (nonatomic, strong) UIView *searchView;
//@property (nonatomic, strong) UIImageView *searchBackgroundImageView;
//@property (nonatomic, strong) UIButton *searchButton;
//@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) DVVSearchView *searchView;

@end
