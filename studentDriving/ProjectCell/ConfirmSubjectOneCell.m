//
//  CancelAppointmentCell.m
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "ConfirmSubjectOneCell.h"
#import "ToolHeader.h"
@interface ConfirmSubjectOneCell ()
@property (strong, nonatomic) UIView *backGroundView;
@property (strong, nonatomic) UILabel *cancelTitle;
@property (strong, nonatomic) NSMutableArray *bntArray;
@property (strong, nonatomic) NSMutableArray *titleArray;

@end
@implementation ConfirmSubjectOneCell

- (NSMutableArray *)bntArray {
    if (_bntArray == nil) {
        _bntArray = [[NSMutableArray alloc] init];
    }
    return _bntArray;
}
- (NSMutableArray *)titleArray {
    if (_titleArray == nil) {
        _titleArray = [[NSMutableArray alloc] init];
    }
    return _titleArray;
}
- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 200)];
    }
    return _backGroundView;
}
- (UILabel *)cancelTitle {
    if (_cancelTitle == nil) {
        _cancelTitle = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
        _cancelTitle.text = @"科目二内容";
    }
    return _cancelTitle;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}
- (void)setUp{
    
    
    
    [self.contentView addSubview:self.backGroundView];
    self.backGroundView.userInteractionEnabled = YES;
    [self.backGroundView addSubview:self.cancelTitle];
    
    [self.cancelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(20);
    }];
    
    NSArray *titleArray = @[@"起步停车",@"曲线行驶",@"倒车入库",@"坡道定点起步、停车",@"直角转弯",@"综合练习",@"侧方停车",@"其他"];
    for (NSUInteger i = 0; i<8; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i % 2 == 0) {
            button.frame = CGRectMake(15, 60+(15)*i, 15, 15);
        }else {
            button.frame = CGRectMake(kSystemWide/2, 60+(15)*(i-1), 15, 15);
        }
        [button setBackgroundImage:[UIImage imageNamed:@"cancelSelect.png"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"cancelSelect_click.png"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(dealButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + i;
        
        [self.bntArray addObject:button];
        UILabel *contentLabel = [[UILabel alloc] init];
        if (i % 2 == 0) {
            contentLabel.frame = CGRectMake(15+15+10, 60+(15)*i, (kSystemWide/2)-15, 15);
        }else {
            contentLabel.frame = CGRectMake((kSystemWide/2)+15+10, 60+(15)*(i-1), (kSystemWide/2)-15, 15);
            
        }
        
        contentLabel.userInteractionEnabled = YES;
        contentLabel.textColor = [UIColor blackColor];
        contentLabel.font = [UIFont systemFontOfSize:14];
        contentLabel.text = titleArray[i];
        contentLabel.tag = 100 + i;
        [self.titleArray addObject:contentLabel];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)];
        [contentLabel addGestureRecognizer:tap];
        [self.backGroundView addSubview:button];
        [self.backGroundView addSubview:contentLabel];
    }
    
}

//    [self.backGroundView viewWithTag:<#(NSInteger)#>] 通过tag值取view

- (void)dealButton:(UIButton *)sender {
    for (UIButton *b in self.bntArray) {
        b.selected = NO;
        if (b.tag == sender.tag) {
            b.selected = YES;
        }
    }
    UILabel *contentLabel = self.titleArray[sender.tag - 100];
    if ([_delegate respondsToSelector:@selector(senderCancelMessage:)]) {
        DYNSLog(@"content = %@",contentLabel.text);
        [_delegate senderCancelMessage:contentLabel.text];
    }
    
}


- (void)clickTap:(UITapGestureRecognizer *)tap {
    UILabel *contentLabel = (UILabel *)tap.view;
    for (UIButton *b in self.bntArray) {
        b.selected = NO;
        if (b.tag == contentLabel.tag) {
            b.selected = YES;
        }
    }
    if ([_delegate respondsToSelector:@selector(senderCancelMessage:)]) {
        [_delegate senderCancelMessage:contentLabel.text];
    }
}
@end
