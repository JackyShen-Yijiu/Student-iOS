//
//  DVVCrashHandler.m
//  DVVTest_CrashHandler
//
//  Created by 大威 on 16/3/3.
//  Copyright © 2016年 DaWei. All rights reserved.
//

#import "DVVCrashHandler.h"
#import <libkern/OSAtomic.h>
#import <execinfo.h>
#import "DVVToast.h"

NSString *const dvv_crashHandlerSignalExceptionName = @"dvv_crashHandlerSignalExceptionName";

NSString *const dvv_crashHandlerSignalKey = @"dvv_crashHandlerSignalKey";

NSString *const dvv_crashHandlerAddressesKey = @"dvv_crashHandlerAddressesKey";

volatile int32_t uncaughtExceptionCount = 0;
const integer_t uncaughtExceptionMaximum = 10;

const NSInteger uncaughtExceptionHandlerSkipAddressCount = 4;
const NSInteger uncaughtExceptionHandlerReportAddressCount = 5;

@implementation DVVCrashHandler

+ (NSArray *)backtrace {
    
    void* callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    
    int i;
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (i = uncaughtExceptionHandlerSkipAddressCount;
         i < uncaughtExceptionHandlerSkipAddressCount + uncaughtExceptionHandlerReportAddressCount;
         i++) {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    
    return backtrace;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    dismissed = YES;
}

- (void)handleException:(NSException *)exception {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"抱歉" message:@"由于一些错误导致程序将要关闭，我们会尽快处理，因此给您带来的不便，请谅解" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    
    [alertView show];
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
    
    while (!dismissed) {
        for (NSString *mode in (NSArray *)CFBridgingRelease(allModes)) {
            CFRunLoopRunInMode((CFStringRef)CFBridgingRetain(mode), 0.001, false);
        }
    }
    
    CFRelease(allModes);
    
    NSSetUncaughtExceptionHandler(NULL);
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
    
    if ([[exception name] isEqual:dvv_crashHandlerSignalExceptionName]) {
        kill(getpid(), [[[exception userInfo] objectForKey:dvv_crashHandlerSignalKey] intValue]);
    }else {
        [exception raise];
    }
}

@end

void handleException(NSException *exception) {
    
    int32_t exceptionCount = OSAtomicIncrement32(&uncaughtExceptionCount);
    if (exceptionCount > uncaughtExceptionMaximum) {
        return ;
    }
    
    NSArray *callStack = [DVVCrashHandler backtrace];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:[exception userInfo]];
    [userInfo setObject:callStack forKey:dvv_crashHandlerAddressesKey];
    
    [[DVVCrashHandler new] performSelectorOnMainThread:@selector(handleException:) withObject:[NSException exceptionWithName:[exception name] reason:[exception reason] userInfo:userInfo] waitUntilDone:YES];
}

void signalHandler(int signal) {
    
    int32_t exceptionCount = OSAtomicIncrement32(&uncaughtExceptionCount);
    if (exceptionCount > uncaughtExceptionMaximum) {
        return ;
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:signal] forKey:dvv_crashHandlerSignalKey];
    
    NSArray *callStack = [DVVCrashHandler backtrace];
    [userInfo setObject:callStack forKey:dvv_crashHandlerAddressesKey];
    
    [[DVVCrashHandler new] performSelectorOnMainThread:@selector(handleException:) withObject:[NSException exceptionWithName:dvv_crashHandlerSignalExceptionName reason:[NSString stringWithFormat:@"Signal %d was raised.", signal] userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:signal] forKey:dvv_crashHandlerSignalKey]] waitUntilDone:YES];
}

void dvv_installCrashExceptionHandler() {
    
    NSSetUncaughtExceptionHandler(&handleException);
    signal(SIGABRT, signalHandler);
    signal(SIGILL, signalHandler);
    signal(SIGSEGV, signalHandler);
    signal(SIGFPE, signalHandler);
    signal(SIGBUS, signalHandler);
    signal(SIGPIPE, signalHandler);
    
}
