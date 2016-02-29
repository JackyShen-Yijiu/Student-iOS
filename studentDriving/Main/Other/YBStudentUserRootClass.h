#import <UIKit/UIKit.h>
#import "YBStudentUserData.h"

@interface YBStudentUserRootClass : NSObject

@property (nonatomic, strong) YBStudentUserData * data;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, assign) NSInteger type;
@end