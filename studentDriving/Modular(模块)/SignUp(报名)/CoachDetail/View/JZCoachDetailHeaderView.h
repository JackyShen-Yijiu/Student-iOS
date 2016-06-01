//
//  JZCoachDetailHeaderCell.h
//  studentDriving
//
//  Created by ytzhang on 16/4/20.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZCoachDetailHeaderView : UIView

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *arrowImgView;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, assign) BOOL isShowClassTypeDetail;

@property (nonatomic, assign) BOOL isShowCommentDetail;
@end
