//
//	JZRecordData.m
//
//	Create by ytzhang on 11/4/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "JZRecordData.h"

@interface JZRecordData ()
@end
@implementation JZRecordData




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[@"ordrelist"] != nil && [dictionary[@"ordrelist"] isKindOfClass:[NSArray class]]){
		NSArray * ordrelistDictionaries = dictionary[@"ordrelist"];
		NSMutableArray * ordrelistItems = [NSMutableArray array];
		for(NSDictionary * ordrelistDictionary in ordrelistDictionaries){
			JZRecordOrdrelist * ordrelistItem = [[JZRecordOrdrelist alloc] initWithDictionary:ordrelistDictionary];
			[ordrelistItems addObject:ordrelistItem];
		}
		self.ordrelist = ordrelistItems;
	}
	if(![dictionary[@"userdata"] isKindOfClass:[NSNull class]]){
		self.userdata = [[JZRecordUserdata alloc] initWithDictionary:dictionary[@"userdata"]];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.ordrelist != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(JZRecordOrdrelist * ordrelistElement in self.ordrelist){
			[dictionaryElements addObject:[ordrelistElement toDictionary]];
		}
		dictionary[@"ordrelist"] = dictionaryElements;
	}
	if(self.userdata != nil){
		dictionary[@"userdata"] = [self.userdata toDictionary];
	}
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
	if(self.ordrelist != nil){
		[aCoder encodeObject:self.ordrelist forKey:@"ordrelist"];
	}
	if(self.userdata != nil){
		[aCoder encodeObject:self.userdata forKey:@"userdata"];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.ordrelist = [aDecoder decodeObjectForKey:@"ordrelist"];
	self.userdata = [aDecoder decodeObjectForKey:@"userdata"];
	return self;

}
@end