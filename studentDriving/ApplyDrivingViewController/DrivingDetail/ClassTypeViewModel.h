//
//  CourseViewModel.h
//  studentDriving
//
//  Created by 大威 on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVBaseViewModel.h"

@interface ClassTypeViewModel : DVVBaseViewModel

@property (nonatomic, copy) NSString *schoolID;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *heightArray;
@property (nonatomic, assign) CGFloat totalHeight;

@end
