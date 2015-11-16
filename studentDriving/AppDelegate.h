//
//  AppDelegate.h
//  BlackCat
//
//  Created by bestseller on 15/9/1.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMapKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate,IChatManagerDelegate>{
    BMKMapManager *_mapManager;
    EMConnectionState _connectionState;

}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,assign)BOOL allowRotation;

@end

