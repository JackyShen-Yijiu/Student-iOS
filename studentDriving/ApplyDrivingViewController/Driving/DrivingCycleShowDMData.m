//
//	DrivingCycleShowDMData.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "DrivingCycleShowDMData.h"

@interface DrivingCycleShowDMData ()
@end
@implementation DrivingCycleShowDMData




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"__v"] isKindOfClass:[NSNull class]]){
		self.v = [dictionary[@"__v"] integerValue];
	}

	if(![dictionary[@"_id"] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[@"_id"];
	}	
	if(![dictionary[@"createtime"] isKindOfClass:[NSNull class]]){
		self.createtime = dictionary[@"createtime"];
	}	
	if(![dictionary[@"headportrait"] isKindOfClass:[NSNull class]]){
		self.headportrait = [[DrivingCycleShowDMHeadportrait alloc] initWithDictionary:dictionary[@"headportrait"]];
	}

	if(![dictionary[@"is_using"] isKindOfClass:[NSNull class]]){
		self.isUsing = [dictionary[@"is_using"] boolValue];
	}

	if(![dictionary[@"linkurl"] isKindOfClass:[NSNull class]]){
		self.linkurl = dictionary[@"linkurl"];
	}	
	if(![dictionary[@"newsname"] isKindOfClass:[NSNull class]]){
		self.newsname = dictionary[@"newsname"];
	}	
	if(![dictionary[@"newtype"] isKindOfClass:[NSNull class]]){
		self.newtype = [dictionary[@"newtype"] integerValue];
	}

	return self;
}
@end