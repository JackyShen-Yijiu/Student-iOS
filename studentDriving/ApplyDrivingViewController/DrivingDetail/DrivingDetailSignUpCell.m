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
        [_courseButton setTitle:@"教练信息" forState:UIControlStateSelected];
        _courseButton.selected = YES;
        
        _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 2.f, 0);
    }
    return self;
}

- (IBAction)courseButtonAction:(UIButton *)sender {
    _coachButton.selected = NO;
    sender.selected = YES;
    _scrollView.contentSize = CGSizeMake(0, 0);
}
- (IBAction)coachButtonAction:(UIButton *)sender {
    _courseButton.selected = NO;
    sender.selected = YES;
    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 0);
}

- (CourseView *)courseView {
    if (!_courseView) {
        _courseView = [CourseView new];
    }
    return _courseView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
