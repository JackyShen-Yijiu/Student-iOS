//
//	DrivingCarTypeDMData.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "DrivingCarTypeDMData.h"

@interface DrivingCarTypeDMData ()
@end
@implementation DrivingCarTypeDMData

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"code"] isKindOfClass:[NSNull class]]){
		self.code = dictionary[@"code"];
	}	
	if(![dictionary[@"desc"] isKindOfClass:[NSNull class]]){
		self.desc = dictionary[@"desc"];
	}	
	if(![dictionary[@"modelsid"] isKindOfClass:[NSNull class]]){
		self.modelsid = [dictionary[@"modelsid"] integerValue];
	}

	if(![dictionary[@"name"] isKindOfClass:[NSNull class]]){
		self.name = dictionary[@"name"];
	}	
	return self;
}
@end