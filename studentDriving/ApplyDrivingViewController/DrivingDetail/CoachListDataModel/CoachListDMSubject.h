#import <UIKit/UIKit.h>
#import "YYModel.h"

@interface CoachListDMSubject : NSObject<YYModel>

@property (nonatomic, strong) NSString * ID;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger subjectid;
@end