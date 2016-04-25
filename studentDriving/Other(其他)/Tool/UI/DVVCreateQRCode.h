//
//  DVVCreateQRCode.h
//  DVVTest_CIFilter
//
//  Created by 大威 on 16/1/8.
//  Copyright © 2016年 DaWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVVCreateQRCode : NSObject

/**
 *  根据传入的字符串生成一个二维码图片
 *
 *  @param string 内容
 *  @param size   图片的大小
 *
 *  @return 生成的二维码
 */
+ (UIImage *)createQRCodeWithContent:(NSString *)string size:(CGFloat)size;


/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;

@end
