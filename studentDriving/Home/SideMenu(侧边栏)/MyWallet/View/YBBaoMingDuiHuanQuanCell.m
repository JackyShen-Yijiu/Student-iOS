//
//  YBBaoMingDuiHuanQuanCell.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/26.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBBaoMingDuiHuanQuanCell.h"

@interface YBBaoMingDuiHuanQuanCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightTopLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightFootLabel;
@end

@implementation YBBaoMingDuiHuanQuanCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"YBBaoMingDuiHuanQuanCell" owner:self options:nil];
        YBBaoMingDuiHuanQuanCell *cell = xibArray.firstObject;
        
        [cell setRestorationIdentifier:reuseIdentifier];
        self = cell;
    }
    return self;
}

- (void)setDictModel:(NSDictionary *)dictModel
{
    _dictModel = dictModel;
    NSLog(@"_dictModel:%@",_dictModel);
    
    self.titleLabel.text = [self getTitle:[_dictModel[@"state"] integerValue]];
    
    self.detailLabel.text = [NSString getYearLocalDateFormateUTCDate:[NSString stringWithFormat:@"%@",_dictModel[@"createtime"]]];

    self.rightTopLabel.text = @"兑换券单号";
    self.rightTopLabel.textColor = MAINCOLOR;
    
    self.rightFootLabel.text = [NSString stringWithFormat:@"%@",_dictModel[@"userid"]];
    self.rightFootLabel.textColor = MAINCOLOR;
    
//    {
//        "_id": "56812f877b340f4e48423164",
//        优惠卷编码"userid": "562cb02e93d4ca260b40e544",
//        userid"state": 0,
//        优惠卷状态//0未领取1领取2过期3作废4已消费"is_forcash": true,
//        是否可以兑换现金"couponcomefrom": 1,
//        //优惠券来源1报名奖励2活动奖励"createtime": "2015-12-28T12:48:07.805Z"
//    }
    
}

- (NSString *)getTitle:(NSInteger)type
{
    if (type==0) {
        return @"未领取";
    }else if (type==1){
        return @"领取";
    }else if (type==2){
        return @"过期";
    }else if (type==3){
        return @"作废";
    }else if (type==4){
        return @"已消费";
    }
    return @"";
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
