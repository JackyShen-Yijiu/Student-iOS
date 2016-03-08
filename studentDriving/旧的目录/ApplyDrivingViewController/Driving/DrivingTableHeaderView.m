//
//  DrivingTableHeaderView.m
//  studentDriving
//
//  Created by 大威 on 15/12/14.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "DrivingTableHeaderView.h"

#define VIEW_WIDTH [UIScreen mainScreen].bounds.size.width

#define cycleShowViewHeight VIEW_WIDTH * 0.5f
#define filterViewHeight 35
#define searchViewHeight 35

@implementation DrivingTableHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.cycleShowImagesView];
        [self addSubview:self.motorcycleTypeButton];
        [self addSubview:self.filterView];
        [self addSubview:self.searchView];
//        [self.searchView addSubview:self.searchBackgroundImageView];
//        [self.searchView addSubview:self.searchTextField];
//        [self.searchView addSubview:self.searchButton];
        
//        _cycleShowImagesView.backgroundColor = [UIColor redColor];
//        _motorcycleTypeButton.backgroundColor = [UIColor greenColor];
//        _filterView.backgroundColor = [UIColor orangeColor];
//        _searchView.backgroundColor = [UIColor magentaColor];
//        _searchButton.backgroundColor = [UIColor orangeColor];
//        _searchTextField.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self configUI];
}

#pragma mark - configUI
- (void)configUI {
    
    self.cycleShowImagesView.frame = CGRectMake(0, 0, VIEW_WIDTH, cycleShowViewHeight);
    self.motorcycleTypeButton.frame = CGRectMake(0, cycleShowViewHeight, 120, filterViewHeight);
    self.filterView.frame = CGRectMake(100, cycleShowViewHeight, VIEW_WIDTH - 120, filterViewHeight);
    self.searchView.frame = CGRectMake(15, cycleShowViewHeight + filterViewHeight + 5.5, VIEW_WIDTH - 30, searchViewHeight - 11);
//    self.searchBackgroundImageView.frame = CGRectMake(10, 5, VIEW_WIDTH - 20, searchViewHeight - 10);
//    [self.searchBackgroundImageView.layer setCornerRadius:(searchViewHeight - 10) / 2.f];
//    CGFloat searchButtonWidth = 26;
//    self.searchTextField.frame = CGRectMake(20, 0, VIEW_WIDTH - searchButtonWidth - 30, searchViewHeight);
//    self.searchButton.frame = CGRectMake(VIEW_WIDTH - searchButtonWidth - 10, 0, searchButtonWidth, searchViewHeight);
//    CGFloat radius = searchViewHeight / 2.f;
//    self.searchButton.frame = CGRectMake(radius, 0, searchButtonWidth, searchViewHeight);
//    self.searchTextField.frame = CGRectMake(radius + searchButtonWidth, 0, VIEW_WIDTH - radius * 2.f - searchButtonWidth, searchViewHeight);
//    
//    self.searchBackgroundImageView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
//    [self.searchTextField setTintColor:[UIColor grayColor]];
}

#pragma mark - action
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - lazy load

- (DVVCycleShowImagesView *)cycleShowImagesView {
    if (!_cycleShowImagesView) {
        // 实例化创建轮播图
        _cycleShowImagesView = [DVVCycleShowImagesView new];
        // 设置PageControl的位置、是否轮播
        [_cycleShowImagesView setPageControlLocation:2 isCycle:YES];
    }
    return _cycleShowImagesView;
}

- (UIButton *)motorcycleTypeButton {
    if (!_motorcycleTypeButton) {
        _motorcycleTypeButton = [UIButton new];
        [_motorcycleTypeButton setTitle:@"车型选择" forState:UIControlStateNormal];
        [_motorcycleTypeButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _motorcycleTypeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _motorcycleTypeButton;
}

- (DVVToolBarView *)filterView {
    if (!_filterView) {
        _filterView = [DVVToolBarView new];
        _filterView.titleArray = @[ @"距离最近", @"评分最高", @"价格最低" ];
        _filterView.titleSelectColor = [UIColor orangeColor];
        _filterView.followBarColor = [UIColor clearColor];
        _filterView.selectButtonInteger = -1;
    }
    return _filterView;
}

- (UIView *)searchView {
    if (!_searchView) {
        _searchView = [DVVSearchView new];
    }
    return _searchView;
}

//- (UIImageView *)searchBackgroundImageView {
//    if (!_searchBackgroundImageView) {
//        _searchBackgroundImageView = [UIImageView new];
//        [_searchBackgroundImageView.layer setMasksToBounds:YES];
//    }
//    return _searchBackgroundImageView;
//}
//
//- (UIButton *)searchButton {
//    if (!_searchButton) {
//        _searchButton = [UIButton new];
//        [_searchButton setTitle:@"搜索" forState:UIControlStateNormal];
//        _searchButton.titleLabel.font = [UIFont systemFontOfSize:13];
//        [_searchButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//        
////        [_searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchDown];
//    }
//    return _searchButton;
//}
//
//- (UITextField *)searchTextField {
//    if (!_searchTextField) {
//        _searchTextField = [UITextField new];
//        _searchTextField.font = [UIFont systemFontOfSize:13];
//        _searchTextField.delegate = self;
//    }
//    return _searchTextField;
//}

- (CGFloat)defaultHeight {
    return cycleShowViewHeight + filterViewHeight + searchViewHeight;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
