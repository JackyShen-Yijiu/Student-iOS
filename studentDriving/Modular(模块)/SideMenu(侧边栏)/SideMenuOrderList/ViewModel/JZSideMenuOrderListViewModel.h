//
//  JZSideMenuOrderListViewModel.h
//  studentDriving
//
//  Created by ytzhang on 16/4/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+DVVBaseViewModel.h"
#import "JZSideMenuOrderListData.h"



@interface JZSideMenuOrderListViewModel : NSObject

@property (nonatomic, copy) NSString *coachID;

@property (nonatomic, strong) NSMutableArray *listDataArray;

@end
