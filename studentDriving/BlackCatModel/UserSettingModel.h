#import "MTLModel.h"
#import <MTLJSONAdapter.h>
@interface UserSettingModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) BOOL classremind;
@property (nonatomic, assign) BOOL newmessagereminder;
@property (nonatomic, assign) BOOL reservationreminder;

@end