//
//  JGDrivingDetailTopCell.m
//  BlackCat
//
//  Created by bestseller on 15/9/28.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "JGDrivingDetailTopCell.h"
#import "ToolHeader.h"
#import "RatingBar.h"
#import "CoachDetail.h"

#define margin 10

@interface JGDrivingDetailTopCell ()<RatingBarDelegate>

@property (strong, nonatomic) UIView *backGroundView;
// 姓名
@property (strong, nonatomic) UILabel *coachNameLabel;
// 星级
@property (strong, nonatomic) RatingBar *starBar;
// 头像
@property (nonatomic,strong) UIImageView *headImgView;
// 驾龄
@property (nonatomic,strong) UILabel *jialingLabel;
// 授课类型
@property (nonatomic,strong) UILabel *shoukeleixingLabel;
// 可授科目
@property (nonatomic,strong) UILabel *keshoukemuLabel;
// 距离
//@property (nonatomic,strong) UILabel *juliLabel;
// 是否收藏
@property (nonatomic,strong) UIButton *collectionBtn;
// 灰色底部
@property (nonatomic,strong) UIView *footView;

@end

@implementation JGDrivingDetailTopCell

- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kSystemWide , 160)];
    }
    return _backGroundView;
}
// 星级
- (RatingBar *)starBar {
    if (_starBar == nil) {
        _starBar = [[RatingBar alloc] init];
        [_starBar setImageDeselected:@"starUnSelected.png" halfSelected:nil fullSelected:@"starSelected.png" andDelegate:self];
        _starBar.isIndicator = YES;
        [_starBar displayRating:3];
    }
    return _starBar;
}

// 用户名
- (UILabel *)coachNameLabel {
    if (_coachNameLabel == nil) {
        _coachNameLabel = [[UILabel alloc] init];
        //        _coachNameLabel.text = @"李敏申";
        _coachNameLabel.font = [UIFont boldSystemFontOfSize:15];
        _coachNameLabel.textColor = [UIColor blackColor];
    }
    return _coachNameLabel;
}
// 头像
- (UIImageView *)headImgView
{
    if (_headImgView==nil) {
        _headImgView = [[UIImageView alloc] init];
    }
    return _headImgView;
}

// 驾龄
- (UILabel *)jialingLabel {
    if (_jialingLabel == nil) {
        _jialingLabel = [[UILabel alloc] init];
        _jialingLabel.font = [UIFont systemFontOfSize:12];
        _jialingLabel.textColor = [UIColor lightGrayColor];
    }
    return _jialingLabel;
}
// 授课类型
- (UILabel *)shoukeleixingLabel {
    if (_shoukeleixingLabel == nil) {
        _shoukeleixingLabel = [[UILabel alloc] init];
        _shoukeleixingLabel.font = [UIFont systemFontOfSize:13];
        _shoukeleixingLabel.textColor = [UIColor lightGrayColor];
    }
    return _shoukeleixingLabel;
}
// 可授科目
- (UILabel *)keshoukemuLabel {
    if (_keshoukemuLabel == nil) {
        _keshoukemuLabel = [[UILabel alloc] init];
        _keshoukemuLabel.font = [UIFont systemFontOfSize:13];
        _keshoukemuLabel.textColor = [UIColor lightGrayColor];
    }
    return _keshoukemuLabel;
}
// 距离
//- (UILabel *)juliLabel {
//    if (_juliLabel == nil) {
//        _juliLabel = [[UILabel alloc] init];
//        _juliLabel.font = [UIFont boldSystemFontOfSize:13];
//        _juliLabel.textColor = [UIColor lightGrayColor];
//    }
//    return _juliLabel;
//}
// 是否收藏
- (UIButton *)collectionBtn {
    if (_collectionBtn == nil) {
        _collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectionBtn setBackgroundImage:[UIImage imageNamed:@"collectionBtnImg_nomal"] forState:UIControlStateNormal];
        [_collectionBtn setBackgroundImage:[UIImage imageNamed:@"collectionBtnImg_select"] forState:UIControlStateSelected];
    }
    return _collectionBtn;
}
- (UIView *)footView
{
    if (_footView == nil) {
        _footView = [[UIView alloc] init];
        _footView.backgroundColor = RGBColor(245, 247, 250);
    }
    return _footView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    
    [self.contentView addSubview:self.backGroundView];
    
    // 头像
    [self.backGroundView addSubview:self.headImgView];
    
    // 姓名
    [self.backGroundView addSubview:self.coachNameLabel];
    
    // 驾龄
    [self.backGroundView addSubview:self.jialingLabel];
    
    // 星级
    [self.backGroundView addSubview:self.starBar];
    
    // 授课类型
    [self.backGroundView addSubview:self.shoukeleixingLabel];
    
    // 可授科目
    [self.backGroundView addSubview:self.keshoukemuLabel];
    
    // 距离
  //  [self.backGroundView addSubview:self.juliLabel];
    
    // 是否收藏
    [self.backGroundView addSubview:self.collectionBtn];
    
    // 灰色底部
    [self.backGroundView addSubview:self.footView];
    
    // 头像
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(margin);
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(margin);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(70);
    }];
    
    // 姓名
    [self.coachNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImgView.mas_right).offset(margin);
        make.top.mas_equalTo(self.headImgView.mas_top).offset(margin/2);
        make.height.mas_equalTo(@20);
    }];
    
    // 驾龄
    [self.jialingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImgView.mas_right).offset(margin);
        make.top.mas_equalTo(self.coachNameLabel.mas_bottom);
        make.height.mas_equalTo(@20);
    }];
    
    // 星级
    [self.starBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImgView.mas_right).offset(margin);
        make.top.mas_equalTo(self.jialingLabel.mas_bottom);
        make.width.mas_equalTo(@75);
        make.height.mas_equalTo(@15);
    }];
    
    // 授课类型
    [self.shoukeleixingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImgView);
        make.top.mas_equalTo(self.headImgView.mas_bottom).offset(margin/2);
        make.height.mas_equalTo(@15);
    }];
    
    // 可授科目
    [self.keshoukemuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImgView);
        make.top.mas_equalTo(self.shoukeleixingLabel.mas_bottom).offset(margin/2);
        make.height.mas_equalTo(@15);
    }];
    
    // 距离
