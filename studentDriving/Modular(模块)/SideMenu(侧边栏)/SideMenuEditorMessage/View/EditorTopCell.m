//
//  EditorTopCell.m
//  studentDriving
//
//  Created by zyt on 16/2/23.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "EditorTopCell.h"
#import "UIImage+WM.h"

@interface EditorTopCell ()
@property (nonatomic, strong) UIImageView *IconImageView;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIView *lineBottom;


@end
@implementation EditorTopCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.IconImageView];
    [self addSubview:self.arrowImageView];
    [self addSubview:self.lineBottom];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.IconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(15);
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.width.mas_equalTo(@40);
        make.height.mas_equalTo(@40);
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.width.mas_equalTo(@24);
        make.height.mas_equalTo(24);
    }];
    [self.lineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.IconImageView.mas_bottom).offset(15);
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(@0.5);
    }];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UIImageView *)IconImageView{
    if (_IconImageView == nil) {
        _IconImageView = [[UIImageView alloc] init];
        _IconImageView.backgroundColor  = [UIColor clearColor];
        [self.IconImageView sd_setImageWithURL:(NSURL *)[AcountManager manager].userHeadImageUrl placeholderImage:[[UIImage imageNamed:@"me"] getRoundImage] completed:nil];
        [_IconImageView.layer setCornerRadius:20];
        [_IconImageView.layer setMasksToBounds:YES];
    }
    return _IconImageView;
    
}

- (UIImageView *)arrowImageView{
    if (_arrowImageView == nil) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.backgroundColor  = [UIColor clearColor];
        _arrowImageView.image = [UIImage imageNamed:@"箭头"];
    }
    return _arrowImageView;
    
}
- (UIView *)lineBottom{
    if (_lineBottom == nil) {
        _lineBottom = [[UIView alloc] init];
        _lineBottom.backgroundColor = HM_LINE_COLOR;
    }
    return _lineBottom;
}

@end
