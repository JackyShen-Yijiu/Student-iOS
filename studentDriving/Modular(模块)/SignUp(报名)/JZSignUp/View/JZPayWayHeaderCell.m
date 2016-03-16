//
//  JZPayWayHeaderCell.m
//  studentDriving
//
//  Created by ytzhang on 16/3/15.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZPayWayHeaderCell.h"

@implementation JZPayWayHeaderCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"JZPayWayHeaderCell" owner:self options:nil];
        JZPayWayHeaderCell *cell = xibArray.firstObject;
        self = cell;
        [self setRestorationIdentifier:reuseIdentifier];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (void)setDmdata:(ClassTypeDMData *)dmdata{
    
    self.driveIconImageView.image = [UIImage imageNamed:@"background_mine"];
    self.driveName.text = dmdata.schoolinfo.name;
    
    NSString *addressStr = nil;
    if (dmdata.schoolinfo.address == nil || [dmdata.schoolinfo.address isEqualToString:@""]) {
        addressStr = @"暂无";
    }else {
        addressStr = dmdata.schoolinfo.address;
    }

    self.address.text = [NSString stringWithFormat:@"地址:%@",addressStr];

    NSString *coachStr = nil;
    if (dmdata.coachName == nil || [dmdata.coachName isEqualToString:@""]) {
        coachStr = @"暂无";
    }else {
        coachStr = dmdata.coachName;
    }
    self.coachName.text = [NSString stringWithFormat:@"报考教练:%@",coachStr];
}
- (void)setExtraDict:(NSDictionary *)extraDict{
    /* _extraDict = {
     "__v": 0,
     "paymoney": 4700,
     //支付金额"payendtime": "2016-02-03T12:29:49.423Z",
     "creattime": "2016-01-31T12:29:49.423Z",
     "userid": "564e1242aa5c58b901e4961a",
     "_id": "56adfe3d323ed17278e71914",
     订单id"discountmoney": 0,
     "applyclasstypeinfo": {
     "onsaleprice": 4700,
     "price": 4700,
     "name": "一步互联网驾校快班",
     "id": "562dd1fd1cdf5c60873625f3"
     },
     "applyschoolinfo": {
     "name": "一步互联网驾校",
     "id": "562dcc3ccb90f25c3bde40da"
     },
     "paychannel": 0,
     userpaystate": 0订单状态//0订单生成1开始支付2支付成功3支付失败4订单取消 //支付方式"
     }
     */
    self.driveIconImageView.image = [UIImage imageNamed:@"background_mine"];
    self.driveName.text = extraDict[@"applyschoolinfo"][@"name"];
    
    NSString *addressStr = nil;
    if (extraDict[@"applyschoolinfo"][@"address"] == nil || [extraDict[@"applyschoolinfo"][@"address"] isEqualToString:@""]) {
        addressStr = @"暂无";
    }else {
        addressStr = extraDict[@"applyschoolinfo"][@"address"];
    }
    
    self.address.text = [NSString stringWithFormat:@"地址:%@",addressStr];
    
    NSString *coachStr = nil;
    if (extraDict[@"applyschoolinfo"][@"address"] == nil || [extraDict[@"applyschoolinfo"][@"address"] isEqualToString:@""]) {
        coachStr = @"暂无";
    }else {
        coachStr = extraDict[@"applyschoolinfo"][@"address"];
    }
    self.coachName.text = [NSString stringWithFormat:@"报考教练:%@",coachStr];
}
@end
