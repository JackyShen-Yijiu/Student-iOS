//
//  YBJiangliJifenCell.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/26.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBJiangliJifenCell.h"

@interface YBJiangliJifenCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@end

@implementation YBJiangliJifenCell

// 奖励积分
- (void)setJianglijifenModel:(NSDictionary *)jianglijifenModel
{
    _jianglijifenModel = jianglijifenModel;
    
    NSLog(@"_jianglijifenModel:%@",_jianglijifenModel);

    self.titleLabel.text = [self getTitle:[_jianglijifenModel[@"type"] integerValue]];

    self.timeLabel.text = [NSString getYearLocalDateFormateUTCDate:[NSString stringWithFormat:@"%@",_jianglijifenModel[@"createtime"]]];
    
    self.detailLabel.text = [NSString stringWithFormat:@"+%@积分",_jianglijifenModel[@"amount"]];
    
//    "createtime": "2015-11-09T12:39:36.624Z",
//    "amount": -5000,
//    "type": 3,
//    "seqindex": 36
//  { "createtime": "2015-11-09T12:39:36.624Z", 订单时间 "amount": -5000, 金额 "type": 3, 类型 //1 注册发放 2 邀请好友发放 3 购买商品zhichu3 "seqindex": 36 序号 }
    
}

- (NSString *)getTitle:(NSInteger)type
{
    if (type==1) {
        return @"注册发放";
    }else if (type==2){
        return @"邀请好友发放";
    }else if (type==3){
        return @"购买商品支出";
    }
    return @"";
}

// 可取现金额
- (void)setKequxianjineduModel:(NSDictionary *)kequxianjineduModel
{
    _kequxianjineduModel = kequxianjineduModel;
    
    NSLog(@"_kequxianjineduModel:%@",_kequxianjineduModel);
    
    // // 0 支出 1 报名奖励 2 邀请奖励 3 下线分红
    self.titleLabel.text = [self getKequxianjinedTitle:[_jianglijifenModel[@"type"] integerValue]];
    
    self.timeLabel.text = [NSString getYearLocalDateFormateUTCDate:[NSString stringWithFormat:@"%@",_jianglijifenModel[@"createtime"]]];
    
    self.detailLabel.text = [NSString stringWithFormat:@"%@元",_jianglijifenModel[@"income"]];
    
//    "createtime": "",
//    " type": "0",
//    "income": "50"
    
}

- (NSString *)getKequxianjinedTitle:(NSInteger)type
{
    if (type==0) {
        return @"支出";
    }else if (type==1){
        return @"报名奖励";
    }else if (type==2){
        return @"邀请奖励";
    }else if (type==3){
        return @"下线分红";
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
