//
//  SchoolClassDetailDisCell.m
//  studentDriving
//
//  Created by ytzhang on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "SchoolClassDetailDisCell.h"

#import "VipserverModel.h"
#import "UIColor+Hex.h"
@interface SchoolClassDetailDisCell ()
@property (strong, nonatomic) UIView  *backGroundView;
@end
@implementation SchoolClassDetailDisCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUp];
//        self.backGroundView = [UIColor whiteColor];
    }
    return self;
}
- (void)setUp {
    [self.contentView addSubview:self.textDetailLabel];
    [self.contentView addSubview:self.schoolDetailIntroduction];
//    [self.contentView addSubview:self.bottomLineView];
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
        CGFloat fontSize = 14;
        if (YBIphone6Plus) {
            fontSize = 14 * YBRatio;
        }
        _textDetailLabel = [[UILabel alloc] init];
        _textDetailLabel.font = [UIFont systemFontOfSize:fontSize];
        _textDetailLabel.text = @"课程描述";
        _textDetailLabel.textColor = YBNavigationBarBgColor;
        
    }
    return _textDetailLabel;
}
- (UILabel *)schoolDetailIntroduction{
    if (_schoolDetailIntroduction == nil) {
        _schoolDetailIntroduction = [[UILabel alloc] init];
        _schoolDetailIntroduction.numberOfLines = 0;
        _schoolDetailIntroduction.text = @"一步互联网驾校,本着对社会复,为学员服务,争创一流驾校和行业电放的经验理念,在转正教授设施,以德育人,做的廉政绿箭,精心培训,合理收费,个性化优质复";
        CGFloat fontSize = 14;
        if (YBIphone6Plus) {
            fontSize = 14 * YBRatio;
        }

        _schoolDetailIntroduction.font = [UIFont systemFontOfSize:fontSize];
        _schoolDetailIntroduction.textColor = JZ_FONTCOLOR_LIGHT;
        
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
        make.height.mas_equalTo(@14);
    }];
    [self.schoolDetailIntroduction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textDetailLabel.mas_bottom).with.offset(14);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(15);
        NSNumber *widthX = [[NSNumber alloc] initWithFloat:self.contentView.frame.size.width - 30];
        make.width.mas_equalTo(widthX);
    }];
    
}
- (CGFloat)heightWithcell:(ClassTypeDMData *)model
{
    NSString *str = model.classdesc;
    return   [self getLabelWidthWithString:str];
    
}
- (CGFloat)getLabelWidthWithString:(NSString *)string {
    CGFloat fontSize = 14;
    if (YBIphone6Plus) {
        fontSize = 14 * YBRatio;
    }
    

    CGRect bounds = [string boundingRectWithSize:
                     CGSizeMake([[UIScreen mainScreen] bounds].size.width - 30, 10000) options:
                     NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];

    return bounds.size.height + 14 + 14 + 10;
}
- (void)setClassTypeModel:(ClassTypeDMData *)classTypeModel{
    if (classTypeModel.classdesc && classTypeModel.classdesc.length) {
        self.schoolDetailIntroduction.text = classTypeModel.classdesc;
    }else {
        self.schoolDetailIntroduction.text = @"未填写描述";
    }
}
@end

