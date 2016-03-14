//
//  YBForceEvaluateViewController.h
//  studentDriving
//
//  Created by JiangangYang on 16/2/20.
//  Copyright © 2016年 jatd. All rights reserved.
//  强制评价

#import "YBBaseViewController.h"
#import "YBTextView.h"

typedef void (^moreBlock)();
typedef void (^commitBlock)();

@class RatingBar;

@interface YBForceEvaluateViewController : YBBaseViewController

@property (nonatomic,copy) moreBlock moteblock;

@property (nonatomic,copy) commitBlock commitBlock;

@property (nonatomic,strong) RatingBar *starBar;

@property (nonatomic,strong)  YBTextView *reasonTextView;

@property (nonatomic,copy) NSString *iconURL;

@property (nonatomic,copy) NSString *nameStr; // 教练姓名

@end

