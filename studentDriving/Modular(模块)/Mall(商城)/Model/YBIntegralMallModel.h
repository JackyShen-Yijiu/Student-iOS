//
//  YBIntegralMallModel.h
//  studentDriving
//
//  Created by zyt on 16/2/18.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBIntegralMallModel : NSObject
///  商品id
@property (nonatomic,strong) NSString *productid;
///  商品名字
@property (nonatomic,strong) NSString *productname;
///  商品价格
@property (nonatomic,assign) NSInteger  productprice;
///  商品图片
@property (nonatomic,strong) NSString *productimg;
///  商品详情
@property (nonatomic,strong) NSString *productdesc;
@property (nonatomic,assign) int  viewcount;
@property (nonatomic,assign) int  buycount;
@property (nonatomic,strong) NSString *detailsimg;
@property (nonatomic,assign) BOOL is_scanconsumption;

@property (nonatomic,strong) NSString *detailurl;
@property (nonatomic,assign) int  productcount;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *enddate;
@end
