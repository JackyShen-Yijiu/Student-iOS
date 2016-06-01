//
//  JZRecordViewModel.h
//  studentDriving
//
//  Created by ytzhang on 16/4/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+DVVBaseViewModel.h"
@interface JZRecordViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger count;

@end
