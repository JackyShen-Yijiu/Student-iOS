//
//	DrivingCarTypeDMRootClass.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "DrivingCarTypeDMRootClass.h"

@interface DrivingCarTypeDMRootClass ()
@end
@implementation DrivingCarTypeDMRootClass

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[@"data"] != nil && [dictionary[@"data"] isKindOfClass:[NSArray class]]){
		NSArray * dataDictionaries = dictionary[@"data"];
		NSMutableArray * dataItems = [NSMutableArray array];
		for(NSDictionary * dataDictionary in dataDictionaries){
			DrivingCarTypeDMData * dataItem = [[DrivingCarTypeDMData alloc] initWithDictionary:dataDictionary];
			[dataItems addObject:dataItem];
		}
		self.data = dataItems;
	}
	if(![dictionary[@"msg"] isKindOfClass:[NSNull class]]){
		self.msg = dictionary[@"msg"];
	}	
	if(![dictionary[@"type"] isKindOfClass:[NSNull class]]){
		self.type = [dictionary[@"type"] integerValue];
	}

	return self;
}
@end