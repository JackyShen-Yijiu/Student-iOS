//
//  CancelAppointmentCell.m
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "CancelAppointmentCell.h"

@interface CancelAppointmentCell ()
@property (strong, nonatomic) UIView *backGroundView;
@property (strong, nonatomic) NSMutableArray *bntArray;
@property (nonatomic,strong) NSMutableArray *labelArray;
@end
@implementation CancelAppointmentCell

- (NSMutableArray *)bntArray {
    if (_bntArray == nil) {
        _bntArray = [[NSMutableArray alloc] init];
    }
    return _bntArray;
}
- (NSMutableArray *)labelArray
{
    if (_labelArray == nil) {
        _labelArray = [[NSMutableArray alloc] init];
    }
    return _labelArray;
}
- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 160)];
    }
    return _backGroundView;
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
    
    NSArray *titleArray = @[@"临时有事无法参加",@"预约错教练",@"调整了练车时间",@"其他"];
    for (NSUInteger i = 0; i<4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15, 10+(15+20)*i, 15, 15);
        [button setBackgroundImage:[UIImage imageNamed:@"ic_appointment_selected_no"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"ic_appointment_selected_yes"] forState:UIControlStateSelected];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bntArray addObject:button];
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+15+10, 10+(15+20)*i, kSystemWide/2, 15)];
        contentLabel.userInteractionEnabled = YES;
        contentLabel.textColor = [UIColor blackColor];
        contentLabel.font = [UIFont systemFontOfSize:14];
        contentLabel.text = titleArray[i];
        contentLabel.tag = 100 + i;
        [self.labelArray addObject:contentLabel];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)];
        [contentLabel addGestureRecognizer:tap];
        [self.backGroundView addSubview:button];
        [self.backGroundView addSubview:contentLabel];
    }
    
}

//    [self.backGroundView viewWithTag:<#(NSInteger)#>] 通过tag值取view


- (void)didClick:(UIButton *)btn
{
    for (UIButton *b in self.bntArray) {
        b.selected = NO;
        if (btn.tag == b.tag) {
            b.selected = YES;
            for (UILabel *label in self.labelArray) {
                if (label.tag == b.tag) {
                    if (!label.text) {


                        [self obj_showTotasViewWithMes:@"你还没有填写任何原因!"];

                        return;
                    }
                    if ([_delegate respondsToSelector:@selector(senderCancelMessage:)]) {
                        
                        [_delegate senderCancelMessage:label.text];
                    }
                }
            }
        }
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
    if (!contentLabel.text) {


        [self obj_showTotasViewWithMes:@"你还没有填写任何原因!"];

        return;
    }
    if ([_delegate respondsToSelector:@selector(senderCancelMessage:)]) {
        [_delegate senderCancelMessage:contentLabel.text];
    }
}
@end
