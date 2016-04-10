//
//  JZBusDetailStationModel.h
//  studentDriving
//
//  Created by ytzhang on 16/3/19.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZBusDetailStationModel : NSObject

/*
 "index": 1,
 "time": "6:00/10:30/15:30",
 "longitude": 116.55619,
 "latitude": 39.858907,
 "stationname": "上地站"
 */
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, assign) NSInteger longitude;
@property (nonatomic, assign) NSInteger latitude;
@property (nonatomic, strong) NSString *stationname;
@end
