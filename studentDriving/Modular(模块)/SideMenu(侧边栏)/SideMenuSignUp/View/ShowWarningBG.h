//
//  ShowWarningBG.h
//  studentDriving
//
//  Created by zyt on 16/2/22.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowWarningBG : UIView
{
    __weak UIViewController * _controller;
}

- (instancetype)initWithTietleName:(NSString *)titleName;
- (void)show;
- (void)hidden;
@end
