//
//  JZAppiontMessageBottomCell.h
//  studentDriving
//
//  Created by ytzhang on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JZAppointTimeBack <NSObject>

- (void)initWithTime:(NSString *)time timeTag:(NSInteger )timeTag;

@end

@interface JZAppiontMessageBottomCell : UITableViewCell
@property (strong, nonatomic) UIDatePicker *timePicker;

@property (strong, nonatomic) UITextField *textField;

@property (nonatomic, assign) NSInteger pickTag;

@property (nonatomic, strong) id <JZAppointTimeBack> JZAppointTimeBackDelegate;

@end
