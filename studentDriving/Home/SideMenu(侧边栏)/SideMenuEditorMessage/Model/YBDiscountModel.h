//
//  YBDiscountModel.h
//  studentDriving
//
//  Created by zyt on 16/2/25.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBDiscountModel : NSObject
/*
 {
 data =     {
 mainlist =         (
 {
 address = "\U5317\U4eac\U5e02\U5317\U4eac\U5e02\U4e1c\U57ce\U533a\U738b\U5e9c\U4e95\U5927\U8857\U7532131\U53f7";
 buycount = 8;
 cityname = "\U5317\U4eac\U5e02";
 county = "";
 detailsimg = "http://7xnjg0.com1.z0.glb.clouddn.com/2.jpg";
 detailurl = "http://api.yibuxueche.com/validation/getpageproductdetial?productid=5652895f35146036001414c7";
 distinct = 0;
 "is_scanconsumption" = 1;
 merchantid = 56c68d078de60b3d735b015a;
 productcount = 10;
 productdesc = "Rivl \U65e0\U7ebf\U9f20\U6807";
 productid = 5652895f35146036001414c7;
 productimg = "http://7xnjg0.com1.z0.glb.clouddn.com/2.jpg";
 productname = "Rivl \U65e0\U7ebf\U9f20\U6807";
 productprice = 4000;
 viewcount = 102;
 }
 );
 toplist =         (
 );
 };
 msg = "";
 type = 1;
 }

 */

@property (nonatomic,strong) NSString *productid;
@property (nonatomic,strong) NSString *productname;
@property (nonatomic,assign) int  productprice;
@property (nonatomic,strong) NSString *productimg;
@property (nonatomic,strong) NSString *productdesc;
@property (nonatomic,assign) int  viewcount;
@property (nonatomic,assign) int  buycount;
@property (nonatomic,assign) int  productcount;
@property (nonatomic,strong) NSString *detailsimg;
@property (nonatomic,assign) BOOL is_scanconsumption;
@property (nonatomic, strong) NSString *addressStr;
@property (nonatomic,strong) NSString *detailurl;
@end
