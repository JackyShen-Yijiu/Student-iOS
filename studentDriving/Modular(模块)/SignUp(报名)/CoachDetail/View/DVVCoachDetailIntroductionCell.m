//
//  DVVCoachDetailIntroductionCell.m
//  studentDriving
//
//  Created by 大威 on 16/2/20.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVCoachDetailIntroductionCell.h"
#import "NSString+Helper.h"

@implementation DVVCoachDetailIntroductionCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"DVVCoachDetailIntroductionCell" owner:self options:nil];
        DVVCoachDetailIntroductionCell *cell = xibArray.firstObject;
        self = cell;
        [self setRestorationIdentifier:reuseIdentifier];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (YBIphone6Plus) {
            _introductionLabel.height = 14 * YBRatio;
            _introductionLabel.font = [UIFont systemFontOfSize:14 * YBRatio];
        }
//        _introductionLabel.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)refreshData:(DVVCoachDetailDMData *)dmData {
    if (dmData.introduction && dmData.introduction.length) {
        _introductionLabel.text = dmData.introduction;
//        NSLog(@"%@", dmData.introduction);
    }else {
        _introductionLabel.text = @"暂无教练简介";
    }
}

+ (CGFloat)dynamicHeight:(DVVCoachDetailDMData *)dmData
              isShowMore:(BOOL)isShowMore {
    CGFloat fontSize = 14;
    if (YBIphone6Plus) {
        fontSize = 14 * YBRatio;
    }
    
    CGFloat height = [NSString autoHeightWithString:dmData.introduction width:[UIScreen mainScreen].bounds.size.width - 56 - 16 font:[UIFont systemFontOfSize:fontSize]];
    
    if (height < 36) {
        return 50;
    }else {
        if (isShowMore) {
            return 16 + height + 1 + 24;
        }else {
            return 52 + 24;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
