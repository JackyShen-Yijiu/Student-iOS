//
//  DVVSideMenuHeaderView.h
//  DVVSideMenu
//
//  Created by 大威 on 15/12/22.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVVSideMenuHeaderView : UIView

@property (nonatomic, strong) UIButton *iconButton;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *drivingNameLabel;
@property (nonatomic, strong) UILabel *markLabel;

@property (nonatomic, strong) UILabel *integralLabel;
@property (nonatomic, strong) UILabel *integralMarkLabel;
// 兑换券
@property (nonatomic, strong) UILabel *coinCertificateLabel;

@property(nonatomic, assign) CGFloat defaultHeight;

@end