//    [self.juliLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.backGroundView.mas_right).offset(-margin);
//        make.top.mas_equalTo(self.keshoukemuLabel.mas_top);
//        make.height.mas_equalTo(@15);
//    }];
//    
    // 是否收藏
    [self.collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backGroundView.mas_right).offset(-margin);
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(30);
        make.height.mas_equalTo(@40);
        make.width.mas_equalTo(@40);
    }];
    
    // 灰色底部
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left);
        make.top.mas_equalTo(self.keshoukemuLabel.mas_bottom).offset(margin);
        make.height.mas_equalTo(margin);
        make.width.mas_equalTo(self.backGroundView);
    }];
    
}

- (void)receiveDetailsModel:(CoachDetail *)_detailModel
{
    // 头像
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_detailModel.headportrait.originalpic]] placeholderImage:[UIImage imageNamed:@"littleImage.png"]];
    
    // 姓名
    self.coachNameLabel.text = _detailModel.name;
    
    // 驾龄
    if (_detailModel.seniority) {
        self.jialingLabel.text = [NSString stringWithFormat:@"驾龄:%@",_detailModel.seniority];
    }else{
        self.jialingLabel.text = @"无驾龄";
    }
    
    // 星级
    [_starBar displayRating:[_detailModel.starlevel floatValue]];
    
    // 授课类型
    self.shoukeleixingLabel.text = [NSString stringWithFormat:@"授课车型:%@",_detailModel.carmodel.name];
    
    // 可授科目
    NSMutableString *subStr = [NSMutableString string];
    for (int i = 0; i<_detailModel.subject.count; i++) {
        NSDictionary *dict = _detailModel.subject[i];
        [subStr appendFormat:@"%@ ",dict[@"name"]];
    }
    self.keshoukemuLabel.text = [NSString stringWithFormat:@"可授科目:%@",subStr];
    
    // 距离
   // self.juliLabel.text = _detailModel.name;
    
    // 是否收藏
    self.collectionBtn.selected = _detailModel.is_lock;
    [self.collectionBtn addTarget:self action:@selector(collectionBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)collectionBtnDidClick
{
    self.collectionBtn.selected = !self.collectionBtn.selected;
    
    NSLog(@"发送收藏、取消收藏请求");
    
}

- (void)ratingChanged:(CGFloat)newRating {
    
}


@end
