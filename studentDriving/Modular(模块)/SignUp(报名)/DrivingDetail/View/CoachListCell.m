//
//  CoachListCell.m
//  studentDriving
//
//  Created by 大威 on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "CoachListCell.h"


@interface CoachListCell ()


@end

@implementation CoachListCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"CoachListCell" owner:self options:nil];
        CoachListCell *cell = xibArray.firstObject;
        self = cell;
        [cell setRestorationIdentifier:reuseIdentifier];
        
        [self.contentView addSubview:self.starBar];
        [self.contentView addSubview:self.lineImageView];
        
        [_iconImageView.layer setMasksToBounds:YES];
        [_iconImageView.layer setCornerRadius:20];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    _starBar.frame = CGRectMake(size.width - 75 - 16, 16, 75, 14);
    CGFloat minX = CGRectGetMinX(_nameLabel.frame);
    _lineImageView.frame = CGRectMake(minX, size.height - 0.5, size.width - minX - 16, 0.5);
}

- (void)refreshData:(CoachListDMData *)dmData {
    
   [_starBar setImageDeselected:@"YBAppointMentDetailsstar.png" halfSelected:nil fullSelected:@"YBAppointMentDetailsstar_fill.png" andDelegate:nil];
    CGFloat starLevel = 0;
    if (dmData.starlevel) {
        starLevel = dmData.starlevel;
    }
    [self.starBar displayRating:starLevel];
    if (dmData.headportrait.originalpic && dmData.headportrait.originalpic.length) {
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dmData.headportrait.originalpic]]];
    }else {
        NSString *imageName = @"coach_man_default_icon";
        if (dmData.gender && dmData.gender.length) {
            if ([dmData.gender isEqualToString:@"女"]) {
                imageName = @"coach_woman_default_icon";
            }
        }
        _iconImageView.image = [UIImage imageNamed:imageName];
    }
    
    _nameLabel.text = dmData.name;
    
    if (dmData.seniority) {
        _seniorityLabel.text = [NSString stringWithFormat:@"%@年教龄", dmData.seniority];
    }else {
        _seniorityLabel.text = @"暂无教龄";
    }
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in dmData.subject) {
        
        CoachListDMSubject *dmSubject = [CoachListDMSubject yy_modelWithDictionary:dict];
        [array addObject:dmSubject.name];
    }
    
    if (dmData.passrate) {
        _passRateLabel.text = [NSString stringWithFormat:@"通过率%li%%", dmData.passrate];
    }else {
        _passRateLabel.text = @"暂无通过率";
    }
    
    if (!array.count) {
        _subjectLabel.text = @"未填写科目信息";
    }else {
        _subjectLabel.text = [array componentsJoinedByString:@" "];
    }
    
    if (dmData.commentcount) {
        _commentsLabel.text = [NSString stringWithFormat:@"%li条评论", dmData.commentcount];
    }else {
        _commentsLabel.text = @"暂无评论";
    }
}

- (RatingBar *)starBar{
    if (_starBar == nil) {
        _starBar = [[RatingBar alloc] init];
        [_starBar setUpRating:3];
    }
    return _starBar;
}

- (UIImageView *)lineImageView {
    if (!_lineImageView) {
        _lineImageView = [UIImageView new];
        _lineImageView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    }
    return _lineImageView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
