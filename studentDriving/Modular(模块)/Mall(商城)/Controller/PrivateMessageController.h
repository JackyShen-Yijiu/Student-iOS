//
//  PrivateMessageController.h
//  Magic
//
//  Created by ytzhang on 15/11/10.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrivateMessageCell.h"
#import "MyWallet.h"


@interface PrivateMessageController : UIViewController
@property (nonatomic,retain)UIButton *button;
@property (nonatomic,retain)PrivateMessageCell *cell;
@property (nonatomic,retain)UIWindow *wid;
@property (nonatomic,retain)UIView *finishView;
@property (nonatomic,retain)  UIButton *didClickBtn;

@property (nonatomic,retain) NSMutableArray *cellArray ;
@property (nonatomic,retain) NSMutableArray *textFiledArray;
//@property (nonatomic,retain) UIButton *backBtn;
@property (nonatomic,retain) NSString *shopId; // 商品的id
@end
