#import <UIKit/UIKit.h>
#import "DVVCoachCommentDMApplyclasstypeinfo.h"
#import "DVVCoachCommentDMCarmodel.h"
#import "DVVCoachCommentDMHeadportrait.h"
#import "YYModel.h"

@interface DVVCoachCommentDMUserid : NSObject<YYModel>

@property (nonatomic, strong) NSString * ID;
@property (nonatomic, strong) DVVCoachCommentDMApplyclasstypeinfo * applyclasstypeinfo;
@property (nonatomic, strong) DVVCoachCommentDMCarmodel * carmodel;
@property (nonatomic, strong) DVVCoachCommentDMHeadportrait * headportrait;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString *gender;

@end