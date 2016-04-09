//
//  DVVCrashHandler.h
//  DVVTest_CrashHandler
//
//  Created by 大威 on 16/3/3.
//  Copyright © 2016年 DaWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVVCrashHandler : NSObject

{
    BOOL dismissed;
}

void dvv_installCrashExceptionHandler();

@end
