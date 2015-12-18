#import <UIKit/UIKit.h>
#import "DrivingCycleShowDMHeadportrait.h"

@interface DrivingCycleShowDMData : NSObject

@property (nonatomic, assign) NSInteger v;
@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * createtime;
@property (nonatomic, strong) DrivingCycleShowDMHeadportrait * headportrait;
@property (nonatomic, assign) BOOL isUsing;
@property (nonatomic, strong) NSString * linkurl;
@property (nonatomic, strong) NSString * newsname;
@property (nonatomic, assign) NSInteger newtype;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end