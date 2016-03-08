//
//  Myreservation MyReservationCell.h
//  BlackCat
//
//  Created by bestseller on 15/10/2.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>



@class MyAppointmentModel;
@interface MyReservationCell : UITableViewCell
- (void)receiveDataModel:(MyAppointmentModel *)myModel;
@end
