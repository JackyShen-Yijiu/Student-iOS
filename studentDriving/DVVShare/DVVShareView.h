//
//  DVVShareView.h
//  DVVTestUMSocial
//
//  Created by 大威 on 16/1/18.
//  Copyright © 2016年 DaWei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLLocation;
@class UMSocialUrlResource;

typedef void(^DVVShareViewSuccessBlock)(NSString *platformName);

@interface DVVShareView : UIView

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSString *shareTitle;
@property (nonatomic, strong) NSString *shareContent;
@property (nonatomic, strong) UIImage *shareImage;
@property (nonatomic, strong) UIViewController *presentedController;
@property (nonatomic, strong) CLLocation *shareLocation;
@property (nonatomic, strong) UMSocialUrlResource *shareUrlResource;

/**
 *  分享成功的回调
 *
 *  @param handle 回调
 */
- (void)setShareSuccessBlock:(DVVShareViewSuccessBlock)handle;

/**
 *  显示的方法
 */
- (void)show;

/**
 *  隐藏的方法
 */
- (void)hide;

/**
 *  刷新可以分享到的的平台
 */
- (void)refreshSharePlatform;

@end
