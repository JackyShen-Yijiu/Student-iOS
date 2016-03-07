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

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    if (selected) {
//        self.textLabel.textColor = [UIColor whiteColor];
//        
//    }else{
//         self.textLabel.textColor = [UIColor whiteColor];
//        self.imageView.image = [UIImage imageNamed:self.normalImageStr];
//    }
//}
- (void)setCellText:(NSString *)str withNormolImageStr:(NSString *)imageStr{
    self.normalImageStr = imageStr;
    self.textLabel.text = str;
    self.textLabel.textColor = [UIColor colorWithHexString:@"7b7b7b"];
    self.textLabel.font = [UIFont systemFontOfSize:14];
    if ([UIScreen mainScreen].bounds.size.height>=736) {
        self.textLabel.font = [UIFont systemFontOfSize:14*YBRatio];
    }
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
    
    CGFloat imgW = 16;
    CGFloat textLabelW = 100;
    CGFloat textLabelH = 14;
    if ([UIScreen mainScreen].bounds.size.height>=736) {
        imgW *= YBRatio;
        textLabelW *= YBRatio;
        textLabelH *= YBRatio;
    }
    
    self.imageView.frame = CGRectMake(24, self.contentView.height/2-imgW/2, imgW, imgW);
    self.textLabel.frame = CGRectMake(self.imageView.frame.origin.x + 16 + 24, self.contentView.height/2-textLabelH/2 , textLabelW, textLabelH);

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
