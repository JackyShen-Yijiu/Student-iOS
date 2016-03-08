//
//  SchoolClassDetailMessageCell.m
//  studentDriving
//
//  Created by ytzhang on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "SchoolClassDetailMessageCell.h"
#import "VipserverModel.h"
#import "UIColor+Hex.h"

@interface SchoolClassDetailMessageCell ()
@property (strong, nonatomic) UIView  *backGroundView;
@property (assign, nonatomic) int with;
//@property (strong, nonatomic) UIView  *classDetailBG;
@end
@implementation SchoolClassDetailMessageCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUp];
    }
    return self;
}
- (void)setUp {
    [self.contentView addSubview:self.backGroundView];
    self.backGroundView.userInteractionEnabled = YES;
    [self.backGroundView addSubview:self.cellTopLineView];
    [self.backGroundView addSubview:self.classTextLabel];
    [self.backGroundView addSubview:self.topLineView];
   
    
    [self.backGroundView addSubview:self.schoolLabel];
    [self.backGroundView addSubview:self.schoolClassLabel];
    [self.backGroundView addSubview:self.timeLabel];
    [self.backGroundView addSubview:self.studyLabel];
    [self.backGroundView addSubview:self.featuredTutorials];
    [self.backGroundView addSubview:self.tagView];
    [self.backGroundView addSubview:self.carType];
    [self.backGroundView addSubview:self.price];
    [self.backGroundView addSubview:self.priceDetailLabel];
    [self.backGroundView addSubview:self.personCount];
    [self.backGroundView addSubview:self.bottomLineView];
//    [self.contentView addSubview:self.classDetailBG];
    
    [self.cellTopLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(0);
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(0);
        make.right.mas_equalTo(self.backGroundView.mas_right).offset(0);
        make.height.mas_equalTo(@1);
    }];
    [self.classTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(0);
        make.top.mas_equalTo(self.cellTopLineView.mas_top).offset(0);
        make.right.mas_equalTo(self.backGroundView.mas_right).offset(0);
        make.height.mas_equalTo(@40);
    }];
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.classTextLabel.mas_bottom).offset(0);
        make.right.mas_equalTo(self.backGroundView.mas_right).offset(0);
        make.height.mas_equalTo(@1);
    }];
    [self.schoolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.topLineView.mas_bottom).offset(10);
        make.height.mas_equalTo(@16);
        make.width.mas_equalTo(@100);
    }];
    [self.schoolClassLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.schoolLabel.mas_bottom).offset(12);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.schoolClassLabel.mas_bottom).offset(12);
    }];
    [self.studyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(12);
    }];
    [self.featuredTutorials mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.studyLabel.mas_bottom).offset(12);
    }];
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.studyLabel.mas_bottom).offset(12);
        make.left.mas_equalTo(self.featuredTutorials.mas_right).offset(5);
        make.width.mas_equalTo(@(kSystemWide - 30 - 100));
