//
//  JZMyWalletDuiHuanJuanHeaderView.h
//  studentDriving
//
//  Created by 雷凯 on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZMyWalletDuiHuanJuanHeaderView : UITableViewHeaderFooterView
///  兑换券二维码
@property (weak, nonatomic) IBOutlet UIImageView *QRCodeImg;
///  消费日期
@property (weak, nonatomic) IBOutlet UILabel *spendDateLabel;
///  兑换券详情（添加手势）
@property (weak, nonatomic) IBOutlet UIView *duiHuanJuanDetailView;
@property (weak, nonatomic) IBOutlet UIImageView *seeDetailImg;
@property (weak, nonatomic) IBOutlet UILabel *duiHuanJuanName;

///  创建tableView的headerView
+ (instancetype)duiHuanJuanHeaderViewWithTableView:(UITableView *)tableView withTag:(NSInteger)tag;
@end
