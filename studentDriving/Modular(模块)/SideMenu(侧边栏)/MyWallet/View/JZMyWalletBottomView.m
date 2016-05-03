//
//  JZMyWalletBottomView.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/13.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZMyWalletBottomView.h"
#define kLKSize [UIScreen mainScreen].bounds.size

@interface JZMyWalletBottomView ()
@property (nonatomic, assign) CGFloat fontSize14;

@property (nonatomic, assign) CGFloat fontSize12;


@end

@implementation JZMyWalletBottomView

-(instancetype)initWithFrame:(CGRect)frame {
    
    
    if (self = [super initWithFrame:frame]) {
        
        
        self = [[NSBundle mainBundle] loadNibNamed:@"JZMyWalletBottomView" owner:self options:nil].lastObject;
        
        self.frame = frame;
        _fontSize14 = 14;
        _fontSize12 = 12;
        if (YBIphone6Plus) {
            _fontSize14 = 14 * YBRatio;
            _fontSize12 = 12 * YBRatio;
        }

        _myYCodeLabel.font = [UIFont systemFontOfSize:_fontSize12];
        _inviteFriendBtn.titleLabel.font = [UIFont systemFontOfSize:_fontSize12];
    }
    
    return self;
}


@end
