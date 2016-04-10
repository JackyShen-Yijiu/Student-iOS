//
//  JZComplaintDetailCell.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/10.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZComplaintDetailCell.h"

@implementation JZComplaintDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


-(void)setUI {
    
    
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    
    [self.coachLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.contentView.mas_left).offset(16);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(14);

        
    }];
    
    [self.coachLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.coachLabel.mas_right).offset(12);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(14);
        
    }];
    
    [self.detailImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView.mas_right).offset(16);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(24);
        
    }];
    
    
}

#pragma mark - 懒加载
-(UILabel *)coachLabel {
    
    if (!_coachLabel) {
        
        UILabel *coachLabel = [[UILabel alloc]init];
        
        coachLabel.textColor = RGBColor(110, 110, 100);
        
        [coachLabel setFont:[UIFont systemFontOfSize:14]];
        
        _coachLabel = coachLabel;
    
    }
    
    return _coachLabel;
    
}

-(UILabel *)coachNameLabel {
    
    if (!_coachNameLabel) {

    UILabel *coachNameLabel = [[UILabel alloc]init];
    coachNameLabel.textColor = TEXTGRAYCOLOR;
        [coachNameLabel setFont:[UIFont systemFontOfSize:14]];

        
        [self.contentView addSubview:coachNameLabel];
    
    _coachNameLabel = coachNameLabel;

    }
    
    return _coachNameLabel;
}
-(UIImageView *)detailImg {
    if (!_detailImg) {
        
        UIImageView *detailImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"箭头"]];
        
        [self.contentView addSubview:detailImg];
        
        _detailImg = detailImg;
    }
    
    return _detailImg;
}


@end
