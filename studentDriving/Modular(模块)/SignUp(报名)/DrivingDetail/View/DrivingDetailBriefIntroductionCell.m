//
//  DrivingDetailBriefIntroductionCell.m
//  studentDriving
//
//  Created by 大威 on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DrivingDetailBriefIntroductionCell.h"
#import "NSString+Helper.h"

@interface DrivingDetailBriefIntroductionCell ()

@property (weak, nonatomic) IBOutlet UIButton *showMoreButton;
@property (nonatomic, copy) ShowMoreButtonTouchDownBlock showMoreButtonTouchDown;

@end

@implementation DrivingDetailBriefIntroductionCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"DrivingDetailBriefIntroductionCell" owner:self options:nil];
        DrivingDetailBriefIntroductionCell *cell = xibArray.firstObject;
        self = cell;
        [cell setRestorationIdentifier:reuseIdentifier];
        
        [_showMoreButton addTarget:self action:@selector(showMoreButtonAction:) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}

#pragma mark 更多按钮按下的事件
- (void)showMoreButtonAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    _isShowMore = sender.selected;
    
    if (_showMoreButtonTouchDown) {
        _showMoreButtonTouchDown(_isShowMore);
    }
}

- (void)refreshData:(DrivingDetailDMData *)dmData {
    if (dmData.introduction && dmData.introduction.length) {
        _briefIntroductionLabel.text = dmData.introduction;
    }else {
        _briefIntroductionLabel.text = @"暂无驾校简介";
    }
//    _briefIntroductionLabel.backgroundColor = [UIColor redColor];
}

+ (CGFloat)dynamicHeight:(NSString *)string isShowMore:(BOOL)isShowMore {
    
    if (!string || !string.length) {
        string = @"暂无驾校简介";
    }
    CGFloat testHeight = [NSString autoHeightWithString:string width:[UIScreen mainScreen].bounds.size.width - 56 - 16 font:[UIFont systemFontOfSize:14]];
    
    if (isShowMore) {
        if (testHeight < 20) {
            testHeight = 24;
        }
        return 16 + testHeight + 8 + 1;
    }else {
        if (testHeight < 20) {
            testHeight = 24;
        }else {
            testHeight = 34;
        }
        return 16 + testHeight + 8 + 1;
    }
}

- (void)setShowMoreButtonTouchDownBlock:(ShowMoreButtonTouchDownBlock)handle {
    _showMoreButtonTouchDown = handle;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
