//
//  SchoolClassDetailDisCell.m
//  studentDriving
//
//  Created by ytzhang on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "SchoolClassDetailDisCell.h"
#import "ToolHeader.h"
#import "VipserverModel.h"
#import "UIColor+Hex.h"
@interface SchoolClassDetailDisCell ()
@property (strong, nonatomic) UIView  *backGroundView;
@end
@implementation SchoolClassDetailDisCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
//        self.backGroundView = [UIColor whiteColor];
    }
    return self;
}
- (void)setUp {
    [self.contentView addSubview:self.textDetailLabel];
    [self.contentView addSubview:self.schoolDetailIntroduction];
    [self.contentView addSubview:self.bottomLineView];
}
- (UIView *)backGroundView{
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] init];
        _backGroundView.backgroundColor = [UIColor whiteColor];
        
    }
    return _backGroundView;
}

- (UILabel *)textDetailLabel{
    if (_textDetailLabel == nil) {
        _textDetailLabel = [[UILabel alloc] init];
        _textDetailLabel.text = @"课程描述";
        _textDetailLabel.textColor = MAINCOLOR;
        
    }
    return _textDetailLabel;
}
- (UILabel *)schoolDetailIntroduction{
    if (_schoolDetailIntroduction == nil) {
        _schoolDetailIntroduction = [[UILabel alloc] init];
        _schoolDetailIntroduction.numberOfLines = 0;
        _schoolDetailIntroduction.text = @"一步互联网驾校,本着对社会复,为学员服务,争创一流驾校和行业电放的经验理念,在转正教授设施,以德育人,做的廉政绿箭,精心培训,合理收费,个性化优质复";
        _schoolDetailIntroduction.font = [UIFont systemFontOfSize:14];
        
    }
    return _schoolDetailIntroduction;
}
- (UIView *)bottomLineView{
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
        
    }
    return _bottomLineView;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.textDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(15);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@16);
    }];
    [self.schoolDetailIntroduction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textDetailLabel.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(15);
        NSNumber *widthX = [[NSNumber alloc] initWithFloat:self.contentView.frame.size.width - 30];
        make.width.mas_equalTo(widthX);
//        make.height.mas_equalTo(@16);
    }];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.schoolDetailIntroduction.mas_bottom).with.offset(20);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(0);
        NSNumber *widthX = [[NSNumber alloc] initWithFloat:self.contentView.frame.size.width];
        make.width.mas_equalTo(widthX);
        make.height.mas_equalTo(@1);
    }];

    
}
- (CGFloat)heightWithcell:(ClassTypeDMData *)model
{
    NSString *str = model.classdesc;
    return   [self getLabelWidthWithString:str];
    
}
- (CGFloat)getLabelWidthWithString:(NSString *)string {
    CGRect bounds = [string boundingRectWithSize:
                     CGSizeMake([[UIScreen mainScreen] bounds].size.width - 30, 10000) options:
                     NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.f]} context:nil];
    [self.schoolDetailIntroduction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textDetailLabel.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(15);
        NSNumber *widthX = [[NSNumber alloc] initWithFloat:self.contentView.frame.size.width - 30];
        make.width.mas_equalTo(widthX);
        make.height.mas_equalTo(@(bounds.size.height));
    }];

    return bounds.size.height + 100;
}
- (void)setClassTypeModel:(ClassTypeDMData *)classTypeModel{
    self.schoolDetailIntroduction.text = classTypeModel.classdesc;
}
@end

