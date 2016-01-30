//
//  CoachListViewModel.h
//  studentDriving
//
//  Created by 大威 on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVBaseViewModel.h"

@interface CoachListViewModel : DVVBaseViewModel

@property (nonatomic, copy) NSString *schoolID;

@property (nonatomic, assign) NSUInteger index;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end
