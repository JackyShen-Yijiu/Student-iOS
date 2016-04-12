//
//  JZJiFenHeaderView.h
//  studentDriving
//
//  Created by 雷凯 on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZMyWalletHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIButton *howDoBtn;

@property (weak, nonatomic) IBOutlet UILabel *headerNumLabel;

@property (weak, nonatomic) IBOutlet UIButton *goToOthersBtn;
@property (weak, nonatomic) IBOutlet UIButton *jiFenBtn;
@property (weak, nonatomic) IBOutlet UIButton *duiHuanJuanBtn;
@property (weak, nonatomic) IBOutlet UIButton *xianJinBtn;
///  滚动条
@property (weak, nonatomic) IBOutlet UIView *rollLineView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;

@end
