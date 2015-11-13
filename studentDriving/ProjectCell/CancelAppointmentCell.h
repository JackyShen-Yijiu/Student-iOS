//
//  CancelAppointmentCell.h
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CancelAppointmentCellDelegate <NSObject>

- (void)senderCancelMessage:(NSString *)message;

@end
@interface CancelAppointmentCell : UITableViewCell
@property (weak, nonatomic) id<CancelAppointmentCellDelegate>delegate;
@end
