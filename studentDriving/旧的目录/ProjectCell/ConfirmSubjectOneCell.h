//
//  ConfirmSubjectOneCell.h
//  studentDriving
//
//  Created by bestseller on 15/10/29.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ConfirmSubjectOneCellDelegate <NSObject>

- (void)senderCancelMessage:(NSString *)message;

@end
@interface ConfirmSubjectOneCell : UITableViewCell
@property (weak, nonatomic) id<ConfirmSubjectOneCellDelegate>delegate;

@end
