//
//  CommentCell.m
//  BlackCat
//
//  Created by bestseller on 15/10/8.
//  Copyright © 2015年 lord. All rights reserved.
//


#import "CommentCell.h"
#import "ToolHeader.h"
@interface CommentCell ()
@property (strong, nonatomic) UIView *backGroundView;
@property (strong, nonatomic) NSIndexPath *indexPath;
@end
@implementation CommentCell

- (RatingBar *)starBar {
    if (_starBar == nil) {
        _starBar = [[RatingBar alloc] init];
        [_starBar setImageDeselected:@"starUnSelected30.png" halfSelected:nil fullSelected:@"starSelected30.png" andDelegate:self];
        _starBar.isIndicator = NO;
    }
    return _starBar;
}
- (UILabel *)topLabel {
    if (_topLabel == nil) {
        _topLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:16]];
        _topLabel.text = @"总体评价";
    }
    return _topLabel;
}
- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kSystemWide , 79)];
        _backGroundView.userInteractionEnabled = YES;
    }
    return _backGroundView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
 
    [self.contentView addSubview:self.backGroundView];
    
    [self.backGroundView addSubview:self.topLabel];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(14);
    }];
    [self.backGroundView addSubview:self.starBar];
    
    [self.starBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.topLabel.mas_bottom).offset(9);
        make.width.mas_equalTo(@150);
        make.height.mas_equalTo(@30);
    }];
}
- (void)receiveIndex:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
}

- (void)ratingChanged:(CGFloat)newRating {
    if ([_delegate respondsToSelector:@selector(senderStarProgress:withIndex:)]) {
        [_delegate senderStarProgress:newRating withIndex:self.indexPath];
    }
}

@end
