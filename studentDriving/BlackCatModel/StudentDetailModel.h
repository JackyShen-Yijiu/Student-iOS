//
//  StudentDetailModel.h
//  studentDriving
//
//  Created by bestseller on 15/10/29.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>
#import "ApplyclasstypeinfoModel.h"
#import "ApplycoachinfoModel.h"
#import "ApplyschoolinfoModel.h"
#import "CarModel.h"
#import "Logoimg.h"
#import "SubjectModel.h"
#import "SubjectTwoModel.h"
@interface StudentDetailModel : MTLModel<MTLJSONSerializing>
@property (copy, nonatomic, readonly) NSString *address;
@property (strong, nonatomic, readonly) ApplyclasstypeinfoModel *applyclasstypeinfo;
@property (strong, nonatomic, readonly) ApplycoachinfoModel *applycoachinfo;
@property (strong, nonatomic, readonly) ApplyschoolinfoModel *applyschoolinfo;
@property (strong, nonatomic, readonly) NSNumber *applystate;
@property (strong, nonatomic, readonly) CarModel *carmodel;
@property (copy, readonly, nonatomic) NSString *createtime;
@property (copy, readonly, nonatomic) NSString *displaymobile;
@property (copy, readonly, nonatomic) NSString *displayuserid;
@property (copy, readonly, nonatomic) NSString *email;
@property (copy, readonly, nonatomic) NSString *gender;
@property (strong, nonatomic, readonly) Logoimg *headportrait;
@property (copy, readonly, nonatomic) NSString *invitationcode;
@property (strong, readonly, nonatomic) NSNumber *is_lock;
@property (copy, readonly, nonatomic) NSString *logintime;
@property (copy, readonly, nonatomic) NSString *mobile;
@property (copy, readonly, nonatomic) NSString *name;
@property (copy, readonly, nonatomic) NSString *nickname;
@property (copy, readonly, nonatomic) NSString *signature;
@property (strong, nonatomic, readonly) SubjectModel *subject;
@property (strong, nonatomic, readonly) SubjectTwoModel *subjecttwo;
@property (strong, nonatomic, readonly) SubjectTwoModel *subjectthree;
@property (copy, readonly, nonatomic) NSString *telephone;
@property (copy, readonly, nonatomic) NSString *userid;
@end
