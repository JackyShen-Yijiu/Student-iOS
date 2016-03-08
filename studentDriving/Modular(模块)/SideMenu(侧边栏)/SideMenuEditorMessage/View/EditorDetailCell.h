//
//  EditorDetailCell.h
//  studentDriving
//
//  Created by zyt on 16/2/23.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowWarningMessageView.h"





@interface EditorDetailCell : UITableViewCell
@property (nonatomic, strong) UILabel *toplabel;
@property (nonatomic, strong) UITextField *descriTextField;
@property (nonatomic, strong) ShowWarningMessageView *showWarningMessageView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tag:(NSInteger)tag;
@end
