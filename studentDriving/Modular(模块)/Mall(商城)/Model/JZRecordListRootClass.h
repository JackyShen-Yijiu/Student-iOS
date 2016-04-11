//
//	JZRecordListRootClass.h
//
//	Create by ytzhang on 11/4/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "JZRecordData.h"

@interface JZRecordListRootClass : NSObject

@property (nonatomic, strong) JZRecordData * data;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, assign) NSInteger type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end