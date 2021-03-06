//
//  DVVShare.m
//  studentDriving
//
//  Created by 大威 on 16/1/25.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVShare.h"
#import "DVVShareView.h"
#import <UMSocialSnsData.h>

@implementation DVVShare

+ (void)shareWithTitle:(NSString *)title
               content:(NSString *)content
                 image:(UIImage *)image
              location:(CLLocation *)location
                   url:(NSString *)url
               success:(DVVShareSuccessBlock)success {
    
    UMSocialUrlResource *urlResource = [UMSocialUrlResource new];
    if (!url) {
        urlResource.url = DVV_Share_Default_Url;
    }else {
        urlResource.url = url;
    }
    
    DVVShareView *shareView = [DVVShareView new];
    shareView.frame = [UIScreen mainScreen].bounds;
    shareView.shareTitle = title;
    shareView.shareContent = content;
    shareView.shareImage = image;
    shareView.shareLocation = location;
    shareView.shareUrlResource = urlResource;
    shareView.presentedController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [shareView setShareSuccessBlock:^(NSString *platformName) {
        success(platformName);
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:shareView];
    [shareView show];
    
    
}

@end
