//
//  WrongQuestionViewController.h
//  studentDriving
//
//  Created by bestseller on 15/10/26.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBWebBaseViewController.h"

@interface WrongQuestionViewController : YBWebBaseViewController

@property (copy, nonatomic) NSString *questionerrorurl;

@property (nonatomic,assign) BOOL isModal;

@end
