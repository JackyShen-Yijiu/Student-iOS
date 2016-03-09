//
//  Singleton.h
//  studentDriving
//
//  Created by JiangangYang on 16/3/9.
//  Copyright © 2016年 jatd. All rights reserved.
//

#ifndef Singleton_h
#define Singleton_h

// .h文件
#define WMSingletonH(name) + (instancetype)shared##name;

// .m文件
#define WMSingletonM(name) \
static id _instance; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}

#endif /* Singleton_h */
