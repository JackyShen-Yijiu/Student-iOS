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
        
        [cell setRestorationIdentifier:reuseIdentifier];
        self = cell;
        
        [_showMoreButton addTarget:self action:@selector(showMoreButtonAction:) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}

#pragma mark 更多按钮按下的事件
- (void)showMoreButtonAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    _isShowMore = sender.selected;
    if (_isShowMore) {
        _showMoreImageView.image = [UIImage imageNamed:@"introduction_show_more_yes_icon"];
    }else {
        _showMoreImageView.image = [UIImage imageNamed:@"tableview_cell_detail_icon"];
    }
    if (_showMoreButtonTouchDown) {
        _showMoreButtonTouchDown(_isShowMore);
    }
}

- (void)refreshData:(DrivingDetailDMData *)dmData {
    
    _briefIntroductionLabel.text = dmData.introduction;
}

+ (CGFloat)dynamicHeight:(NSString *)string isShowMore:(BOOL)isShowMore {
    
    if (isShowMore) {
        return 8 + 21 + 8 + [NSString autoHeightWithString:string width:[UIScreen mainScreen].bounds.size.width - 8 * 2 font:[UIFont systemFontOfSize:14]] + 8;
    }else {
        return 95.f - 14;
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
