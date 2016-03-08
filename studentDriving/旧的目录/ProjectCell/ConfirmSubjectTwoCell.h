//
//  ConfirmSubjectTwoCell.h
//  studentDriving
//
//  Created by bestseller on 15/10/29.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ConfirmSubjectTwoCellDelegate <NSObject>

- (void)senderCancelMessage:(NSString *)message;

@end
@interface ConfirmSubjectTwoCell : UITableViewCell
@property (weak, nonatomic) id<ConfirmSubjectTwoCellDelegate>delegate;

@end
