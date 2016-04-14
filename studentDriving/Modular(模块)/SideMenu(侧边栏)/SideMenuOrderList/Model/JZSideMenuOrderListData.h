//
//	JZSideMenuOrderListData.h
//
//	Create by ytzhang on 14/4/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "JZSideMenuOrderListProductid.h"

@interface JZSideMenuOrderListData : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, assign) NSInteger couponcomefrom;
@property (nonatomic, strong) NSString * createtime;
@property (nonatomic, assign) BOOL isForcash;
@property (nonatomic, strong) NSString * orderscanaduiturl;
@property (nonatomic, strong) JZSideMenuOrderListProductid * productid;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSString * userid;
@property (nonatomic, strong) NSString * usetime;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end