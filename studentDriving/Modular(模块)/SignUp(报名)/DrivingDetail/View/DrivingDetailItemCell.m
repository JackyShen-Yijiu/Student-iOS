//
//  DrivingDetailItemCell.m
//  studentDriving
//
//  Created by JiangangYang on 16/3/18.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DrivingDetailItemCell.h"

@interface DrivingDetailItemCell()

@property (nonatomic,strong) UILabel *topLabel;
@property (nonatomic,strong) UIView *delive;

@end

@implementation DrivingDetailItemCell

- (UILabel *)topLabel
{
    if (_topLabel == nil) {
        
        _topLabel = [[UILabel alloc] init];
        _topLabel.font = [UIFont boldSystemFontOfSize:13];
        if (YBIphone6Plus) {
            _topLabel.font = [UIFont boldSystemFontOfSize:13*YBRatio];
        }
        _topLabel.text = @"驾校详情";
        _topLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
        _topLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _topLabel;
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

- (UILabel *)detailsLabel
{
    if (_detailsLabel == nil) {
        
        _detailsLabel = [[UILabel alloc] init];
        _detailsLabel.font = [UIFont systemFontOfSize:12];
        if (YBIphone6Plus) {
            _detailsLabel.font = [UIFont systemFontOfSize:12*YBRatio];
        }
        _detailsLabel.textColor = [UIColor lightGrayColor];
        _detailsLabel.textAlignment = NSTextAlignmentLeft;

    }
    return _detailsLabel;
}

- (UIButton *)isMoteBtn
{
    if (_isMoteBtn==nil) {
        _isMoteBtn = [[UIButton alloc] init];
        [_isMoteBtn setTitle:@"展开" forState:UIControlStateNormal];
        [_isMoteBtn setTitle:@"收起" forState:UIControlStateSelected];
        [_isMoteBtn setTitleColor:[UIColor colorWithHexString:@"#4967fd"] forState:UIControlStateNormal];
        [_isMoteBtn setTitleColor:[UIColor colorWithHexString:@"#4967fd"] forState:UIControlStateSelected];
        _isMoteBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        if (YBIphone6Plus) {
            _isMoteBtn.titleLabel.font = [UIFont systemFontOfSize:12*YBRatio];
        }
    }
    return _isMoteBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.topLabel];
        [self.contentView addSubview:self.delive];
        [self.contentView addSubview:self.detailsLabel];
        [self.contentView addSubview:self.isMoteBtn];
        
        [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        
        [self.delive mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.topLabel.mas_bottom);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        
        [self.detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.delive.mas_bottom).offset(10);//
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
        }];
        
        [self.isMoteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.detailsLabel.mas_bottom);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(20);
        }];
        
    }
    return self;
}

- (void)setDmData:(DrivingDetailDMData *)dmData
{
    _dmData = dmData;
    
    self.detailsLabel.text = [NSString stringWithFormat:@"%@",dmData.introduction];

    self.detailsLabel.numberOfLines = _dmData.isMore ? 0 : 3;
    self.isMoteBtn.selected = _dmData.isMore;
    
    [self.delive mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topLabel.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.detailsLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.delive.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    [self.isMoteBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.detailsLabel.mas_bottom);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];
    
}

+ (CGFloat)cellHeightDmData:(DrivingDetailDMData *)dmData
{
    
    DrivingDetailItemCell *cell = [[DrivingDetailItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DrivingDetailItemCell"];
    
    cell.dmData = dmData;
    
    [cell layoutIfNeeded];
    
    return cell.topLabel.height + cell.detailsLabel.height + cell.isMoteBtn.height + 10 * 2;

}


@end
