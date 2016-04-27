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
        _timeLabel.textColor = JZ_FONTCOLOR_LIGHT;
        _contentLabel.textColor = JZ_FONTCOLOR_DRAK;
        if (YBIphone6Plus) {
            
            self.timeLabel.height = 12 * YBRatio;
            self.timeLabel.font = [UIFont systemFontOfSize:12 * YBRatio];
            
            self.contentLabel.height = 12 * YBRatio;
            self.contentLabel.font = [UIFont systemFontOfSize:12 * YBRatio];
            
        }
 
        
        
        
        
        
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    _starView.frame = CGRectMake(16, 14, 94, 12);
    _lineImageView.frame = CGRectMake(0, size.height - 0.5, size.width, 0.5);
}

- (void)refreshData:(DVVCoachCommentDMData *)dmData {
    
    
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
    if (dmData.comment.starlevel) {
        [_starView setUpRating:dmData.comment.starlevel];
    }else{
        [_starView setUpRating:0];
    }
    

}

+ (CGFloat)dynamicHeight:(DVVCoachCommentDMData *)dmData {
    
    NSString *commentcontent = dmData.comment.commentcontent;
    if (!commentcontent || !commentcontent.length) {
        commentcontent = @"未填写评论内容";
    }
    CGFloat fontSize = 12;
    if (YBIphone6Plus) {
        fontSize = 12 * YBRatio;
    }
    CGFloat testHeight = [NSString autoHeightWithString:commentcontent width:[UIScreen mainScreen].bounds.size.width - 32 font:[UIFont systemFontOfSize:fontSize]];
    return 14 + 14 + 12 + 16 + testHeight;
}

- (RatingBar *)starView {
    if (!_starView) {
        _starView = [RatingBar new];
        [_starView setImageDeselected:@"YBAppointMentDetailsstar.png" halfSelected:nil fullSelected:@"YBAppointMentDetailsstar_fill.png" andDelegate:nil];
       
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
