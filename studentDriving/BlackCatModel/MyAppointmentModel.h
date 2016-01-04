//
//  MyAppointmentModel.h
//  BlackCat
//
//  Created by bestseller on 15/10/25.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>
#import "SubjectModel.h"
#import "MyAppointmentCoachModel.h"
/*
 "is_coachcomment" = 0;
 "is_comment" = 0;
 "is_complaint" = 0;
 "is_shuttle" = 1;
 reservationcourse =             (
 562b7c0493d4ca260b40e537
 );
 reservationcreatetime = "2015-10-24T12:39:34.044Z";
 reservationstate = 1;
 shuttleaddress = "\U5317\U4eac\U5e02";
 subject =             {
 name = "\U79d1\U76ee\U4e8c";
 subjectid = 2;
 };
 trainfieldid = 561636cc21ec29041a9af88e;
 userid = 5611292a193184140355c49a;
 */
@interface MyAppointmentModel : MTLModel<MTLJSONSerializing>
@property (copy, nonatomic, readonly) NSString *infoId;
@property (copy, nonatomic, readonly) NSString *classdatetimedesc;
@property (copy, nonatomic, readonly) NSString *begintime;
@property (strong, nonatomic, readonly) MyAppointmentCoachModel *coachid;
@property (strong, nonatomic, readonly) NSNumber *coursehour;
@property (copy, nonatomic, readonly) NSString *courseprocessdesc;
@property (copy, nonatomic, readonly) NSString *endtime;
@property (strong, nonatomic, readonly) NSNumber *is_coachcomment;
@property (strong, nonatomic, readonly) NSNumber *is_comment;
@property (strong, nonatomic, readonly) NSNumber *is_complaint;
@property (strong, nonatomic, readonly) NSNumber *is_shuttle;
@property (strong, nonatomic, readonly) NSArray *reservationcourse;
@property (copy, nonatomic, readonly) NSString *reservationcreatetime;
@property (strong, nonatomic, readonly) NSNumber *reservationstate;
@property (copy, nonatomic, readonly) NSString *shuttleaddress;
@property (strong, nonatomic, readonly) SubjectModel *subjectModel;
@property (copy, nonatomic, readonly) NSString *trainfieldid;
@property (copy, nonatomic, readonly) NSString *userid;

@end
