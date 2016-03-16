//
//	YBAppointMentDetailsDataData.h
//
//	Create by JiangangYang on 27/2/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "YBAppointMentDetailsDataCoachid.h"
#import "YBAppointMentDetailsDataSubject.h"
#import "YBAppointMentDetailsDataDriveschoolinfo.h"
#import "YBAppointMentDetailDataCancelReason.h"

@interface YBAppointMentDetailsDataData : NSObject

@property (nonatomic, strong) NSString * begintime;
@property (nonatomic, strong) NSString * classdatetimedesc;
@property (nonatomic, strong) YBAppointMentDetailsDataCoachid * coachid;
@property (nonatomic, strong) NSString * courseprocessdesc;
@property (nonatomic, strong) NSString * endtime;
@property (nonatomic, assign) BOOL isShuttle;
@property (nonatomic, strong) NSString * learningcontent;
@property (nonatomic, strong) NSString * reservationcreatetime;
@property (nonatomic, assign) NSInteger reservationstate;
@property (nonatomic, strong) NSString * shuttleaddress;
@property (nonatomic, strong) YBAppointMentDetailsDataSubject * subject;
@property (nonatomic, strong) YBAppointMentDetailsDataDriveschoolinfo * trainfieldlinfo;
@property (nonatomic, copy) NSString * sigintime;

// 取消原因
@property (nonatomic, strong) YBAppointMentDetailDataCancelReason *cancelreason;

@end