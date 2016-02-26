//
//  YBIntegrationMessageCell.h
//  studentDriving
//
//  Created by zyt on 16/2/25.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowWarningMessageView.h"
@interface YBIntegrationMessageCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tag:(NSInteger)tag;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *describleTextField;
@property (nonatomic, strong) ShowWarningMessageView *showWarningMessageView;
@end
