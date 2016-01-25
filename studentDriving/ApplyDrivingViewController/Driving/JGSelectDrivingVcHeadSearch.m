//
//  JGSelectDrivingVcHeadSearch.m
//  studentDriving
//
//  Created by 大威 on 15/12/14.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "JGSelectDrivingVcHeadSearch.h"

#define VIEW_WIDTH [UIScreen mainScreen].bounds.size.width

#define searchViewHeight 35

@interface JGSelectDrivingVcHeadSearch ()
@property (nonatomic,strong) UIView *footDelive;
@end

@implementation JGSelectDrivingVcHeadSearch

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self addSubview:self.searchView];
       
        // 底部分割线
        [self addSubview:self.footDelive];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self configUI];
}

#pragma mark - configUI
- (void)configUI {
    
    self.searchView.frame = CGRectMake(20, 5, VIEW_WIDTH - 40-1, searchViewHeight - 10);

    self.footDelive.frame = CGRectMake(0, searchViewHeight-1, VIEW_WIDTH, 0.5);

}

#pragma mark - action
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}
- (UIView *)footDelive {
    if (!_footDelive) {
        _footDelive = [[UIView alloc] init];
        _footDelive.backgroundColor = [UIColor lightGrayColor];
        _footDelive.alpha = 0.3;
    }
    return _footDelive;
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
    return searchViewHeight;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
