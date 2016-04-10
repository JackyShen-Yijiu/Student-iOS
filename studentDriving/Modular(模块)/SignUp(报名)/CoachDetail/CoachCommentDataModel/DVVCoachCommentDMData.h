#import <UIKit/UIKit.h>
#import "DVVCoachCommentDMComment.h"
#import "DVVCoachCommentDMUserid.h"
#import "YYModel.h"

@interface DVVCoachCommentDMData : NSObject<YYModel>

@property (nonatomic, strong) NSString * ID;
@property (nonatomic, strong) DVVCoachCommentDMComment * comment;
@property (nonatomic, strong) NSObject * timestamp;
@property (nonatomic, strong) DVVCoachCommentDMUserid * userid;
@end