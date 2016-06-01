//
//	JZRecordOrdrelist.m
//
//	Create by ytzhang on 11/4/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "JZRecordOrdrelist.h"

@interface JZRecordOrdrelist ()
@end
@implementation JZRecordOrdrelist




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"createtime"] isKindOfClass:[NSNull class]]){
		self.createtime = dictionary[@"createtime"];
	}	
	if(![dictionary[@"endtime"] isKindOfClass:[NSNull class]]){
		self.endtime = dictionary[@"endtime"];
	}	
	if(![dictionary[@"is_confirmbyscan"] isKindOfClass:[NSNull class]]){
		self.isConfirmbyscan = [dictionary[@"is_confirmbyscan"] boolValue];
	}

	if(![dictionary[@"merchantaddress"] isKindOfClass:[NSNull class]]){
		self.merchantaddress = dictionary[@"merchantaddress"];
	}	
	if(![dictionary[@"merchantid"] isKindOfClass:[NSNull class]]){
		self.merchantid = dictionary[@"merchantid"];
	}	
	if(![dictionary[@"merchantmobile"] isKindOfClass:[NSNull class]]){
		self.merchantmobile = dictionary[@"merchantmobile"];
	}	
	if(![dictionary[@"merchantname"] isKindOfClass:[NSNull class]]){
		self.merchantname = dictionary[@"merchantname"];
	}	
	if(![dictionary[@"orderid"] isKindOfClass:[NSNull class]]){
		self.orderid = dictionary[@"orderid"];
	}	
	if(![dictionary[@"orderscanaduiturl"] isKindOfClass:[NSNull class]]){
		self.orderscanaduiturl = dictionary[@"orderscanaduiturl"];
	}	
	if(![dictionary[@"orderstate"] isKindOfClass:[NSNull class]]){
		self.orderstate = [dictionary[@"orderstate"] integerValue];
	}

	if(![dictionary[@"productid"] isKindOfClass:[NSNull class]]){
		self.productid = dictionary[@"productid"];
	}	
	if(![dictionary[@"productimg"] isKindOfClass:[NSNull class]]){
		self.productimg = dictionary[@"productimg"];
	}	
	if(![dictionary[@"productname"] isKindOfClass:[NSNull class]]){
		self.productname = dictionary[@"productname"];
	}	
	if(![dictionary[@"productprice"] isKindOfClass:[NSNull class]]){
		self.productprice = [dictionary[@"productprice"] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.createtime != nil){
		dictionary[@"createtime"] = self.createtime;
	}
	if(self.endtime != nil){
		dictionary[@"endtime"] = self.endtime;
	}
	dictionary[@"is_confirmbyscan"] = @(self.isConfirmbyscan);
	if(self.merchantaddress != nil){
		dictionary[@"merchantaddress"] = self.merchantaddress;
	}
	if(self.merchantid != nil){
		dictionary[@"merchantid"] = self.merchantid;
	}
	if(self.merchantmobile != nil){
		dictionary[@"merchantmobile"] = self.merchantmobile;
	}
	if(self.merchantname != nil){
		dictionary[@"merchantname"] = self.merchantname;
	}
	if(self.orderid != nil){
		dictionary[@"orderid"] = self.orderid;
	}
	if(self.orderscanaduiturl != nil){
		dictionary[@"orderscanaduiturl"] = self.orderscanaduiturl;
	}
	dictionary[@"orderstate"] = @(self.orderstate);
	if(self.productid != nil){
		dictionary[@"productid"] = self.productid;
	}
	if(self.productimg != nil){
		dictionary[@"productimg"] = self.productimg;
	}
	if(self.productname != nil){
		dictionary[@"productname"] = self.productname;
	}
	dictionary[@"productprice"] = @(self.productprice);
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
	if(self.createtime != nil){
		[aCoder encodeObject:self.createtime forKey:@"createtime"];
	}
	if(self.endtime != nil){
		[aCoder encodeObject:self.endtime forKey:@"endtime"];
	}
	[aCoder encodeObject:@(self.isConfirmbyscan) forKey:@"is_confirmbyscan"];	if(self.merchantaddress != nil){
		[aCoder encodeObject:self.merchantaddress forKey:@"merchantaddress"];
	}
	if(self.merchantid != nil){
		[aCoder encodeObject:self.merchantid forKey:@"merchantid"];
	}
	if(self.merchantmobile != nil){
		[aCoder encodeObject:self.merchantmobile forKey:@"merchantmobile"];
	}
	if(self.merchantname != nil){
		[aCoder encodeObject:self.merchantname forKey:@"merchantname"];
	}
	if(self.orderid != nil){
		[aCoder encodeObject:self.orderid forKey:@"orderid"];
	}
	if(self.orderscanaduiturl != nil){
		[aCoder encodeObject:self.orderscanaduiturl forKey:@"orderscanaduiturl"];
	}
	[aCoder encodeObject:@(self.orderstate) forKey:@"orderstate"];	if(self.productid != nil){
		[aCoder encodeObject:self.productid forKey:@"productid"];
	}
	if(self.productimg != nil){
		[aCoder encodeObject:self.productimg forKey:@"productimg"];
	}
	if(self.productname != nil){
		[aCoder encodeObject:self.productname forKey:@"productname"];
	}
	[aCoder encodeObject:@(self.productprice) forKey:@"productprice"];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.createtime = [aDecoder decodeObjectForKey:@"createtime"];
	self.endtime = [aDecoder decodeObjectForKey:@"endtime"];
	self.isConfirmbyscan = [[aDecoder decodeObjectForKey:@"is_confirmbyscan"] boolValue];
	self.merchantaddress = [aDecoder decodeObjectForKey:@"merchantaddress"];
	self.merchantid = [aDecoder decodeObjectForKey:@"merchantid"];
	self.merchantmobile = [aDecoder decodeObjectForKey:@"merchantmobile"];
	self.merchantname = [aDecoder decodeObjectForKey:@"merchantname"];
	self.orderid = [aDecoder decodeObjectForKey:@"orderid"];
	self.orderscanaduiturl = [aDecoder decodeObjectForKey:@"orderscanaduiturl"];
	self.orderstate = [[aDecoder decodeObjectForKey:@"orderstate"] integerValue];
	self.productid = [aDecoder decodeObjectForKey:@"productid"];
	self.productimg = [aDecoder decodeObjectForKey:@"productimg"];
	self.productname = [aDecoder decodeObjectForKey:@"productname"];
	self.productprice = [[aDecoder decodeObjectForKey:@"productprice"] integerValue];
	return self;

}
@end