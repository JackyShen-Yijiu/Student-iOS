//
//  YBIntegralMallModel.h
//  studentDriving
//
//  Created by zyt on 16/2/18.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBIntegralMallModel : NSObject
@property (nonatomic,strong) NSString *productid;
@property (nonatomic,strong) NSString *productname;
@property (nonatomic,assign) NSInteger  productprice;
@property (nonatomic,strong) NSString *productimg;
@property (nonatomic,strong) NSString *productdesc;
@property (nonatomic,assign) int  viewcount;
@property (nonatomic,assign) int  buycount;
@property (nonatomic,strong) NSString *detailsimg;
@property (nonatomic,assign) BOOL is_scanconsumption;

@property (nonatomic,strong) NSString *detailurl;
@property (nonatomic,assign) int  productcount;
@property (nonatomic, copy) NSString *addressStr;
@end
