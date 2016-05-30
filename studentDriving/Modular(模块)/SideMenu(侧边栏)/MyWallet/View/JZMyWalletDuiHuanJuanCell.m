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
        [self.groundView addSubview:self.duiHuanJuanDetailButton01];
        [self.groundView addSubview:self.duiHuanJuanDetailButton02];
        [self.groundView addSubview:self.duiHuanJuanDetailButton03];
        [self.groundView addSubview:self.duiHuanJuanDetailButton04];
        [self.groundView addSubview:self.duiHuanJuanDetailButton05];
        [self.groundView addSubview:self.duiHuanJuanDetailButton06];

        
        
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
    [self.duiHuanJuanDetailButton01 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.groundView.mas_left).offset(16);
        make.top.equalTo(self.duiHuanJuanDetailButton.mas_bottom).offset(4);
        make.height.equalTo(@12);
        
        
    }];
    [self.duiHuanJuanDetailButton02 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.groundView.mas_left).offset(16);
        make.top.equalTo(self.duiHuanJuanDetailButton01.mas_bottom).offset(4);
        make.height.equalTo(@12);

    }];
    [self.duiHuanJuanDetailButton03 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.groundView.mas_left).offset(16);
        make.top.equalTo(self.duiHuanJuanDetailButton02.mas_bottom).offset(4);
        make.height.equalTo(@12);
        
    }];

    [self.duiHuanJuanDetailButton04 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.groundView.mas_left).offset(16);
        make.top.equalTo(self.duiHuanJuanDetailButton03.mas_bottom).offset(4);
        make.height.equalTo(@12);
        
    }];

    [self.duiHuanJuanDetailButton05 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.groundView.mas_left).offset(16);
        make.top.equalTo(self.duiHuanJuanDetailButton04.mas_bottom).offset(4);
        make.height.equalTo(@12);
        
    }];

    [self.duiHuanJuanDetailButton06 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.groundView.mas_left).offset(16);
        make.top.equalTo(self.duiHuanJuanDetailButton05.mas_bottom).offset(4);
        make.height.equalTo(@12);
        
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
-(UIButton *)duiHuanJuanDetailButton01 {
    if (!_duiHuanJuanDetailButton01) {
        self.userInteractionEnabled = NO;
        self.duiHuanJuanDetailButton01 = [[UIButton alloc]init];
        [self.duiHuanJuanDetailButton01 setTitleColor:RGBColor(140, 140, 140) forState:UIControlStateNormal];
        [self.duiHuanJuanDetailButton01.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [self.duiHuanJuanDetailButton01 setImage:[UIImage imageNamed:@"point"] forState:UIControlStateNormal];
        self.duiHuanJuanDetailButton01.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, -6);
    }
    
    return _duiHuanJuanDetailButton01;

}
-(UIButton *)duiHuanJuanDetailButton02 {
    if (!_duiHuanJuanDetailButton02) {
        self.userInteractionEnabled = NO;
        self.duiHuanJuanDetailButton02 = [[UIButton alloc]init];
        [self.duiHuanJuanDetailButton02 setTitleColor:RGBColor(140, 140, 140) forState:UIControlStateNormal];
        [self.duiHuanJuanDetailButton02.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [self.duiHuanJuanDetailButton02 setImage:[UIImage imageNamed:@"point"] forState:UIControlStateNormal];
        self.duiHuanJuanDetailButton02.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, -6);
    }
    
    return _duiHuanJuanDetailButton02;
    
}
-(UIButton *)duiHuanJuanDetailButton03 {
    if (!_duiHuanJuanDetailButton03) {
        self.userInteractionEnabled = NO;
        self.duiHuanJuanDetailButton03 = [[UIButton alloc]init];
        [self.duiHuanJuanDetailButton03 setTitleColor:RGBColor(140, 140, 140) forState:UIControlStateNormal];
        [self.duiHuanJuanDetailButton03.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [self.duiHuanJuanDetailButton03 setImage:[UIImage imageNamed:@"point"] forState:UIControlStateNormal];
        self.duiHuanJuanDetailButton03.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, -6);
    }
    
    return _duiHuanJuanDetailButton03;
    
}
-(UIButton *)duiHuanJuanDetailButton04 {
    if (!_duiHuanJuanDetailButton04) {
        self.userInteractionEnabled = NO;
        self.duiHuanJuanDetailButton04 = [[UIButton alloc]init];
        [self.duiHuanJuanDetailButton04 setTitleColor:RGBColor(140, 140, 140) forState:UIControlStateNormal];
        [self.duiHuanJuanDetailButton04.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [self.duiHuanJuanDetailButton04 setImage:[UIImage imageNamed:@"point"] forState:UIControlStateNormal];
        self.duiHuanJuanDetailButton04.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, -6);
    }
    
    return _duiHuanJuanDetailButton04;
    
}
-(UIButton *)duiHuanJuanDetailButton05 {
    if (!_duiHuanJuanDetailButton05) {
        self.userInteractionEnabled = NO;
        self.duiHuanJuanDetailButton05 = [[UIButton alloc]init];
        [self.duiHuanJuanDetailButton05 setTitleColor:RGBColor(140, 140, 140) forState:UIControlStateNormal];
        [self.duiHuanJuanDetailButton05.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [self.duiHuanJuanDetailButton05 setImage:[UIImage imageNamed:@"point"] forState:UIControlStateNormal];
        self.duiHuanJuanDetailButton05.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, -6);
    }
    
    return _duiHuanJuanDetailButton05;
    
}
-(UIButton *)duiHuanJuanDetailButton06 {
    if (!_duiHuanJuanDetailButton06) {
        self.userInteractionEnabled = NO;
        self.duiHuanJuanDetailButton06 = [[UIButton alloc]init];
        [self.duiHuanJuanDetailButton06 setTitleColor:RGBColor(140, 140, 140) forState:UIControlStateNormal];
        [self.duiHuanJuanDetailButton06.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [self.duiHuanJuanDetailButton06 setImage:[UIImage imageNamed:@"point"] forState:UIControlStateNormal];
        self.duiHuanJuanDetailButton06.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, -6);
    }
    
    return _duiHuanJuanDetailButton06;
    
}
@end
