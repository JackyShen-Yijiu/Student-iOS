//
//  JZPayWayFooterCell.h
//  studentDriving
//
//  Created by ytzhang on 16/3/15.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JZPayWayDelegate <NSObject>

- (void)initWithPayWay:(UIButton *)btn;

@end



@interface JZPayWayFooterCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *payWayIcon;
@property (weak, nonatomic) IBOutlet UILabel *payWayLabel;
@property (weak, nonatomic) IBOutlet UILabel *desPayWay;
@property (weak, nonatomic) IBOutlet UIButton *payWayButton;

@property (nonatomic, strong) NSString *imgStr;
@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, strong) NSString *desStr;

@property (nonatomic,weak) id<JZPayWayDelegate>delegate;

@end
