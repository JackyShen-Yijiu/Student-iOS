//
//  YBBaoMingDuiHuanQuanCell.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/26.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBBaoMingDuiHuanQuanCell.h"

@interface YBBaoMingDuiHuanQuanCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightTopLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightFootLabel;
@end

@implementation YBBaoMingDuiHuanQuanCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
