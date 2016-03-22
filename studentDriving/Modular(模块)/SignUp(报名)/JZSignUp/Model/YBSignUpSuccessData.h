//
//	YBSignUpSuccessData.h
//
//	Create by JiangangYang on 15/3/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "YBSignUpSuccessApplyclasstypeinfo.h"
#import "YBSignUpSuccessApplyschoolinfo.h"

@interface YBSignUpSuccessData : NSObject

@property (nonatomic, strong) YBSignUpSuccessApplyclasstypeinfo * applyclasstypeinfo;
@property (nonatomic, strong) YBSignUpSuccessApplyschoolinfo * applyschoolinfo;
@property (nonatomic, strong) NSString * applytime;
@property (nonatomic, strong) NSString * endapplytime;
@property (nonatomic, strong) NSString * mobile;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * orderid;
@property (nonatomic, assign) NSInteger paytype;
@property (nonatomic, assign) NSInteger paytypestatus;
@property (nonatomic, strong) NSString * scanauditurl;
@property (nonatomic, strong) NSString * schoollogoimg;
@property (nonatomic, assign) NSInteger applystate;// 2：正在学习，开始上课 1：报名申请中

@end