//
//  BLAVplayerCell.m
//  studentDriving
//
//  Created by bestseller on 15/11/4.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "BLAVplayerCell.h"

@interface BLAVplayerCell ()

@end
@implementation BLAVplayerCell

- (UIImageView *)backGroundImage {
    if (_backGroundImage == nil) {
        _backGroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,kSystemWide , 230)];
    }
    return _backGroundImage;
}
- (UIButton *)playButton {
    if (_playButton == nil) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setBackgroundImage:[UIImage imageNamed:@"playImage.png"] forState:UIControlStateNormal];
        [_playButton addTarget:self action:@selector(clickPlayButton:) forControlEvents:UIControlEventTouchUpInside];
        _playButton.backgroundColor = [UIColor redColor];
    }
    return _playButton;
}
- (UILabel *)AVdescribe {
    if (_AVdescribe == nil) {
        _AVdescribe = [WMUITool initWithTextColor:[UIColor whiteColor] withFont:[UIFont systemFontOfSize:24]];
        _AVdescribe.text = @"倒车入库";
        _AVdescribe.textAlignment = NSTextAlignmentCenter;
    }
    return _AVdescribe;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    
    [self.contentView addSubview:self.backGroundImage];
    
//    [self.backGroundImage addSubview:self.playButton];
    
//    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.backGroundImage.mas_left).offset(15);
//        make.bottom.mas_equalTo(self.backGroundImage.mas_bottom).offset(-22);
//        make.width.mas_equalTo(@22);
//        make.height.mas_equalTo(@22);
//    }];
    
    [self.backGroundImage addSubview:self.AVdescribe];
    [self.AVdescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundImage.mas_left).offset(0);
         make.right.mas_equalTo(self.backGroundImage.mas_right).offset(0);
        make.centerY.mas_equalTo(self.backGroundImage.mas_centerY);
        make.height.mas_equalTo(@24);
    }];
    
}
- (void)clickPlayButton:(UIButton *)sender {
    
}
@end
