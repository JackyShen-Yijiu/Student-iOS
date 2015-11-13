//
//  CoachInformationCell.m
//  BlackCat
//
//  Created by bestseller on 15/9/28.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "StudentInformationCell.h"
#import "ToolHeader.h"
@interface StudentInformationCell ()
@property (strong, nonatomic) UIView *backGroundView;
@property (strong, nonatomic) UILabel *studentTitle;


@property (strong, nonatomic) UILabel *rainingGround;

@property (strong, nonatomic) UILabel *carType;


@property (strong, nonatomic) UILabel *learnProgress;


@property (strong, nonatomic) UILabel *address;






@end
@implementation StudentInformationCell

- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kSystemWide , 177)];
    }
    return _backGroundView;
}
- (UILabel *)coachTitle {
    
    if (_studentTitle == nil) {
        _studentTitle = [WMUITool initWithTextColor:[UIColor blackColor] withFont:    [UIFont boldSystemFontOfSize:14]];
        _studentTitle.text = @"学车信息";
    }
    return _studentTitle;
}
- (UILabel *)rainingGround {
    
    if (_rainingGround == nil) {
        _rainingGround = [WMUITool initWithTextColor:[UIColor blackColor] withFont:    [UIFont systemFontOfSize:14]];
        _rainingGround.text = @"报考驾校:";
    }
    return _rainingGround;
}
- (UILabel *)rainingGroundDetail {
    
    if (_rainingGroundDetail == nil) {
        _rainingGroundDetail = [WMUITool initWithTextColor:[UIColor blackColor] withFont:    [UIFont systemFontOfSize:14]];
        _rainingGroundDetail.text = @"北京海淀区";
    }
    return _rainingGroundDetail;
}
- (UILabel *)carType {
    
    if (_carType == nil) {
        _carType = [WMUITool initWithTextColor:[UIColor blackColor] withFont:    [UIFont systemFontOfSize:14]];
        _carType.text = @"车    型:";
    }
    return _carType;
}
- (UILabel *)carTypeDetail {
    
    if (_carTypeDetail == nil) {
        _carTypeDetail = [WMUITool initWithTextColor:[UIColor blackColor] withFont:    [UIFont systemFontOfSize:14]];
        _carTypeDetail.text = @"通过率89%";
    }
    return _carTypeDetail;
}
- (UILabel *)learnProgress {
    
    if (_learnProgress == nil) {
        _learnProgress = [WMUITool initWithTextColor:[UIColor blackColor] withFont:    [UIFont systemFontOfSize:14]];
        _learnProgress.text = @"学车进度:";
    }
    return _learnProgress;
}
- (UILabel *)learnProgressDetail {
    
    if (_learnProgressDetail == nil) {
        _learnProgressDetail = [WMUITool initWithTextColor:MAINCOLOR withFont:    [UIFont systemFontOfSize:14]];
        _learnProgressDetail.text = @"科目二第16课时";
    }
    return _learnProgressDetail;
}

- (UILabel *)address {
    
    if (_address == nil) {
        _address = [WMUITool initWithTextColor:[UIColor blackColor] withFont:    [UIFont systemFontOfSize:14]];
        _address.text = @"常用地址:";
    }
    return _address;
}

- (UILabel *)addressDetail {
    
    if (_addressDetail == nil) {
        _addressDetail = [WMUITool initWithTextColor:[UIColor blackColor] withFont:    [UIFont systemFontOfSize:14]];
        _addressDetail.text = @"北京市昌平区天通苑";
    }
    return _addressDetail;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    
    [self.contentView addSubview:self.backGroundView];
    
    [self.backGroundView addSubview:self.coachTitle];
    
    [self.backGroundView addSubview:self.rainingGround];
    
    [self.backGroundView addSubview:self.carType];
    
    [self.backGroundView addSubview:self.learnProgress];
    
    [self.backGroundView addSubview:self.address];
    
    
    [self.backGroundView addSubview:self.rainingGroundDetail];
    
    [self.backGroundView addSubview:self.carTypeDetail];
    
    [self.backGroundView addSubview:self.learnProgressDetail];
    
    [self.backGroundView addSubview:self.addressDetail];
    
    
    [self.coachTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(18);
    }];
    [self.rainingGround mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.coachTitle.mas_bottom).offset(8);
    }];
    [self.carType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.rainingGround.mas_bottom).offset(8);
    }];
    [self.learnProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.carType.mas_bottom).offset(8);
    }];
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.learnProgress.mas_bottom).offset(8);
    }];
   
    
    [self.rainingGroundDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rainingGround.mas_right).offset(10);
        make.top.mas_equalTo(self.rainingGround.mas_top).offset(0);
    }];
    
    [self.carTypeDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.carType.mas_right).offset(10);
        make.top.mas_equalTo(self.carType.mas_top).offset(0);
    }];
    
    [self.learnProgressDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.learnProgress.mas_right).offset(10);
        make.top.mas_equalTo(self.learnProgress.mas_top).offset(0);
    }];
    
    [self.addressDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.address.mas_right).offset(10);
        make.top.mas_equalTo(self.address.mas_top).offset(0);
    }];
    

    
}
@end
