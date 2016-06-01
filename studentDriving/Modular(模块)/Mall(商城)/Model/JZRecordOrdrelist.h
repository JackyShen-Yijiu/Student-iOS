//
//	JZRecordOrdrelist.h
//
//	Create by ytzhang on 11/4/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface JZRecordOrdrelist : NSObject


/*
 "orderid": "5679033e5722040236190947",
 "createtime": "2015-12-22",
 "endtime": "2016-01-22",
 "orderstate": 1,
 "orderscanaduiturl": "http://123.57.63.15:8181/validation/ordervalidation?orderid=5679033e5722040236190947",
 "is_confirmbyscan": false,
 "productid": "564051bf262202041284256d",
 "productname": "Rivl 无线鼠标",
 "productprice": 300,
 "productimg": "http://7xnjg0.com1.z0.glb.clouddn.com/p2.jpg",
 "merchantid": "56c68d078de60b3d735b015a",
 "merchantname": "一步学车商城",
 "merchantmobile": "15652305650",
 "merchantaddress": "北京市北京市东城区王府井大街甲131号"
 
 */

@property (nonatomic, strong) NSString * createtime;
@property (nonatomic, strong) NSString * endtime;
@property (nonatomic, assign) BOOL isConfirmbyscan;
@property (nonatomic, strong) NSString * merchantaddress;
@property (nonatomic, strong) NSString * merchantid;
@property (nonatomic, strong) NSString * merchantmobile;
@property (nonatomic, strong) NSString * merchantname;
@property (nonatomic, strong) NSString * orderid;
@property (nonatomic, strong) NSString * orderscanaduiturl;
@property (nonatomic, assign) NSInteger orderstate;
@property (nonatomic, strong) NSString * productid;
@property (nonatomic, strong) NSString * productimg;
@property (nonatomic, strong) NSString * productname;
@property (nonatomic, assign) NSInteger productprice;


-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end