//
//  JZMyWalletJiFenCell.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZMyWalletJiFenCell.h"

@interface JZMyWalletJiFenCell ()

@property (nonatomic, assign) CGFloat fontSize14;

@property (nonatomic, assign) CGFloat fontSize12;

@end

@implementation JZMyWalletJiFenCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[NSBundle mainBundle]loadNibNamed:@"JZMyWalletJiFenCell" owner:self options:nil].lastObject;
    }
    
    _fontSize14 = 14;
    _fontSize12 = 12;
    if (YBIphone6Plus) {
        _fontSize14 = 14 * YBRatio;
        _fontSize12 = 12 * YBRatio;
    }
    _jiFenSourceLabel.font = [UIFont systemFontOfSize:_fontSize14];
    _jiFenDateLabel.font = [UIFont systemFontOfSize:_fontSize12];
    _jiFenNumLabel.font  = [UIFont systemFontOfSize:_fontSize14];

    
    return self;
}


@end
