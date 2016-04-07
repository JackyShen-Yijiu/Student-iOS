//
//  DVVCoachCommentViewModel.h
//  studentDriving
//
//  Created by 大威 on 16/2/23.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+DVVBaseViewModel.h"
#import "DVVCoachCommentDMRootClass.h"

@interface DVVCoachCommentViewModel : NSObject

@property (nonatomic, copy) NSString *coachID;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *heightArray;

@property (nonatomic, assign) NSUInteger index;

@end
