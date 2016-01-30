//
//  DrivingDetailSignUpCell.m
//  studentDriving
//
//  Created by 大威 on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DrivingDetailSignUpCell.h"

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
        
        [_courseButton setTitle:@"课程费用" forState:UIControlStateSelected];
        [_coachButton setTitle:@"教练信息" forState:UIControlStateSelected];
        [_courseButton setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        [_coachButton setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        _courseButton.selected = YES;
        
        [_scrollView addSubview:self.classTypeView];
        [_scrollView addSubview:self.coachListView];
        _scrollView.delegate = self;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = _scrollView.bounds.size;
    _scrollView.contentSize = CGSizeMake(size.width * 2, 0);
    _classTypeView.frame = CGRectMake(0, 0, size.width, size.height);
    _coachListView.frame = CGRectMake(size.width, 0, size.width, size.height);
}

- (IBAction)courseButtonAction:(UIButton *)sender {
    _coachButton.selected = NO;
    sender.selected = YES;
    [self.tableView reloadData];
    [UIView animateWithDuration:0.3 animations:^{
        _scrollView.contentOffset = CGPointMake(0, 0);
    }];
}
- (IBAction)coachButtonAction:(UIButton *)sender {
    _courseButton.selected = NO;
    sender.selected = YES;
//    [self.tableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationNone];
    [UIView animateWithDuration:0.3 animations:^{
        _scrollView.contentOffset = CGPointMake(_scrollView.bounds.size.width, 0);
    }];
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    
//    if (0 == scrollView.contentOffset.x) {
//        _coachButton.selected = NO;
//        _courseButton.selected = YES;
//    }else {
//        _courseButton.selected = NO;
//        _coachButton.selected = YES;
//    }
//}

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
    if (_courseButton.selected) {
        return _classTypeView.totalHeight;
    }
    return 8 + 44 + 95 + 95 + 40;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
