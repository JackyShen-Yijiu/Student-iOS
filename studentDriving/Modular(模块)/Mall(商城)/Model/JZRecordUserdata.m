//
//	JZRecordUserdata.m
//
//	Create by ytzhang on 11/4/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "JZRecordUserdata.h"

@interface JZRecordUserdata ()
@end
@implementation JZRecordUserdata




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"applystate"] isKindOfClass:[NSNull class]]){
		self.applystate = [dictionary[@"applystate"] integerValue];
	}

	if(![dictionary[@"applytime"] isKindOfClass:[NSNull class]]){
		self.applytime = dictionary[@"applytime"];
	}	
	if(![dictionary[@"endtime"] isKindOfClass:[NSNull class]]){
		self.endtime = dictionary[@"endtime"];
	}	
	if(![dictionary[@"mobile"] isKindOfClass:[NSNull class]]){
		self.mobile = dictionary[@"mobile"];
	}	
	if(![dictionary[@"name"] isKindOfClass:[NSNull class]]){
		self.name = dictionary[@"name"];
	}	
	if(![dictionary[@"schooladdress"] isKindOfClass:[NSNull class]]){
		self.schooladdress = dictionary[@"schooladdress"];
	}	
	if(![dictionary[@"schoolid"] isKindOfClass:[NSNull class]]){
		self.schoolid = dictionary[@"schoolid"];
	}	
	if(![dictionary[@"schoollogoimg"] isKindOfClass:[NSNull class]]){
		self.schoollogoimg = dictionary[@"schoollogoimg"];
	}	
	if(![dictionary[@"schoolname"] isKindOfClass:[NSNull class]]){
		self.schoolname = dictionary[@"schoolname"];
	}	
	if(![dictionary[@"schoolphone"] isKindOfClass:[NSNull class]]){
		self.schoolphone = dictionary[@"schoolphone"];
	}	
	if(![dictionary[@"userid"] isKindOfClass:[NSNull class]]){
		self.userid = dictionary[@"userid"];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[@"applystate"] = @(self.applystate);
	if(self.applytime != nil){
		dictionary[@"applytime"] = self.applytime;
	}
	if(self.endtime != nil){
		dictionary[@"endtime"] = self.endtime;
	}
	if(self.mobile != nil){
		dictionary[@"mobile"] = self.mobile;
	}
	if(self.name != nil){
		dictionary[@"name"] = self.name;
	}
	if(self.schooladdress != nil){
		dictionary[@"schooladdress"] = self.schooladdress;
	}
	if(self.schoolid != nil){
		dictionary[@"schoolid"] = self.schoolid;
	}
	if(self.schoollogoimg != nil){
		dictionary[@"schoollogoimg"] = self.schoollogoimg;
	}
	if(self.schoolname != nil){
		dictionary[@"schoolname"] = self.schoolname;
	}
	if(self.schoolphone != nil){
		dictionary[@"schoolphone"] = self.schoolphone;
	}
	if(self.userid != nil){
		dictionary[@"userid"] = self.userid;
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
	[aCoder encodeObject:@(self.applystate) forKey:@"applystate"];	if(self.applytime != nil){
		[aCoder encodeObject:self.applytime forKey:@"applytime"];
	}
	if(self.endtime != nil){
		[aCoder encodeObject:self.endtime forKey:@"endtime"];
	}
	if(self.mobile != nil){
		[aCoder encodeObject:self.mobile forKey:@"mobile"];
	}
	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:@"name"];
	}
	if(self.schooladdress != nil){
		[aCoder encodeObject:self.schooladdress forKey:@"schooladdress"];
	}
	if(self.schoolid != nil){
		[aCoder encodeObject:self.schoolid forKey:@"schoolid"];
	}
	if(self.schoollogoimg != nil){
		[aCoder encodeObject:self.schoollogoimg forKey:@"schoollogoimg"];
	}
	if(self.schoolname != nil){
		[aCoder encodeObject:self.schoolname forKey:@"schoolname"];
	}
	if(self.schoolphone != nil){
		[aCoder encodeObject:self.schoolphone forKey:@"schoolphone"];
	}
	if(self.userid != nil){
		[aCoder encodeObject:self.userid forKey:@"userid"];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.applystate = [[aDecoder decodeObjectForKey:@"applystate"] integerValue];
	self.applytime = [aDecoder decodeObjectForKey:@"applytime"];
	self.endtime = [aDecoder decodeObjectForKey:@"endtime"];
	self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
	self.name = [aDecoder decodeObjectForKey:@"name"];
	self.schooladdress = [aDecoder decodeObjectForKey:@"schooladdress"];
	self.schoolid = [aDecoder decodeObjectForKey:@"schoolid"];
	self.schoollogoimg = [aDecoder decodeObjectForKey:@"schoollogoimg"];
	self.schoolname = [aDecoder decodeObjectForKey:@"schoolname"];
	self.schoolphone = [aDecoder decodeObjectForKey:@"schoolphone"];
	self.userid = [aDecoder decodeObjectForKey:@"userid"];
	return self;

}
@end