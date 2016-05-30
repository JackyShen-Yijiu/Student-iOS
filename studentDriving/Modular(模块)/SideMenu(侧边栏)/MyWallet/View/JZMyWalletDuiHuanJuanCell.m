//
//  JZMyWalletDuiHuanJuanCell.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZMyWalletDuiHuanJuanCell.h"
static NSString *duiHuanJuanDetailCellID = @"duiHuanJuanDetailCellID";
@implementation JZMyWalletDuiHuanJuanCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self = [[NSBundle mainBundle]loadNibNamed:@"JZMyWalletDuiHuanJuanCell" owner:self options:nil].lastObject;
        
        self.contentView.backgroundColor = RGBColor(232, 232, 237);
        [self.contentView addSubview:self.groundView];
        [self.groundView addSubview:self.titleLabel];
        [self.groundView addSubview:self.duiHuanJuanDetailButton];
        
        
    }
    
    return self;
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.groundView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);

        
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.groundView.mas_top).offset(16);
        make.left.equalTo(self.groundView.mas_left).offset(16);
        make.height.equalTo(@12);
        
    }];
    
    [self.duiHuanJuanDetailButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.groundView.mas_left).offset(16);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(14);

        
    }];
}
-(UIView *)groundView {
    
    if (!_groundView) {
        
        
        self.groundView = [[UIView alloc]init];
        
        self.groundView.backgroundColor = [UIColor whiteColor];
    }
    
    return _groundView;
}

-(UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        self.titleLabel = [[UILabel alloc]init];
        
        self.titleLabel.text = @"该兑换券仅能在下列活动中选择一个活动使用";
        self.titleLabel.textColor = RGBColor(219, 68, 55);
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    
    return _titleLabel;
}
-(UIButton *)duiHuanJuanDetailButton {
    if (!_duiHuanJuanDetailButton) {
        self.userInteractionEnabled = NO;
        self.duiHuanJuanDetailButton = [[UIButton alloc]init];
        [self.duiHuanJuanDetailButton setTitleColor:RGBColor(140, 140, 140) forState:UIControlStateNormal];
        [self.duiHuanJuanDetailButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [self.duiHuanJuanDetailButton setImage:[UIImage imageNamed:@"point"] forState:UIControlStateNormal];
        self.duiHuanJuanDetailButton.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, -6);
    }
    
    return _duiHuanJuanDetailButton;
}

@end
