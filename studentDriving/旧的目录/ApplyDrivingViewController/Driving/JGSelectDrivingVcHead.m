//
//  JGSelectDrivingVcHead.m
//  studentDriving
//
//  Created by 大威 on 15/12/14.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "JGSelectDrivingVcHead.h"

#define VIEW_WIDTH [UIScreen mainScreen].bounds.size.width

#define filterViewHeight 35

@interface JGSelectDrivingVcHead ()

@property (nonatomic,strong) UIView *footDelive;

@end

@implementation JGSelectDrivingVcHead

- (instancetype)init
{
    self = [super init];
    if (self) {

        // @"车型选择"
        [self addSubview:self.motorcycleTypeButton];
       
        // @[ @"距离最近", @"评分最高", @"价格最低" ]
        [self addSubview:self.filterView];

        // 底部分割线
        [self addSubview:self.footDelive];
        
        // 按钮分割线
        for (int i = 0; i<4; i++) {
            
            UIView *delive = [[UIView alloc] init];
            CGFloat deliveX = VIEW_WIDTH/4 * (i+1);
            CGFloat deliveY = 5;
            CGFloat deliveW = 0.5;
            CGFloat deliveH = filterViewHeight - 2 * deliveY;
            delive.frame = CGRectMake(deliveX, deliveY, deliveW, deliveH);
            delive.backgroundColor = [UIColor lightGrayColor];
            delive.alpha = 0.3;
            [self addSubview:delive];
            
        }
        
        // 箭头
//        for (int j = 0; j<1; j++) {
//            
//            UIImageView *img = [[UIImageView alloc] init];
//            img.backgroundColor = [UIColor clearColor];
//            img.image = [UIImage imageNamed:j == 0 ? @"selectDringBtnSelectImg" : @"selectDringBtnImg"];
//            CGFloat imgw = 10;
//            CGFloat imgH = 5;
//            CGFloat imgx = VIEW_WIDTH/4 * (j+1)-imgw-3;
//            CGFloat imgy = filterViewHeight/2-imgH/2;
//            img.frame = CGRectMake(imgx, imgy, imgw, imgH);
//            img.tag = j+1000;
//            [self addSubview:img];
//            
//        }
        
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
    
    self.motorcycleTypeButton.frame = CGRectMake(0, 0, VIEW_WIDTH/4, filterViewHeight);
    
    self.filterView.frame = CGRectMake(CGRectGetMaxX(self.motorcycleTypeButton.frame), 0, VIEW_WIDTH - (VIEW_WIDTH/4), filterViewHeight);

    self.footDelive.frame = CGRectMake(0, filterViewHeight-1, VIEW_WIDTH, 0.5);
    
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

- (JGItemButton *)motorcycleTypeButton {
    if (!_motorcycleTypeButton) {
        _motorcycleTypeButton = [[JGItemButton alloc] init];
        [_motorcycleTypeButton setTitle:@"车型选择" forState:UIControlStateNormal];
        [_motorcycleTypeButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_motorcycleTypeButton setImage:[UIImage imageNamed:@"selectDringBtnSelectImg.png"] forState:UIControlStateNormal];
        [_motorcycleTypeButton setImage:[UIImage imageNamed:@"selectDringBtnSelectImg.png"] forState:UIControlStateSelected];
        _motorcycleTypeButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _motorcycleTypeButton.titleLabel.contentMode = UIViewContentModeLeft;
        _motorcycleTypeButton.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 15);
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
- (UIView *)footDelive {
    if (!_footDelive) {
        _footDelive = [[UIView alloc] init];
        _footDelive.backgroundColor = [UIColor lightGrayColor];
        _footDelive.alpha = 0.3;
    }
    return _footDelive;
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
    return filterViewHeight;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
