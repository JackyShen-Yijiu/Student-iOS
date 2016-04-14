//
//	JZSideMenuOrderListProductid.m
//
//	Create by ytzhang on 14/4/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "JZSideMenuOrderListProductid.h"

@interface JZSideMenuOrderListProductid ()
@end
@implementation JZSideMenuOrderListProductid




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"_id"] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[@"_id"];
	}	
	if(![dictionary[@"productname"] isKindOfClass:[NSNull class]]){
		self.productname = dictionary[@"productname"];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.idField != nil){
		dictionary[@"_id"] = self.idField;
	}
	if(self.productname != nil){
		dictionary[@"productname"] = self.productname;
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
	if(self.idField != nil){
		[aCoder encodeObject:self.idField forKey:@"_id"];
	}
	if(self.productname != nil){
		[aCoder encodeObject:self.productname forKey:@"productname"];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:@"_id"];
	self.productname = [aDecoder decodeObjectForKey:@"productname"];
	return self;

}
@end