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
            _topLabel.font = [UIFont boldSystemFontOfSize:13*1.5];
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
            _detailsLabel.font = [UIFont systemFontOfSize:12*1.5];
        }
        _detailsLabel.textColor = [UIColor lightGrayColor];
        _detailsLabel.textAlignment = NSTextAlignmentLeft;

    }
    return _detailsLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.topLabel];
        [self.contentView addSubview:self.delive];
        [self.contentView addSubview:self.detailsLabel];

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
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
        }];
        
    }
    return self;
}

- (void)setDmData:(DrivingDetailDMData *)dmData
{
    _dmData = dmData;
    
    NSString *num1 = [NSString stringWithFormat:@"%@",dmData.introduction];
    NSInteger range1 = [num1 length];
    
    NSString *num2 = _dmData.isMore ? @"收起" : @"展开";
    NSInteger range2 = [num2 length];
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",num1,num2]];
    
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, range1)];
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#4967fd"] range:NSMakeRange(range1, range2)];
    
    self.detailsLabel.attributedText = attStr;

    self.detailsLabel.numberOfLines = _dmData.isMore ? 0 : 3;
    
    [self.detailsLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.delive.mas_bottom).offset(10);//
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    
}

+ (CGFloat)cellHeightDmData:(DrivingDetailDMData *)dmData
{
    
    DrivingDetailItemCell *cell = [[DrivingDetailItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DrivingDetailItemCell"];
    
    cell.dmData = dmData;
    
    [cell layoutIfNeeded];
    
    return cell.topLabel.height + cell.detailsLabel.height + 10 * 2;
    
}


@end
