//
//  StudentDetailCell.m
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "StudentDetailCell.h"

@interface StudentDetailCell ()
@property (strong, nonatomic) UIView *backGroundView;


@end
@implementation StudentDetailCell

- (UILabel *)studentIdLabel {
    if (_studentIdLabel == nil) {
        _studentIdLabel = [[UILabel alloc] init];
        _studentIdLabel.text = @"ID 303929835";
        _studentIdLabel.font = [UIFont systemFontOfSize:14];
        _studentIdLabel.textColor = TEXTGRAYCOLOR;
    }
    return _studentIdLabel;
}


- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kSystemWide , 73)];
    }
    return _backGroundView;
}
- (UILabel *)studentNameLabel {
    if (_studentNameLabel == nil) {
        _studentNameLabel = [[UILabel alloc] init];
        _studentNameLabel.text = @"李敏申";
        _studentNameLabel.font = [UIFont boldSystemFontOfSize:16];
        _studentNameLabel.textColor = [UIColor blackColor];
    }
    return _studentNameLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    
    [self.contentView addSubview:self.backGroundView];
    
    [self.backGroundView addSubview:self.studentNameLabel];
    
    [self.backGroundView addSubview:self.studentIdLabel];
    
    
    [self.studentNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(18);
    }];
    
    [self.studentIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.studentNameLabel.mas_bottom).offset(7);
    }];
    
}
@end
