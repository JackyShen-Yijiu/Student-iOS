//
//  UIImageView+DVVWebImage.h
//  studentDriving
//
//  Created by 大威 on 16/2/17.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (DVVWebImage)

- (void)dvv_downloadImage:(NSString *)urlString;

- (void)dvv_downloadImage:(NSString *)urlString
         placeholderImage:(UIImage *)placeholder;

@end
