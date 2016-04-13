//
//  JZMyWalletJiFenView.h
//  studentDriving
//
//  Created by 雷凯 on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZMyWalletJiFenCell.h"
@interface JZMyWalletJiFenView : UITableView

@property (nonatomic, weak) JZMyWalletJiFenCell *jiFenCell;
@property (nonatomic, strong) NSMutableArray *jifenArrM;

@end
