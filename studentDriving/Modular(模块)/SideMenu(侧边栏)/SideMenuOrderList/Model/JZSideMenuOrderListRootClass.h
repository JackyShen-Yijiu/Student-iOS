//
//	JZSideMenuOrderListRootClass.h
//
//	Create by ytzhang on 14/4/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "JZSideMenuOrderListData.h"

@interface JZSideMenuOrderListRootClass : NSObject

@property (nonatomic, strong) NSArray * data;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, assign) NSInteger type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end