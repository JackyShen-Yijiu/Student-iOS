//
//  ApplyClassCell.m
//  studentDriving
//
//  Created by 胡东苑 on 15/12/25.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "ApplyClassCell.h"

@interface ApplyClassCell ()

@property (strong, nonatomic) UIView  *applyClassView;

@end

@implementation ApplyClassCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)refreshUIWithArray:(NSArray *)dataArr {
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    self.userInteractionEnabled = YES;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 16, 80, 14)];
    label.text = @"报考班型:";
    label.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:label];
    NSInteger sum = 0;
    for (int i = 0; i<dataArr.count/2; i++) {
        for (int j = 0; j<2; j++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(80 + j*120,10 + 20*i + i*14, 110, 24)];
            [btn setTitle:dataArr[i*2+j] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            if (_btnTag == sum) {
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            btn.tag = i*2+j;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:btn];
            sum ++;
        }
    }
    NSInteger line = dataArr.count % 2;
    NSInteger i = dataArr.count/2;
    if (line == 1) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(80 ,10 + 20*i + i*14, 110, 24)];
        [btn setTitle: [dataArr lastObject] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (_btnTag == sum) {
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = dataArr.count-1;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
    }
}

- (void)btnClick:(UIButton *)btn {
//    for (UIView *view in self.contentView.subviews) {
//        if ([view isKindOfClass:[UIButton class]]) {
//            UIButton *button = (UIButton *)view;
//            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        }
//    }
//    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    if (_refresh) {
        _refresh(btn.tag);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
