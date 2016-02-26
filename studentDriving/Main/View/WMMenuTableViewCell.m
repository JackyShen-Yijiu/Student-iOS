//
//  WMMenuTableViewCell.m
//  QQSlideMenu
//
//  Created by wamaker on 15/6/12.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

#import "WMMenuTableViewCell.h"

@interface WMMenuTableViewCell ()
@property (nonatomic,strong) NSString *normalImageStr;
@end

@implementation WMMenuTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        self.textLabel.textColor = [UIColor whiteColor];
        
    }else{
         self.textLabel.textColor = [UIColor whiteColor];
        self.imageView.image = [UIImage imageNamed:self.normalImageStr];
    }
}
- (void)setCellText:(NSString *)str withNormolImageStr:(NSString *)imageStr{
    self.normalImageStr = imageStr;
    self.textLabel.text = str;
    self.textLabel.font = [UIFont systemFontOfSize:12];
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
- (void)layoutSubviews{
    self.imageView.frame = CGRectMake(20, 10, 24, 24);
    self.textLabel.frame = CGRectMake(self.imageView.frame.origin.x + 24 + 30, self.imageView.frame.origin.y + 5, 100, 12);

}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//    
//    if (selected) {
//        self.textLabel.textColor = LightRedColor;
//    }else
//    {
//        self.textLabel.textColor = App_BackgroundColor;
//    }
//    
//    // Configure the view for the selected state
//}
@end
