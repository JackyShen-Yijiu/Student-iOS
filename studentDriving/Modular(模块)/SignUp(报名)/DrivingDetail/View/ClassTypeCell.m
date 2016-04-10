//
//  ClassTypeCell.m
//  studentDriving
//
//  Created by 大威 on 16/1/29.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "ClassTypeCell.h"
#import "NSString+Helper.h"


@implementation ClassTypeCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"ClassTypeCell" owner:self options:nil];
        ClassTypeCell *cell = xibArray.firstObject;
        self = cell;
        [cell setRestorationIdentifier:reuseIdentifier];
        
        self.signUpButton.layer.masksToBounds = YES;
        self.signUpButton.layer.cornerRadius = 4;
        [self.signUpButton setBackgroundColor:YBNavigationBarBgColor];
        
        [self addSubview:self.lineImageView];

        _markLabel.textColor = [UIColor colorWithHexString:@"757575"];
        _priceLabel.textColor = YBNavigationBarBgColor;
        _nameLabel.font = [UIFont boldSystemFontOfSize:13];
        if (YBIphone6Plus) {
            _nameLabel.font = [UIFont boldSystemFontOfSize:13*YBRatio];
        }
        _nameLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
        
        _introductionLabel.font = [UIFont systemFontOfSize:12];
        if (YBIphone6Plus) {
            _introductionLabel.font = [UIFont systemFontOfSize:12*YBRatio];
        }
        _introductionLabel.textColor = [UIColor lightGrayColor];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    CGFloat minX = CGRectGetMinX(_nameLabel.frame);
    _lineImageView.frame = CGRectMake(minX, size.height - 0.5, size.width - minX - 16, 0.5);
}

- (void)refreshData:(ClassTypeDMData *)dmData {
    
    _nameLabel.text = dmData.classname;
    _introductionLabel.text = dmData.classdesc;
    _priceLabel.text = [NSString stringWithFormat:@"￥%zi", dmData.price];
    if (dmData.begindate&&dmData.enddate) {
        _markLabel.text = [NSString stringWithFormat:@"%@~%@",[NSString getYearLocalDateFormateUTCDate:dmData.begindate], [NSString getYearLocalDateFormateUTCDate:dmData.enddate]];        
    }else{
        _markLabel.text = @"暂无数据";
    }
    
}

+ (CGFloat)dynamicHeight:(NSString *)string {
    
    CGFloat font = 12;
    if (YBIphone6Plus) {
        font = 12*YBRatio;
    }
    
    CGFloat newFloat = 45 + [NSString autoHeightWithString:string width:[UIScreen mainScreen].bounds.size.width - 16 * 2 font:[UIFont systemFontOfSize:font]] + 60;
    
    return newFloat;
    
}

- (UIImageView *)lineImageView {
    if (!_lineImageView) {
        _lineImageView = [UIImageView new];
        _lineImageView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    }
    return _lineImageView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
