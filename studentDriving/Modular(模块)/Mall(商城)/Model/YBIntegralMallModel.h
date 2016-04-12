//
//  YBIntegralMallModel.h
//  studentDriving
//
//  Created by zyt on 16/2/18.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 
 address = "\U5317\U4eac\U5e02\U5317\U4eac\U5e02\U4e1c\U57ce\U533a\U738b\U5e9c\U4e95\U5927\U8857\U7532131\U53f7";
 buycount = 34;
 cityname = "\U5317\U4eac\U5e02";
 county = "";
 detailsimg = "http://7xnjg0.com1.z0.glb.clouddn.com/1460427035307.png";
 detailurl = "http://jzapi.yibuxueche.com/validation/getpageproductdetial?productid=5652892235146036001414c6";
 distinct = 0;
 enddate = "2016-12-11T16:00:00.000Z";
 "is_scanconsumption" = 0;
 merchantid = 56c68d078de60b3d735b015a;
 productcount = 100;
 productdesc = "\U79ef\U5206\U6362Y\U7801\Uff0cmoney\U62b1\U56de\U5bb6\Uff01";
 productid = 5652892235146036001414c6;
 productimg = "http://7xnjg0.com1.z0.glb.clouddn.com/1460427024623.png";
 productname = "Y\U7801";
 productprice = 300;
 viewcount = 300;

 
 
 
 
 */







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
