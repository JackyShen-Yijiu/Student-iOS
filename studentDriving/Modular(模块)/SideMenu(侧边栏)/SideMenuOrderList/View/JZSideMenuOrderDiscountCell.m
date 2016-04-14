//
//  JZSideMenuOrderDiscountCell.m
//  studentDriving
//
//  Created by ytzhang on 16/4/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZSideMenuOrderDiscountCell.h"

static NSString *const knumber = @"create_qrcode";

@interface JZSideMenuOrderDiscountCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *imageBG;

@property (nonatomic, strong) UIImageView *codeImageView;

@property (nonatomic, strong) UILabel *titleLable;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *addressLabel;


@end
@implementation JZSideMenuOrderDiscountCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        [self initData];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)initUI{
    
    self.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.imageBG];
    [self.imageBG addSubview:self.codeImageView];
    [self.imageBG addSubview:self.titleLable];
    [self.imageBG addSubview:self.addressLabel];
    [self.imageBG addSubview:self.timeLabel];
}
- (void)initData{
    NSString *resultStr = [NSString stringWithFormat:BASEURL,knumber];
    NSString *str = @"?text=";
    NSString *lastStr = @"&size=46";
    NSString *finishResultStr = [NSString stringWithFormat:@"%@%@%@%@",resultStr,str,@"",lastStr];
    [self refreshDataWith:finishResultStr];
    
    
}
- (void)refreshDataWith:(NSString *)str{
    NSURL *url = [NSURL URLWithString:str];
    [_codeImageView sd_setImageWithURL:url placeholderImage:nil];
    
}
- (void)layoutSubviews{
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).offset(16);
         make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
        make.height.mas_equalTo(@110);
        
    }];
    [self.imageBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(0);
        make.left.mas_equalTo(self.bgView.mas_left).offset(0);
        make.right.mas_equalTo(self.bgView.mas_right).offset(0);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(0);
    }];
    
    [self.codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageBG.mas_top).offset(20);
        make.left.mas_equalTo(self.imageBG.mas_left).offset(20);
        make.height.mas_equalTo(46);
        make.width.mas_equalTo(46);
        
    }];

    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageBG.mas_top).offset(16);
        make.left.mas_equalTo(self.codeImageView.mas_right).offset(21);
        make.right.mas_equalTo(self.imageBG.mas_right).offset(0);
        make.height.mas_equalTo(14);
        
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLable.mas_bottom).offset(16);
        make.left.mas_equalTo(self.titleLable.mas_left);
        make.right.mas_equalTo(self.imageBG.mas_right).offset(0);
        make.height.mas_equalTo(12);
    }];

    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.imageBG.mas_bottom).offset(-12);
        make.left.mas_equalTo(self.imageBG.mas_left).offset(20);
        make.right.mas_equalTo(self.imageBG.mas_right).offset(0);
        make.height.mas_equalTo(12);
        
    }];
    
}
- (UIView *)bgView{
    if (_bgView == nil ) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor clearColor];
        _bgView.layer.shadowColor = [UIColor blackColor].CGColor;
        _bgView.layer.shadowOffset = CGSizeMake(0, 2);
        _bgView.layer.shadowOpacity = 0.048;
        _bgView.layer.shadowRadius = 2;
    }
    return _bgView;
}
- (UILabel *)titleLable{
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.text = @"兑换券";
        _titleLable.font = [UIFont systemFontOfSize:14];
        _titleLable.textColor = JZ_FONTCOLOR_DRAK;
       
    }
    return _titleLable;
}
- (UILabel *)addressLabel{
    if (_addressLabel == nil) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.text = @"海淀驾校";
        _addressLabel.font = [UIFont systemFontOfSize:12];
        _addressLabel.textColor = JZ_BlueColor;
    }
    return _addressLabel;
}
- (UIImageView *)codeImageView{
    if (_codeImageView == nil) {
        _codeImageView = [[UIImageView alloc] init];
        _codeImageView.backgroundColor = [UIColor grayColor];
    }
    return _codeImageView;
}
- (UIImageView *)imageBG{
    if (_imageBG == nil) {
        _imageBG = [[UIImageView alloc] init];
        _imageBG.image = [UIImage imageNamed:@"ticket"];
    }
    return _imageBG;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"有效期至: 2016/04/28";
        _timeLabel.textColor = JZ_FONTCOLOR_DRAK;
        _timeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _timeLabel;
}
- (void)setListDataModel:(JZSideMenuOrderListData *)listDataModel{
    /*
     "data": [
     {
     "_id": "570cc683ec71a98dbcb0e290",
     "userid": "56e6341394aaa86c3244d9a1",
     "createtime": "2016-04-11T07:26:32.132Z",
     "couponcomefrom": 1,
     "is_forcash": false,
     "state": 4,
     "usetime": "2016-04-15T07:26:32.132Z",
     "productid": {
     "_id": "5652883a35146036001414c5",
     "productname": "64G 闪存盘"
     },
     "orderscanaduiturl": "http://jzapi.yibuxueche.com/validation/applyvalidation?userid=570cc683ec71a98dbcb0e290"
     }

     */
    NSString *resultStr = [NSString stringWithFormat:BASEURL,knumber];
    NSString *str = @"?text=";
    NSString *lastStr = @"&size=46";
    NSString *finishResultStr = [NSString stringWithFormat:@"%@%@%@%@",resultStr,str,listDataModel.orderscanaduiturl,lastStr];
    [self.codeImageView sd_setImageWithURL:[NSURL URLWithString:finishResultStr] placeholderImage:nil];
    self.timeLabel.text = [NSString stringWithFormat:@"消费日期: %@",[self getLocalDateFormateUTCDate:listDataModel.usetime]];
    self.addressLabel.text = listDataModel.productid.productname;

}
//输入的UTC日期格式2013-08-03T04:53:51+0000
- (NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate {
    //    NSLog(@"utc = %@",utcDate);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}
@end
