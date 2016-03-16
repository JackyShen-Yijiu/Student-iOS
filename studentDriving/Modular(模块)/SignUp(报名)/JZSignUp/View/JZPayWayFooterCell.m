//
//  JZPayWayFooterCell.m
//  studentDriving
//
//  Created by ytzhang on 16/3/15.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZPayWayFooterCell.h"

@implementation JZPayWayFooterCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"JZPayWayFooterCell" owner:self options:nil];
        self = xibArray.firstObject;
        
        [self setRestorationIdentifier:reuseIdentifier];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _payWayButton.backgroundColor = [UIColor clearColor];
        [_payWayButton setImage:[UIImage imageNamed:@"pay_off"] forState:UIControlStateNormal];
        [_payWayButton setImage:[UIImage imageNamed:@"pay_on"] forState:UIControlStateSelected];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (IBAction)didPayWay:(id)sender {
    if ([self.delegate respondsToSelector:@selector(initWithPayWay:)]) {
        [self.delegate initWithPayWay:sender];
    }
}

@end
