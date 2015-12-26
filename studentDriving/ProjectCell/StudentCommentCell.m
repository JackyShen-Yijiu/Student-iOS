//
//  StudentCommentCell.m
//  BlackCat
//
//  Created by bestseller on 15/9/29.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "StudentCommentCell.h"
#import "ToolHeader.h"
#import "StudentCommentModel.h"
@interface StudentCommentCell ()
@property (strong, nonatomic) UIView *backGroundView;

@property (strong, nonatomic) UIImageView *studentHeadImageView;
@property (strong, nonatomic) UILabel *studentNameLabel;
@property (strong, nonatomic) UILabel *commentTimeLabel;
@property (strong, nonatomic) UILabel *commentContentLabel;
@end
@implementation StudentCommentCell
- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 96)];
    }
    return _backGroundView;
}

- (UIImageView *)studentHeadImageView {
    if (_studentHeadImageView == nil) {
        _studentHeadImageView = [WMUITool initWithImage:nil];
        _studentHeadImageView.backgroundColor = MAINCOLOR;
    }
    return _studentHeadImageView;
}
- (UILabel *)studentNameLabel {
    if (_studentNameLabel == nil) {
        _studentNameLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont boldSystemFontOfSize:14]];
        _studentNameLabel.text = @"李文政";
        
    }
    return _studentNameLabel;
}
- (UILabel *)commentContentLabel {
    if (_commentContentLabel == nil) {
        _commentContentLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
        _commentContentLabel.numberOfLines = 2;
    }
    return _commentContentLabel;
}

- (UILabel *)commentTimeLabel {
    if (_commentTimeLabel == nil) {
        _commentTimeLabel = [WMUITool initWithTextColor:RGBColor(153, 153, 153) withFont:[UIFont systemFontOfSize:12]];
    }
    return _commentTimeLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    [self.contentView addSubview:self.backGroundView];
    
    [self.backGroundView addSubview:self.studentHeadImageView];
    
    [self.backGroundView addSubview:self.studentNameLabel];
    
    [self.backGroundView addSubview:self.commentTimeLabel];
    
    [self.backGroundView addSubview:self.commentContentLabel];
    
    [self.studentHeadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(13);
        make.height.mas_equalTo(@24);
        make.width.mas_equalTo(@24);
    }];
    
    [self.studentNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.studentHeadImageView.mas_right).offset(9);
        make.top.mas_equalTo(self.studentHeadImageView.mas_top).offset(2);
    }];
    
    [self.commentContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.studentHeadImageView.mas_right).offset(10);
        make.top.mas_equalTo(self.studentNameLabel.mas_bottom).offset(5);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide-30-24-10];
        make.width.mas_equalTo(wide);
    }];
    
    [self.commentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backGroundView.mas_right).offset(-15);
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(13);
    }];
}
- (void)receiveCommentMessage:(StudentCommentModel *)messageModel {
    [self resetContent];
    
    self.studentNameLabel.text = messageModel.userid.name;
    self.commentContentLabel.text = messageModel.comment.commentcontent;
    self.commentTimeLabel.text = [self dateFromISO8601String:messageModel.comment.commenttime];
    [self.studentHeadImageView sd_setImageWithURL:[NSURL URLWithString:messageModel.userid.headportrait.originalpic] placeholderImage:[UIImage imageNamed:@"littleImage.png"]];
}
- (void)resetContent {
    self.studentNameLabel.text = nil;
    self.commentContentLabel.text = nil;
    self.studentHeadImageView.image = nil;
}


- (NSString *)dateFromISO8601String:(NSString *)string {
    if (!string) return nil;
    
    struct tm tm;
    time_t t;
    
    strptime([string cStringUsingEncoding:NSUTF8StringEncoding], "%Y-%m-%dT%H:%M:%S%z", &tm);
    tm.tm_isdst = -1;
    t = mktime(&tm);
    
    //    return [NSDate dateWithTimeIntervalSince1970:t]; // 零时区
    NSDate * date =  [NSDate dateWithTimeIntervalSince1970:t + [[NSTimeZone localTimeZone] secondsFromGMT]];//东八区
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    
    return currentDateStr;
}

@end
