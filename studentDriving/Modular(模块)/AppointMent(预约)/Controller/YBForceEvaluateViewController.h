//
//  YBForceEvaluateViewController.h
//  studentDriving
//
//  Created by JiangangYang on 16/2/20.
//  Copyright © 2016年 jatd. All rights reserved.
//  强制评价

#import "YBBaseViewController.h"

typedef void (^moreBlock)();
typedef void (^commitBlock)();

@class RatingBar;

@interface YBForceEvaluateViewController : YBBaseViewController

@property (nonatomic,copy) moreBlock moteblock;

@property (nonatomic,copy) moreBlock commitBlock;

@property (nonatomic,strong) RatingBar *starBar;

@property (nonatomic,strong) UITextView *reasonTextView;

@property (nonatomic,copy) NSString *iconURL;

@end

