#import <UIKit/UIKit.h>
#import "DVVPaySuccessDMApplyclasstypeinfo.h"
#import "DVVPaySuccessDMApplycoachinfo.h"
#import "DVVPaySuccessDMApplycoachinfo.h"
#import "DVVPaySuccessDMCarmodel.h"

@interface DVVPaySuccessDMData : NSObject

@property (nonatomic, strong) DVVPaySuccessDMApplyclasstypeinfo * applyclasstypeinfo;
@property (nonatomic, strong) DVVPaySuccessDMApplycoachinfo * applycoachinfo;
@property (nonatomic, strong) NSString * applynotes;
@property (nonatomic, strong) NSString * applyorderid;
@property (nonatomic, strong) DVVPaySuccessDMApplycoachinfo * applyschoolinfo;
@property (nonatomic, assign) NSInteger applystate;
@property (nonatomic, strong) NSString * applytime;
@property (nonatomic, strong) DVVPaySuccessDMCarmodel * carmodel;
@property (nonatomic, strong) NSString * endtime;
@property (nonatomic, strong) NSString * mobile;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger paytype;
@property (nonatomic, assign) NSInteger paytypestatus;
@property (nonatomic, strong) NSString * schoollogoimg;
@property (nonatomic, strong) NSString * userid;
@end