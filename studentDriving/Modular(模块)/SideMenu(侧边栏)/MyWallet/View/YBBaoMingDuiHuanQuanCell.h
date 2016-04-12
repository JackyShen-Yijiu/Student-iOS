//
//  YBBaoMingDuiHuanQuanCell.h
//  studentDriving
//
//  Created by JiangangYang on 16/2/26.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBBaoMingDuiHuanQuanCell : UITableViewCell
@property (nonatomic,strong) NSDictionary *dictModel;
///  二维码图片
@property (weak, nonatomic) IBOutlet UIImageView *QRcodeImage;
///  兑换券名称
@property (weak, nonatomic) IBOutlet UILabel *ticketNameLabel;
///  消费日期
@property (weak, nonatomic) IBOutlet UILabel *spendDateLabel;
///  钱
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
///  使用限制备注
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;

@end