//        make.height.mas_equalTo(@120);
    }];
    [self.carType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.tagView.mas_bottom).offset(12);
    }];
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.carType.mas_bottom).offset(12);
    }];
    [self.priceDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.price.mas_right).offset(12);
        make.top.mas_equalTo(self.carType.mas_bottom).offset(12);
    }];
    [self.personCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.price.mas_bottom).offset(12);
    }];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.personCount.mas_bottom).offset(10);
        make.right.mas_equalTo(self.backGroundView.mas_right).offset(0);
        make.height.mas_equalTo(@1);
    }];
    
    
    
}
- (void)receiveVipList:(NSArray *)list {
    for (UIView *view in self.featuredTutorials.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    for (NSInteger i = 0; i<list.count; i++) {
        NSInteger row = i / 4;
        VipserverModel *model = list[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(65+(((kSystemWide-60-40)/4)+5)*i, -5+row*(30), (kSystemWide-60-40)/4, 25);
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        button.layer.cornerRadius = 5;
        button.layer.borderColor = [UIColor colorWithHexString:model.color].CGColor;
        button.layer.borderWidth = 1;
        //        button.backgroundColor = [UIColor cyanColor];
        [button setTitleColor:[UIColor colorWithHexString:model.color] forState:UIControlStateNormal];
        [button setTitle:model.name forState:UIControlStateNormal];
        [self.featuredTutorials addSubview:button];
    }
    
}
- (UIView *)cellTopLineView{
    if (_cellTopLineView == nil) {
        _cellTopLineView  = [[UIView alloc] init];
        _cellTopLineView.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
        
    }
    return _cellTopLineView;
}
- (UILabel *)classTextLabel{
    if (_classTextLabel == nil) {
        _classTextLabel = [[UILabel alloc] init];
        _classTextLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont boldSystemFontOfSize:14]];
        _classTextLabel.textAlignment = NSTextAlignmentCenter;
        _classTextLabel.text = @"一步特惠班详情";
    }
    return _classTextLabel;
}
- (UIView *)topLineView{
    if (_topLineView == nil) {
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
    }
    return _topLineView;
}
- (UILabel *)schoolLabel {
    if (_schoolLabel == nil) {
        _schoolLabel = [WMUITool initWithTextColor:MAINCOLOR withFont:[UIFont boldSystemFontOfSize:16]];
        _schoolLabel.text = @"课程信息";
    }
    return _schoolLabel;
}
- (UILabel *)schoolClassLabel {
    if (_schoolClassLabel == nil) {
        _schoolClassLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
        _schoolClassLabel.text = @"适用驾照类型: C1手动挡小车/C2自动挡小车";
    }
    return _schoolClassLabel;
}
- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
        _timeLabel.text = @"有效期: 长期开班";
    }
    return _timeLabel;
}
- (UILabel *)studyLabel {
    if (_studyLabel == nil) {
        _studyLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
        _studyLabel.text = @"授课日程: 平日/周末/平日+周末";
    }
    return _studyLabel;
}
- (UILabel *)featuredTutorials {
    if (_featuredTutorials == nil) {
        _featuredTutorials = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
        _featuredTutorials.text = @"课程特色:";
    }
    return _featuredTutorials;
}
- (GBTagListView *)tagView{
    if (_tagView == nil) {
        _tagView = [[GBTagListView alloc] init];
        _tagView.backgroundColor = [UIColor whiteColor];
        
    }
    return _tagView;
}
- (UILabel *)carType {
    if (_carType == nil) {
        _carType = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
        _carType.text = @"训练车品牌: 桑塔纳3000";
    }
    return _carType;
}
- (UILabel *)price {
    if (_price == nil) {
        _price = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
        _price.text = @"价格: ";
    }
    return _price;
}
- (UILabel *)priceDetailLabel{
    if (_priceDetailLabel == nil) {
        _priceDetailLabel = [WMUITool initWithTextColor:MAINCOLOR withFont:[UIFont systemFontOfSize:14]];
        _priceDetailLabel.text = @"3800元";
    }
    return _priceDetailLabel;                        
}
- (UILabel *)personCount {
    if (_personCount == nil) {
        _personCount = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
        _personCount.text = @"已报名人数: 35人";
    }
    return _personCount;
}
- (UIView *)bottomLineView{
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc]init];
        _bottomLineView.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
    }
    return _bottomLineView;
}
- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 350)];
//        _backGroundView.backgroundColor = [UIColor grayColor];
    }
    return _backGroundView;
}
/*

 */
- (void)setClassTypeModel:(ClassTypeDMData *)classTypeModel{
    
    _classTypeModel = classTypeModel;
    
    NSString *schoolClass = [NSString stringWithFormat:@"适用驾照类型: %@",_classTypeModel.carmodel.code];
    _schoolClassLabel.text = schoolClass;
    NSString *str = classTypeModel.enddate;
    _timeLabel.text = [NSString stringWithFormat:@"有效期: %@",[self componentsSeparatedStr:str]];
    _studyLabel.text = [NSString stringWithFormat:@"授课日程: %@",_classTypeModel.classchedule];
    _carType.text = [NSString stringWithFormat:@"训练车品牌: %@",_classTypeModel.cartype];
    _priceDetailLabel.text = [NSString stringWithFormat:@"%lu元",_classTypeModel.price];
    _personCount.text = [NSString stringWithFormat:@"已报名人数: %lu",_classTypeModel.applycount];
    _classTextLabel.text = _classTypeModel.classname;
    __weak typeof(self) ws = self;
    
    float widht = kSystemWide - 30 - 100;
    NSLog(@"_classTypeModel.vipserverlist:%@",_classTypeModel.vipserverlist);
    
    [self.tagView setTagWithTagArray:_classTypeModel.vipserverlist listWidth:widht listHeight:^(int listHeight) {
        
        NSLog(@"listHeight:%d",listHeight);
        
        [ws.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(ws.studyLabel.mas_bottom).offset(12);
            make.left.mas_equalTo(ws.featuredTutorials.mas_right).offset(5);
            make.width.mas_equalTo(widht);
            make.height.mas_equalTo(listHeight);
            
        }];
    }];
}
- (NSString *)componentsSeparatedStr:(NSString *)str
{
    NSArray *array = [str componentsSeparatedByString:@"T"];
    return array[0];
}
- (CGFloat)heightWithcell:(ClassTypeDMData *)model
{
    __weak typeof(self) ws = self;
    [_tagView setTagWithTagArray:model.vipserverlist listWidth:kSystemWide - 30 - 100 listHeight:^(int listHeight) {
        ws.with = listHeight;
        
    }];

    return   280 + _with;
    
}

@end
