//
//  DVVShare.h
//  studentDriving
//
//  Created by 大威 on 16/1/25.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVVShareHeader.h"
@class UMSocialUrlResource;

typedef void(^DVVShareSuccessBlock)(NSString *platformName);

@interface DVVShare : NSObject

+ (void)shareWithTitle:(NSString *)title
               content:(NSString *)content
                 image:(UIImage *)image
              location:(CLLocation *)location
           urlResource:(UMSocialUrlResource *)urlResource
               success:(DVVShareSuccessBlock)success;

@end
