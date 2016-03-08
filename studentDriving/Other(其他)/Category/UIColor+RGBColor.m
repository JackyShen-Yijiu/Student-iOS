//
//  UIColor+RGBColor.m
//  BlackCat
//
//  Created by bestseller on 15/9/24.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "UIColor+RGBColor.h"

@implementation UIColor (RGBColor)



+ (UIColor *)colorWithRGBString:(NSString *)rgbString {
    if (!rgbString || [rgbString isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    
    NSRange range;
    
    range.length = 2 ;
    range.location = 1;

    [[NSScanner scannerWithString:[rgbString substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[rgbString substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[rgbString substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
}
@end
