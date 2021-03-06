//
//  UserCenterCell.m
//  BlackCat
//
//  Created by 董博 on 15/9/28.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "UserCenterCell.h"
#import "ToolHeader.h"

@interface UserCenterCell ()
@property (strong, nonatomic) UIView *backGroundView;
@end
@implementation UserCenterCell

- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
    }
    return _contentLabel;
}
- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 44)];
    }
    return _backGroundView;
}
- (UIImageView *)leftImageView {
    if (_leftImageView == nil) {
        _leftImageView = [[UIImageView alloc] init];
//        _leftImageView.backgroundColor = MAINCOLOR;
    }
    return _leftImageView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
 
    [self.contentView addSubview:self.backGroundView];
    
    [self.backGroundView addSubview:self.leftImageView];
    
    [self.backGroundView addSubview:self.contentLabel];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(15);
        make.height.mas_equalTo(@18);
        make.width.mas_equalTo(@18);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftImageView.mas_right).offset(12);
        make.top.mas_equalTo(self.leftImageView.mas_top).offset(1);

    }];
    
}
@end
