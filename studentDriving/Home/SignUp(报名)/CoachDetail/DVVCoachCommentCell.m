//
//  DVVCoachCommentCell.m
//  studentDriving
//
//  Created by 大威 on 16/2/23.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVCoachCommentCell.h"
#import "NSString+Helper.h"
#import "UIImageView+DVVWebImage.h"

@implementation DVVCoachCommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"DVVCoachCommentCell" owner:self options:nil];
        DVVCoachCommentCell *cell = xibArray.firstObject;
        self = cell;
        [self setRestorationIdentifier:reuseIdentifier];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.starView];
        [self.contentView addSubview:self.lineImageView];
        
        [_iconImageView.layer setMasksToBounds:YES];
        [_iconImageView.layer setCornerRadius:20];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    _starView.frame = CGRectMake(size.width - 94 - 16, 16, 94, 14);
    CGFloat minX = CGRectGetMinX(_nameLabel.frame);
    _lineImageView.frame = CGRectMake(minX, size.height - 0.5, size.width - minX - 16, 0.5);
}

- (void)refreshData:(DVVCoachCommentDMData *)dmData {
    
    NSString *originalpic = dmData.userid.headportrait.originalpic;
    if (originalpic && originalpic.length) {
        [_iconImageView dvv_downloadImage:originalpic];
    }else {
        NSString *imageName = @"coach_man_default_icon";
        if (dmData.userid.gender && dmData.userid.gender.length) {
            if ([dmData.userid.gender isEqualToString:@"女"]) {
                imageName = @"coach_woman_default_icon";
            }
        }
        _iconImageView.image = [UIImage imageNamed:imageName];
    }
    
    if (dmData.comment.commenttime && dmData.comment.commenttime) {
        _timeLabel.text = [NSString getLocalDateFormateUTCDate:dmData.comment.commenttime format:@"yyyy-MM-dd"];
    }else {
        _timeLabel.text = @"暂无评论时间";
    }
    
    NSString *commentcontent = dmData.comment.commentcontent;
    if (commentcontent && commentcontent.length) {
        _contentLabel.text = commentcontent;
    }else {
        _contentLabel.text = @"未填写评论内容";
    }
    
    NSString *classType = dmData.userid.applyclasstypeinfo.name;
    if (classType && classType.length) {
        _classTypeLabel.text = classType;
    }else {
        _classTypeLabel.text = @"暂无班型信息";
    }
    
    [_starView dvv_setStar:dmData.comment.starlevel];
}

+ (CGFloat)dynamicHeight:(DVVCoachCommentDMData *)dmData {
    
    NSString *commentcontent = dmData.comment.commentcontent;
    if (!commentcontent || !commentcontent.length) {
        commentcontent = @"未填写评论内容";
    }

    CGFloat testHeight = [NSString autoHeightWithString:commentcontent width:[UIScreen mainScreen].bounds.size.width - 72 - 16 font:[UIFont systemFontOfSize:14]];
    return 64 + testHeight + 16;
}

- (DVVStarView *)starView {
    if (!_starView) {
        _starView = [DVVStarView new];
        [_starView dvv_setBackgroundImage:@"star_all_default_icon" foregroundImage:@"star_all_icon" width:94 height:14];
    }
    return _starView;
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
