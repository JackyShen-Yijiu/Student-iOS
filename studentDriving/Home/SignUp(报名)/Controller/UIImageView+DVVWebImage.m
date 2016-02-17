//
//  UIImageView+DVVWebImage.m
//  studentDriving
//
//  Created by 大威 on 16/2/17.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "UIImageView+DVVWebImage.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (DVVWebImage)

- (void)dvv_downloadImage:(NSString *)urlString {
    
    if (urlString && urlString.length) {
        [self sd_setImageWithURL:[NSURL URLWithString:urlString]];
    }
}

- (void)dvv_downloadImage:(NSString *)urlString
         placeholderImage:(UIImage *)placeholder {
    
    if (urlString && urlString.length) {
        [self sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:placeholder];
    }
}

@end
