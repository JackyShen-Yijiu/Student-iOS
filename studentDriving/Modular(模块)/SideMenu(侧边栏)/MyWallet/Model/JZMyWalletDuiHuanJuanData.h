#import <UIKit/UIKit.h>
#import "JZMyWalletDuiHuanJuanUseproductidlist.h"

@interface JZMyWalletDuiHuanJuanData : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, assign) NSInteger couponcomefrom;
@property (nonatomic, strong) NSString * createtime;
@property (nonatomic, assign) BOOL isForcash;
@property (nonatomic, strong) NSString * orderscanaduiturl;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSArray * useproductidlist;
@property (nonatomic, strong) NSString * userid;

/** 用来标识当前组是否打开或关闭 */
@property (nonatomic, assign) BOOL openGroup;
@end