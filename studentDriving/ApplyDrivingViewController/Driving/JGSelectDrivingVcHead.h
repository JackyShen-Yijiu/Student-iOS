//
//  JGSelectDrivingVcHead.h
//  studentDriving
//
//  Created by JiangangYang on 16/1/23.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^selectDriving) (NSInteger selectIndex);

@interface JGSelectDrivingVcHead : UIView

@property (nonatomic,copy) selectDriving selectDriving;

@end
