//
//	JZRecordData.h
//
//	Create by ytzhang on 11/4/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "JZRecordOrdrelist.h"
#import "JZRecordUserdata.h"

@interface JZRecordData : NSObject

@property (nonatomic, strong) NSArray * ordrelist;
@property (nonatomic, strong) JZRecordUserdata * userdata;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end