//
//  DrivingDetailTopItemCell.m
//  studentDriving
//
//  Created by JiangangYang on 16/3/18.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DrivingDetailTopItemCell.h"

@interface DrivingDetailTopItemCell()

@end

@implementation DrivingDetailTopItemCell

- (UIImageView *)imgView
{
    if (_imgView == nil) {
        
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = [UIColor clearColor];
        
    }
    return _imgView;
}

- (UILabel *)leftLabel
{
    if (_leftLabel == nil) {
        
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.font = [UIFont systemFontOfSize:13];
        if (YBIphone6Plus) {
            _leftLabel.font = [UIFont systemFontOfSize:13*1.5];
        }
        _leftLabel.textColor = [UIColor grayColor];
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _leftLabel;
}

- (UILabel *)detailsLabel
{
    if (_detailsLabel == nil) {
        
        _detailsLabel = [[UILabel alloc] init];
        _detailsLabel.font = [UIFont boldSystemFontOfSize:13];
        if (YBIphone6Plus) {
            _detailsLabel.font = [UIFont boldSystemFontOfSize:13*1.5];
        }
        _detailsLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _detailsLabel;
}

- (UIView *)delive
{
    if (_delive == nil) {
        _delive = [[UIView alloc] init];
        _delive.backgroundColor = [UIColor lightGrayColor];
        _delive.alpha = 0.3;
    }
    return _delive;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.imgView];
        
        [self.contentView addSubview:self.leftLabel];
        
        [self.contentView addSubview:self.detailsLabel];
        
        [self.contentView addSubview:self.delive];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(12);
            make.width.mas_equalTo(22);
            make.height.mas_equalTo(22);
        }];

        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imgView.mas_right).offset(10);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [self.detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.leftLabel.mas_right).offset(5);
            make.top.mas_equalTo(self.leftLabel.mas_top);
        }];

        [self.delive mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.leftLabel.mas_left);
            make.right.mas_equalTo(self.contentView.mas_right);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-0.5);
            make.height.mas_equalTo(0.5);
        }];
        
    }
    return self;
}

@end
