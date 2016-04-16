//
//  JZSignUpCoachListCell.m
//  studentDriving
//
//  Created by ytzhang on 16/3/17.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZSignUpCoachListCell.h"
#import "RatingBar.h"

@interface JZSignUpCoachListCell ()
@property (strong, nonatomic)  UIImageView *headImageView;

@property (strong, nonatomic)  UILabel *coachNameLabel;

@property (strong, nonatomic)  UILabel *kemuLabel;

@property (strong, nonatomic)  UILabel *pinglunCountLabel;

@property (strong, nonatomic)  RatingBar *starBar;

@property (strong, nonatomic)  UILabel *tongguolvLabel;

@property (strong, nonatomic)  UILabel *jialingLabel;


@end
@implementation JZSignUpCoachListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.coachNameLabel];
        [self.contentView addSubview:self.kemuLabel];
        [self.contentView addSubview:self.pinglunCountLabel];
        [self.contentView addSubview:self.jialingLabel];
        [self.contentView addSubview:self.tongguolvLabel];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(30);
        make.left.mas_equalTo(self.mas_left).offset(16);
        make.height.mas_equalTo(@44);
        make.width.mas_equalTo(@44);
    }];
    [self.coachNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(23);
        make.left.mas_equalTo(self.headImageView.mas_right).offset(14);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@64);
    }];
    [self.kemuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.coachNameLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.coachNameLabel.mas_left);
        make.height.mas_equalTo(@12);
    }];
    [self.pinglunCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.kemuLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.coachNameLabel.mas_left);
        make.height.mas_equalTo(@12);
    }];
    [self.starBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.coachNameLabel.mas_top);
        make.right.mas_equalTo(self.mas_right).offset(16);
        make.height.mas_equalTo(@12);
    }];
    [self.jialingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.starBar.mas_bottom).offset(10);
        make.right.mas_equalTo(self.starBar.mas_right);
        make.height.mas_equalTo(@12);
    }];
    [self.tongguolvLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.jialingLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(self.starBar.mas_right);
        make.height.mas_equalTo(@12);
    }];


}
- (void)receivedCellModelFormSignUpWith:(JZCoachListMoel *)coachModel{
    
    /*
     
     @property (nonatomic, strong) NSDictionary *headportrait;
     @property (nonatomic, strong) NSString *name;
     @property (nonatomic, strong) NSArray *subject;
     @property (nonatomic, assign) NSInteger commentcount;
     
     @property (nonatomic, assign) NSInteger starlevel;
     
     @property (nonatomic, assign) NSInteger passrate;
     
     */
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = self.headImageView.width/2;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:coachModel.headportrait[@"originalpic"]] placeholderImage:[UIImage imageNamed:@"littleImage.png"]];
    
    self.coachNameLabel.text = coachModel.name;
    
    NSMutableString *kemuStr = [NSMutableString string];
    for (NSDictionary *subject in coachModel.subject) {
        NSLog(@"subject:%@",subject);
        NSString *name = [NSString stringWithFormat:@"%@ ",subject[@"name"]];
        [kemuStr appendString:name];
    }
    self.kemuLabel.text = kemuStr;
    
    self.pinglunCountLabel.text = [NSString stringWithFormat:@"%lu条评论",coachModel.commentcount];
    
    [_starBar setImageDeselected:@"starUnSelected.png" halfSelected:nil fullSelected:@"starSelected.png" andDelegate:nil];
    CGFloat starLevel = 0;
    if (coachModel.starlevel) {
        starLevel = coachModel.starlevel;
    }
    NSLog(@"starLevel:%f",starLevel);
    [self.starBar displayRating:starLevel];
    
    if (coachModel.passrate) {
        self.jialingLabel.text = [NSString stringWithFormat:@"通过率:%lu%@",coachModel.passrate,@"%"];
    }else {
        self.jialingLabel.text = [NSString stringWithFormat:@"通过率:暂无"];
    }
    
    if (coachModel.Seniority) {
        self.tongguolvLabel.text = [NSString stringWithFormat:@"%@年教龄",coachModel.Seniority] ;
    }else{
        self.tongguolvLabel.text = [NSString stringWithFormat:@"暂无"];
    }
    
}
- (UIImageView *)headImageView{
    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 22;
        
    }
    return _headImageView;
}
- (UILabel *)coachNameLabel{
    if (_coachNameLabel == nil) {
        _coachNameLabel = [[UILabel alloc] init];
        _coachNameLabel.text = @"Jackey";
        _coachNameLabel.font = [UIFont systemFontOfSize:14];
        _coachNameLabel.textColor = JZ_FONTCOLOR_LIGHT;
    }
    return _coachNameLabel;
}
- (UILabel *)kemuLabel{
    if (_kemuLabel == nil) {
        _kemuLabel = [[UILabel alloc] init];
        _kemuLabel.text = @"Jackey";
        _kemuLabel.font = [UIFont systemFontOfSize:12];
        _kemuLabel.textColor = [UIColor colorWithHexString:@"b7b7b7"];
    }
    return _kemuLabel;
}
- (UILabel *)pinglunCountLabel{
    if (_pinglunCountLabel == nil) {
        _pinglunCountLabel = [[UILabel alloc] init];
        _pinglunCountLabel.text = @"Jackey";
        _pinglunCountLabel.font = [UIFont systemFontOfSize:12];
        _pinglunCountLabel.textColor = JZ_FONTCOLOR_LIGHT;
    }
    return _pinglunCountLabel;
}
- (RatingBar *)starBar{
    if (_starBar == nil) {
        _starBar = [[RatingBar alloc] init];
    }
    return _starBar;
}
- (UILabel *)jialingLabel{
    if (_jialingLabel == nil) {
        _jialingLabel = [[UILabel alloc] init];
        _jialingLabel.text = @"Jackey";
        _jialingLabel.font = [UIFont systemFontOfSize:12];
        _jialingLabel.textAlignment = NSTextAlignmentRight;
        _jialingLabel.textColor = [UIColor colorWithHexString:@"2f2f2f"];
    }
    return _pinglunCountLabel;
}
- (UILabel *)tongguolvLabel{
    if (_tongguolvLabel == nil) {
        _tongguolvLabel = [[UILabel alloc] init];
        _tongguolvLabel.text = @"Jackey";
        _tongguolvLabel.font = [UIFont systemFontOfSize:12];
        _tongguolvLabel.textAlignment = NSTextAlignmentRight;
        _tongguolvLabel.textColor = [UIColor colorWithHexString:@"2f2f2f"];
    }
    return _tongguolvLabel;
}

@end
