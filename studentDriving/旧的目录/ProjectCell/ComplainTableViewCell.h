//
//  ComplainTableViewCell.h
//  studentDriving
//
//  Created by bestseller on 15/10/29.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ComplainTableViewCellDelegate <NSObject>

- (void)senderCancelMessage:(NSString *)message;

@end
@interface ComplainTableViewCell : UITableViewCell
@property (weak, nonatomic) id<ComplainTableViewCellDelegate>delegate;

@property (strong, nonatomic) NSMutableArray *bntArray;
@property (strong, nonatomic) NSMutableArray *titleArray;

@end
