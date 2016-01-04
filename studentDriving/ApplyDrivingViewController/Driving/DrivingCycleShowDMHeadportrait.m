//
//	DrivingCycleShowDMHeadportrait.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "DrivingCycleShowDMHeadportrait.h"

@interface DrivingCycleShowDMHeadportrait ()
@end
@implementation DrivingCycleShowDMHeadportrait




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"height"] isKindOfClass:[NSNull class]]){
		self.height = dictionary[@"height"];
	}	
	if(![dictionary[@"originalpic"] isKindOfClass:[NSNull class]]){
		self.originalpic = dictionary[@"originalpic"];
	}	
	if(![dictionary[@"thumbnailpic"] isKindOfClass:[NSNull class]]){
		self.thumbnailpic = dictionary[@"thumbnailpic"];
	}	
	if(![dictionary[@"width"] isKindOfClass:[NSNull class]]){
		self.width = dictionary[@"width"];
	}	
	return self;
}
@end