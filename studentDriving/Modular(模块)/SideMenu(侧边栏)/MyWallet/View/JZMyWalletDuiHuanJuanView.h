//
//  JZMyWalletDuiHuanJuanView.h
//  studentDriving
//
//  Created by 雷凯 on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZMyWalletDuiHuanJuanData.h"
#import "JZMyWalletDuiHuanJuanHeaderView.h"
#import "JZMyWalletDuiHuanJuanCell.h"
@interface JZMyWalletDuiHuanJuanView : UITableView

@property (nonatomic, strong) JZMyWalletDuiHuanJuanData *dataModel;


@property (nonatomic, weak) JZMyWalletDuiHuanJuanHeaderView *duiHuanJuanHeaerView;
@property (nonatomic, weak) JZMyWalletDuiHuanJuanCell *duiHuanJuanCell;
@property (nonatomic, strong) NSMutableArray *duiHuanJuanDataArrM;

@end

