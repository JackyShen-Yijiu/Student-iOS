//
//  ApplyClassCell.h
//  studentDriving
//
//  Created by 胡东苑 on 15/12/25.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplyClassCell : UITableViewCell

@property (copy,   nonatomic) void (^refresh)(NSInteger);
@property (assign, nonatomic) NSInteger btnTag; //那个是红色的；

- (void)refreshUIWithArray:(NSArray *)dataArr;

@end
