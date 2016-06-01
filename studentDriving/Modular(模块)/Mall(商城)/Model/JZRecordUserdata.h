//
//	JZRecordUserdata.h
//
//	Create by ytzhang on 11/4/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface JZRecordUserdata : NSObject

@property (nonatomic, assign) NSInteger applystate;
@property (nonatomic, strong) NSString * applytime;
@property (nonatomic, strong) NSString * endtime;
@property (nonatomic, strong) NSString * mobile;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * schooladdress;
@property (nonatomic, strong) NSString * schoolid;
@property (nonatomic, strong) NSString * schoollogoimg;
@property (nonatomic, strong) NSString * schoolname;
@property (nonatomic, strong) NSString * schoolphone;
@property (nonatomic, strong) NSString * userid;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end