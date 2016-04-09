//
//  YBEditUserInfoController.h
//  studentDriving
//
//  Created by 大威 on 16/3/1.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YBEditUserInfoType) {
    /** 昵称 */
    YBEditUserInfoType_NickName = 0,
    /** 姓名 */
    YBEditUserInfoType_Name,
    /** 性别 */
    YBEditUserInfoType_Sex,
    /** 手机号 */
    YBEditUserInfoType_Mobile,
    /** 地址 */
    YBEditUserInfoType_Address
};

@interface YBEditUserInfoController : UIViewController

@property (nonatomic, assign) YBEditUserInfoType editType;

@property (nonatomic, copy) NSString *defaultString;

@property (nonatomic, weak) NSMutableArray *userInfoDetailArray;
@property (nonatomic, weak) UITableView *tableView;

@end
