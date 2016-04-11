//
//	JZRecordOrdrelist.h
//
//	Create by ytzhang on 11/4/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface JZRecordOrdrelist : NSObject

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