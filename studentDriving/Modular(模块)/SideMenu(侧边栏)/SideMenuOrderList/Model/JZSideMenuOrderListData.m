//
//	JZSideMenuOrderListData.m
//
//	Create by ytzhang on 14/4/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "JZSideMenuOrderListData.h"

@interface JZSideMenuOrderListData ()
@end
@implementation JZSideMenuOrderListData




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"_id"] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[@"_id"];
	}	
	if(![dictionary[@"couponcomefrom"] isKindOfClass:[NSNull class]]){
		self.couponcomefrom = [dictionary[@"couponcomefrom"] integerValue];
	}

	if(![dictionary[@"createtime"] isKindOfClass:[NSNull class]]){
		self.createtime = dictionary[@"createtime"];
	}	
	if(![dictionary[@"is_forcash"] isKindOfClass:[NSNull class]]){
		self.isForcash = [dictionary[@"is_forcash"] boolValue];
	}

	if(![dictionary[@"orderscanaduiturl"] isKindOfClass:[NSNull class]]){
		self.orderscanaduiturl = dictionary[@"orderscanaduiturl"];
	}	
	if(![dictionary[@"productid"] isKindOfClass:[NSNull class]]){
		self.productid = [[JZSideMenuOrderListProductid alloc] initWithDictionary:dictionary[@"productid"]];
	}

	if(![dictionary[@"state"] isKindOfClass:[NSNull class]]){
		self.state = [dictionary[@"state"] integerValue];
	}

	if(![dictionary[@"userid"] isKindOfClass:[NSNull class]]){
		self.userid = dictionary[@"userid"];
	}	
	if(![dictionary[@"usetime"] isKindOfClass:[NSNull class]]){
		self.usetime = dictionary[@"usetime"];
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
	dictionary[@"couponcomefrom"] = @(self.couponcomefrom);
	if(self.createtime != nil){
		dictionary[@"createtime"] = self.createtime;
	}
	dictionary[@"is_forcash"] = @(self.isForcash);
	if(self.orderscanaduiturl != nil){
		dictionary[@"orderscanaduiturl"] = self.orderscanaduiturl;
	}
	if(self.productid != nil){
		dictionary[@"productid"] = [self.productid toDictionary];
	}
	dictionary[@"state"] = @(self.state);
	if(self.userid != nil){
		dictionary[@"userid"] = self.userid;
	}
	if(self.usetime != nil){
		dictionary[@"usetime"] = self.usetime;
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
	[aCoder encodeObject:@(self.couponcomefrom) forKey:@"couponcomefrom"];	if(self.createtime != nil){
		[aCoder encodeObject:self.createtime forKey:@"createtime"];
	}
	[aCoder encodeObject:@(self.isForcash) forKey:@"is_forcash"];	if(self.orderscanaduiturl != nil){
		[aCoder encodeObject:self.orderscanaduiturl forKey:@"orderscanaduiturl"];
	}
	if(self.productid != nil){
		[aCoder encodeObject:self.productid forKey:@"productid"];
	}
	[aCoder encodeObject:@(self.state) forKey:@"state"];	if(self.userid != nil){
		[aCoder encodeObject:self.userid forKey:@"userid"];
	}
	if(self.usetime != nil){
		[aCoder encodeObject:self.usetime forKey:@"usetime"];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:@"_id"];
	self.couponcomefrom = [[aDecoder decodeObjectForKey:@"couponcomefrom"] integerValue];
	self.createtime = [aDecoder decodeObjectForKey:@"createtime"];
	self.isForcash = [[aDecoder decodeObjectForKey:@"is_forcash"] boolValue];
	self.orderscanaduiturl = [aDecoder decodeObjectForKey:@"orderscanaduiturl"];
	self.productid = [aDecoder decodeObjectForKey:@"productid"];
	self.state = [[aDecoder decodeObjectForKey:@"state"] integerValue];
	self.userid = [aDecoder decodeObjectForKey:@"userid"];
	self.usetime = [aDecoder decodeObjectForKey:@"usetime"];
	return self;

}
@end