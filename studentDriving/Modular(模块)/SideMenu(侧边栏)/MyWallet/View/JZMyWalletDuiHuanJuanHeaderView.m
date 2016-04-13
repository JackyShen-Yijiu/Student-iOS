//
//  JZMyWalletDuiHuanJuanHeaderView.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZMyWalletDuiHuanJuanHeaderView.h"
#define kLKSize [UIScreen mainScreen].bounds.size
static NSString *duiHuanJuanHeaderViewID = @"duiHuanJuanHeaderViewID";
@implementation JZMyWalletDuiHuanJuanHeaderView

+ (instancetype)duiHuanJuanHeaderViewWithTableView:(UITableView *)tableView withTag:(NSInteger)tag {
    
    
    JZMyWalletDuiHuanJuanHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:duiHuanJuanHeaderViewID];
    
    if (!headerView) {
        headerView = [[JZMyWalletDuiHuanJuanHeaderView alloc] initWithReuseIdentifier:duiHuanJuanHeaderViewID];
    }
    
    return headerView;
    
}



-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self = [[NSBundle mainBundle]loadNibNamed:@"JZMyWalletDuiHuanJuanHeaderView" owner:self options:nil].lastObject;
        
    }
    
    return self;
}


@end
