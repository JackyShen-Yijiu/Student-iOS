//
//  ClassTypeCell.m
//  studentDriving
//
//  Created by 大威 on 16/1/29.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "ClassTypeCell.h"
#import "NSString+Helper.h"

@implementation ClassTypeCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"ClassTypeCell" owner:self options:nil];
        ClassTypeCell *cell = xibArray.firstObject;
        
        [cell setRestorationIdentifier:reuseIdentifier];
        self = cell;
    }
    return self;
}

- (void)refreshData:(ClassTypeDMData *)dmData {
    
    _nameLabel.text = dmData.classname;
    _introductionLabel.text = dmData.classdesc;
    _priceLabel.text = [NSString stringWithFormat:@"￥%zi", dmData.price];
}

+ (CGFloat)dynamicHeight:(NSString *)string {
    
    CGFloat newFloat = 8 + 21 + 8 + [NSString autoHeightWithString:string width:[UIScreen mainScreen].bounds.size.width - 8 * 2 font:[UIFont systemFontOfSize:14]] + 8 + 21 + 8 + 40 + 8;
    return newFloat;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
