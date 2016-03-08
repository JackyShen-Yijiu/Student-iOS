//
//  DVVCheckAppNewVersion.m
//  studentDriving
//
//  Created by 大威 on 16/2/2.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVCheckAppNewVersion.h"
#import "JENetwoking.h"

@implementation DVVCheckAppNewVersion

+ (void)checkAppNewVersion {
    
    NSString *urlString = @"http://itunes.apple.com/lookup?id=1060105429";
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"%@", data);
    } withFailure:^(id data) {
        
    }];
}

@end
