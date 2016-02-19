//
//  WMMenuTableViewCell.m
//  QQSlideMenu
//
//  Created by wamaker on 15/6/12.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

#import "WMMenuTableViewCell.h"

@implementation WMMenuTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setCellText:(NSString *)str imageStr:(NSString *)imageStr{
    self.textLabel.text = str;
    self.textLabel.font = [UIFont systemFontOfSize:12];
    self.textLabel.textColor = [UIColor blackColor];
//    CGRectMake(0, 0, 24, 24);
    self.imageView.image = [UIImage imageNamed:imageStr];
    
 
}


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"menu";
    
    WMMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WMMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor whiteColor];
        
    }
    
    return cell;
}

@end
