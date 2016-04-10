//
//  DVVPaySuccessViewModel.h
//  studentDriving
//
//  Created by 大威 on 16/3/2.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+DVVBaseViewModel.h"
#import "DVVPaySuccessDMRootClass.h"
#import "YYModel.h"

@interface DVVPaySuccessViewModel : NSObject

@property (nonatomic, copy) NSString *userID;

@property (nonatomic, strong) DVVPaySuccessDMData *dmData;

@end
