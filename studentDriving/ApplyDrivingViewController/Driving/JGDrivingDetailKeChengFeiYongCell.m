//
//  JGDrivingDetailKeChengFeiYongCell.m
//  BlackCat
//
//  Created by bestseller on 15/9/28.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "JGDrivingDetailKeChengFeiYongCell.h"
#import "serverclasslistModel.h"

#define JGMargin 10

@interface JGDrivingDetailKeChengFeiYongCell ()

// C1普通班
@property (strong, nonatomic) UILabel *typeLabel;
// 课程内容
@property (strong, nonatomic) UILabel *countentLabel;
// 报名按钮
@property (nonatomic,strong) UIButton *baomingBtn;
// 分割线
@property (strong, nonatomic) UIView *delive;

@end

@implementation JGDrivingDetailKeChengFeiYongCell

// C1普通班
- (UILabel *)typeLabel {
    
    if (_typeLabel == nil) {
        _typeLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:13]];
        _typeLabel.text = @"C1普通班";
        _typeLabel.textColor = [UIColor blackColor];
    }
    return _typeLabel;
}
// 课程内容
- (UILabel *)countentLabel {
    
    if (_countentLabel == nil) {
        _countentLabel = [[UILabel alloc] init];
        _countentLabel.font = [UIFont systemFontOfSize:12];
        _countentLabel.numberOfLines = 0;
    }
    return _countentLabel;
}
// 报名按钮
- (UIButton *)baomingBtn {
    if (_baomingBtn == nil) {
        _baomingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _baomingBtn;
}

// 分割线
- (UIView *)delive
{
    if (_delive== nil) {
        _delive = [[UIView alloc] init];
        _delive.backgroundColor = [UIColor lightGrayColor];
        _delive.alpha = 0.3;
    }
    return _delive;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    
    // C1普通班
    [self.contentView addSubview:self.typeLabel];
    
    // 课程内容
    [self.contentView addSubview:self.countentLabel];
    
    // 报名按钮
    [self.contentView addSubview:self.baomingBtn];
    
    // 分割线
    [self.contentView addSubview:self.delive];
   
    // 授课信息title
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(JGMargin));
        make.left.equalTo(self.contentView.mas_left).offset(JGMargin*3);
        make.right.equalTo(self.contentView.mas_right).offset(-JGMargin*3);
        make.height.equalTo(@15);
    }];
    
    // 课程内容
    [self.countentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeLabel.mas_bottom).offset(JGMargin/2);//
        make.left.equalTo(self.typeLabel.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-JGMargin*3);
    }];
    
    // 报名按钮
    [self.baomingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.countentLabel.mas_bottom).offset(JGMargin);//
        make.width.equalTo(@(130));
        make.height.equalTo(@(44));
        make.left.equalTo(@(kSystemWide/2-130/2));
    }];
    
    // 分割线
    [self.delive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baomingBtn.mas_bottom).offset(JGMargin);//
        make.left.equalTo(self.contentView.mas_left).offset(JGMargin);
        make.height.equalTo(@0.5);
        make.width.equalTo(@(kSystemWide-JGMargin));
    }];
}

- (void)setDetailModel:(serverclasslistModel *)detailModel
{
    _detailModel = detailModel;
    
    self.typeLabel.text = _detailModel.classname;
  
    
    NSString *num1 = _detailModel.classdesc;
    NSInteger range1 = [num1 length];
    
    NSString *num2 = [NSString stringWithFormat:@"¥%ld",(long)_detailModel.price];
    NSInteger range2 = [num2 length];

    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",num1,num2]];
    
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, range1)];
    [attStr addAttribute:NSForegroundColorAttributeName value:MAINCOLOR range:NSMakeRange(range1, range2+1)];
    
    self.countentLabel.attributedText = attStr;
    
    if ([[AcountManager manager].userApplystate isEqualToString:@"1"]) {
        
        self.baomingBtn.userInteractionEnabled = NO;
        [_baomingBtn setTitle:@"报名申请中" forState:UIControlStateNormal];
        [_baomingBtn setBackgroundImage:[UIImage imageNamed:@"baomingBtnNomal.png"] forState:UIControlStateNormal];
        
    }else if ([[AcountManager manager].userApplystate isEqualToString:@"2"]) {
        
        self.baomingBtn.userInteractionEnabled = NO;
        [_baomingBtn setTitle:@"报名成功" forState:UIControlStateNormal];
        [_baomingBtn setBackgroundImage:[UIImage imageNamed:@"baomingBtnNomal.png"] forState:UIControlStateNormal];
        
    }else {
        
        self.baomingBtn.userInteractionEnabled = YES;
        [_baomingBtn setTitle:@"报名" forState:UIControlStateNormal];
        [_baomingBtn setTitle:@"报名" forState:UIControlStateHighlighted];
        [_baomingBtn setBackgroundImage:[UIImage imageNamed:@"baomingBtnSelect.png"] forState:UIControlStateNormal];
        [_baomingBtn setBackgroundImage:[UIImage imageNamed:@"baomingBtnSelect.png"] forState:UIControlStateHighlighted];

        [self.baomingBtn addTarget:self action:@selector(baomingBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (_indexPath.row==0) {
        
        // 授课信息title
        [self.typeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(0));
            make.left.equalTo(self.contentView.mas_left).offset(JGMargin*3);
            make.right.equalTo(self.contentView.mas_right).offset(-JGMargin*3);
            make.height.equalTo(@15);
        }];
        
    }else{
        
        // 授课信息title
        [self.typeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(JGMargin));
            make.left.equalTo(self.contentView.mas_left).offset(JGMargin*3);
            make.right.equalTo(self.contentView.mas_right).offset(-JGMargin*3);
            make.height.equalTo(@15);
        }];
        
    }
    
    
}

+ (CGFloat)heightWithModel:(serverclasslistModel *)model indexPath:(NSIndexPath *)indexPath
{
    
    JGDrivingDetailKeChengFeiYongCell *cell = [[JGDrivingDetailKeChengFeiYongCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"kechengfeiyong"];
    
    cell.detailModel = model;
    
    [cell layoutIfNeeded];
    
    CGFloat margin = JGMargin * 3.5;
    if (indexPath.row==0) {
        margin = JGMargin * 2.5;
    }
    
    return cell.typeLabel.frame.size.height+cell.countentLabel.frame.size.height+cell.baomingBtn.frame.size.height+0.5+margin;
    
}

- (void)baomingBtnDidClick
{
    if ([self.delegate respondsToSelector:@selector(JGDrivingDetailKeChengFeiYongCellWithBaomingDidClick:)]) {
        [self.delegate JGDrivingDetailKeChengFeiYongCellWithBaomingDidClick:self];
    }
}

@end
