//
//	JZSideMenuOrderListProductid.h
//
//	Create by ytzhang on 14/4/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface JZSideMenuOrderListProductid : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * productname;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end