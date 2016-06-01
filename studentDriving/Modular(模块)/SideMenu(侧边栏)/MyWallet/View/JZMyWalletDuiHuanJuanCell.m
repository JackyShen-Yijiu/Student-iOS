//
//  JZMyWalletDuiHuanJuanCell.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZMyWalletDuiHuanJuanCell.h"
static NSString *duiHuanJuanDetailCellID = @"duiHuanJuanDetailCellID";
@implementation JZMyWalletDuiHuanJuanCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[NSBundle mainBundle]loadNibNamed:@"JZMyWalletDuiHuanJuanCell" owner:self options:nil].lastObject;
    }
    
    return self;
}

@end
