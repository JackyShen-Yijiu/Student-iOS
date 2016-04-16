//
//  PageTableViewCell.m
//  ScollViewPage
//
//  Created by allen on 15/9/18.
//  Copyright (c) 2015年 Allen. All rights reserved.
//

#import "PageTableViewCell.h"

@implementation PageTableViewCell

- (void)awakeFromNib {
    
    self.textcontent.textColor = [UIColor colorWithHexString:@"2f2f2f"];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
