//
//  MallOrderListModel.h
//  studentDriving
//
//  Created by zyt on 16/2/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MallOrderListModel : NSObject
/*
 {
 address = 15652305650;
 createtime = "2016-02-26";
 endtime = "2016-03-26";
 "is_confirmbyscan" = 0;
 merchantaddress = "\U5317\U4eac\U5e02\U5317\U4eac\U5e02\U4e1c\U57ce\U533a\U738b\U5e9c\U4e95\U5927\U8857\U7532131\U53f7";
 merchantid = 56c68d078de60b3d735b015a;
 merchantmobile = 15652305650;
 merchantname = "\U4e00\U6b65\U5b66\U8f66\U5546\U57ce";
 mobile = 15652305650;
 orderid = 56d11bd060fdd332427abdcb;
 orderscanaduiturl = "http://api.yibuxueche.com/validation/ordervalidation?orderid=56d11bd060fdd332427abdcb";
 orderstate = 1;
 productid = 5652892235146036001414c6;
 productimg = "http://7xnjg0.com1.z0.glb.clouddn.com/3.jpg";
 productname = "iPhone5S 16G";
 productprice = 70000;
 receivername = "\U674e\U4e9a\U98de";
 },
 */
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *createtime;
@property (nonatomic, strong) NSString *endtime;
@property (nonatomic, assign) BOOL is_confirmbyscan;
@property (nonatomic, strong) NSString *merchantaddress;
@property (nonatomic, assign) NSInteger merchantid;
@property (nonatomic, assign) NSInteger merchantmobile;
@property (nonatomic, strong) NSString *merchantname;
@property (nonatomic, assign) NSInteger mobile;
@property (nonatomic, assign) NSInteger orderid;
@property (nonatomic, strong) NSString *orderscanaduiturl;
@property (nonatomic, assign) NSInteger orderstate;
@property (nonatomic, assign) NSInteger productid;
@property (nonatomic, strong) NSString *productname;
@property (nonatomic, strong)  NSString *productimg;
@property (nonatomic, assign) NSInteger productprice;
@property (nonatomic, strong) NSString *receivername;



@end
