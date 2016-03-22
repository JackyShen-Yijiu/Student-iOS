//
//  DVVCoachDetailCourseCell.m
//  studentDriving
//
//  Created by 大威 on 16/2/20.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVCoachDetailCourseCell.h"

@implementation DVVCoachDetailCourseCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.scrollView];
        [_scrollView addSubview:self.classTypeView];
        [_scrollView addSubview:self.commentView];
    }
    return self;
}

- (void)setCoachID:(NSString *)coachID {
    _coachID = coachID;
    _commentView.coachID = coachID;
}

- (void)courseButtonAction {
    _showType = 0;
    [self.tableView reloadData];
    [UIView animateWithDuration:0.3 animations:^{
        _scrollView.contentOffset = CGPointMake(0, 0);
    }];
}

- (void)commentButtonAction {
    _showType = 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationNone];
    [UIView animateWithDuration:0.3 animations:^{
        _scrollView.contentOffset = CGPointMake(_scrollView.bounds.size.width, 0);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    _scrollView.frame = self.bounds;
    _scrollView.contentSize = CGSizeMake(size.width * 2, 0);
    _classTypeView.frame = CGRectMake(0, 0, size.width, size.height);
    _commentView.frame = CGRectMake(size.width, 0, size.width, size.height);
}

- (CGFloat)dynamicHeight:(NSArray *)dataArray {
    CGFloat height = [UIScreen mainScreen].bounds.size.height - (64 + 44);
    CGFloat tempHeight = 0;
    if (0 == _showType) {
        tempHeight = [_classTypeView dynamicHeight:dataArray];
    }else {
//        tempHeight = 
    }
    
    if (tempHeight < height) {
        return height;
    }else {
        return tempHeight;
    }
}

- (DVVCoachClassTypeView *)classTypeView {
    if (!_classTypeView) {
        _classTypeView = [DVVCoachClassTypeView new];
    }
    return _classTypeView;
}
- (DVVCoachCommentView *)commentView {
    if (!_commentView) {
        _commentView = [DVVCoachCommentView new];
    }
    return _commentView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.scrollEnabled = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
