//
//  DrivingDetailSignUpCell.m
//  studentDriving
//
//  Created by 大威 on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DrivingDetailSignUpCell.h"
#import "YBAPPMacro.h"

@implementation DrivingDetailSignUpCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"DrivingDetailSignUpCell" owner:self options:nil];
        DrivingDetailSignUpCell *cell = xibArray.firstObject;
        
        [cell setRestorationIdentifier:reuseIdentifier];
        self = cell;
        
        [_scrollView addSubview:self.classTypeView];
        [_scrollView addSubview:self.coachListView];
        _scrollView.delegate = self;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    _scrollView.contentSize = CGSizeMake(size.width * 2, 0);
    _classTypeView.frame = CGRectMake(0, 0, size.width, size.height);
    _coachListView.frame = CGRectMake(size.width, 0, size.width, size.height);
    _followLineImageView.frame = CGRectMake(0, 42, size.width / 2.f, 2);
}

- (UIImageView *)followLineImageView {
    if (!_followLineImageView) {
        _followLineImageView = [UIImageView new];
        _followLineImageView.backgroundColor = [UIColor yellowColor];
    }
    return _followLineImageView;
}

- (void)courseButtonAction {
    _showType = 0;
    [self.tableView reloadData];
    [UIView animateWithDuration:0.3 animations:^{
        _scrollView.contentOffset = CGPointMake(0, 0);
        _followLineImageView.frame = CGRectMake(0, 42, [UIScreen mainScreen].bounds.size.width/2.f, 2);
    }];
}
- (void)coachButtonAction {
    _showType = 1;
//    [self.tableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationNone];
    [UIView animateWithDuration:0.3 animations:^{
        _scrollView.contentOffset = CGPointMake(_scrollView.bounds.size.width, 0);
        _followLineImageView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2.f, 42, [UIScreen mainScreen].bounds.size.width/2.f, 2);
    }];
}

// 重新此方法，在设置此值的时候再开始网络请求
- (void)setSchoolID:(NSString *)schoolID {
    _schoolID = schoolID;
    [_classTypeView beginNetworkRequest:_schoolID];
    [_coachListView beginNetworkRequest:_schoolID];

}

- (ClassTypeView *)classTypeView {
    if (!_classTypeView) {
        _classTypeView = [ClassTypeView new];
        __weak typeof(self) ws = self;
        [_classTypeView setClassTypeNetworkSuccessBlock:^(ClassTypeViewModel *viewModel) {
            
            [ws.tableView reloadData];
        }];
    }
    return _classTypeView;
}
- (CoachListView *)coachListView {
    if (!_coachListView) {
        _coachListView = [CoachListView new];
    }
    return _coachListView;
}

- (CGFloat)dynamicHeight {
    if (0 == _showType) {
        return _classTypeView.totalHeight;
    }
    return 64 + 44;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
