//
//  ShowWarningMessageView.h
//  studentDriving
//
//  Created by 胡东苑 on 16/2/17.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowWarningMessageView : UIView
@property (nonatomic, assign) BOOL isShowWarningMessage;

@property (nonatomic,copy) NSString *message;

- (UIView *)initWithFrame:(CGRect)frame titile:(NSString *)titile;

@end
