//
//	JZRecordListRootClass.m
//
//	Create by ytzhang on 11/4/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "JZRecordListRootClass.h"

@interface JZRecordListRootClass ()
@end
@implementation JZRecordListRootClass




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"data"] isKindOfClass:[NSNull class]]){
		self.data = [[JZRecordData alloc] initWithDictionary:dictionary[@"data"]];
	}

	if(![dictionary[@"msg"] isKindOfClass:[NSNull class]]){
		self.msg = dictionary[@"msg"];
	}	
	if(![dictionary[@"type"] isKindOfClass:[NSNull class]]){
		self.type = [dictionary[@"type"] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.data != nil){
		dictionary[@"data"] = [self.data toDictionary];
	}
	if(self.msg != nil){
		dictionary[@"msg"] = self.msg;
	}
	dictionary[@"type"] = @(self.type);
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	if(self.data != nil){
		[aCoder encodeObject:self.data forKey:@"data"];
	}
	if(self.msg != nil){
		[aCoder encodeObject:self.msg forKey:@"msg"];
	}
	[aCoder encodeObject:@(self.type) forKey:@"type"];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.data = [aDecoder decodeObjectForKey:@"data"];
	self.msg = [aDecoder decodeObjectForKey:@"msg"];
	self.type = [[aDecoder decodeObjectForKey:@"type"] integerValue];
	return self;

}
@end