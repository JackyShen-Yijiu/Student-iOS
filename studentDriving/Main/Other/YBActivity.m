//
//  YBActivity.m
//  studentDriving
//
//  Created by 大威 on 16/2/29.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBActivity.h"
#import "DVVLocation.h"
#import "DVVCheckActivity.h"
#import "HomeActivityController.h"

@implementation YBActivity

+ (void)checkActivity {
    
//    [self checkActivityWithCityName:@"北京"];

    // 检查是否有活动
//        [DVVCheckActivity test]; //测试活动时打开此注释
    if ([DVVCheckActivity checkActivity]) {
        
        [DVVLocation reverseGeoCode:^(BMKReverseGeoCodeResult *result, CLLocationCoordinate2D coordinate, NSString *city, NSString *address) {
            
            [self checkActivityWithCityName:city];
            
        } error:^{
            ;
        }];
    }
}

#pragma mark - 检查是否有活动
+ (void)checkActivityWithCityName:(NSString *)cityName {
    
    NSString *urlString = [NSString stringWithFormat:@"getactivity"];
    NSString *url = [NSString stringWithFormat:BASEURL,urlString];
    NSLog(@"userCity === %@", cityName);
    [JENetwoking startDownLoadWithUrl:url postParam:@{ @"cityname": cityName } WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"%@",data);
        [self loadActivityWithData:data];
        
    } withFailure:^(id data) {
        
    }];
}
+ (void)loadActivityWithData:(id)data {
    
    BOOL flage = NO;
    NSDictionary *rootDict = data;
    if (![rootDict objectForKey:@"type"]) {
        flage = YES;
    }
    if (![[rootDict objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
        flage = YES;
    }
    NSArray *array = [rootDict objectForKey:@"data"];
    if (![array isKindOfClass:[NSArray class]]) {
        flage = YES;
    }
    NSDictionary *paramsDict = [array firstObject];
    if (![paramsDict isKindOfClass:[NSDictionary class]]) {
        flage = YES;
    }
    if (flage) {
//        [self showMsg:@"暂时还没有活动哟"];
        return ;
    }
    
//                        id:item._id,
//                    name:item.name,
//                    titleimg:item.titleimg,
//                    begindate:item.begindate,
//                    contenturl:item.contenturl,
//                    enddate:item.enddate,
//                    address:item.address,
    NSString *title = @"一步活动";
    NSString *contentUrl = @"";
    if ([paramsDict objectForKey:@"name"]) {
        title = [paramsDict objectForKey:@"name"];
    }
    if ([paramsDict objectForKey:@"contenturl"]) {
        contentUrl = [paramsDict objectForKey:@"contenturl"];
    }
    static HomeActivityController *_activityVC = nil;
    _activityVC = [HomeActivityController new];
    _activityVC.title = title;
    _activityVC.activityUrl = contentUrl;
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
//    UINavigationController *naviVC = (UINavigationController *)(window.rootViewController);
//    [naviVC pushViewController:activityVC animated:NO];
    [window addSubview:_activityVC.view];
}

@end
