//
//  DVVCycleShowImagesView.h
//  studentDriving
//
//  Created by 大威 on 15/12/14.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVVCycleShowImagesView : UIView

typedef void(^dvvCycleShowImagesViewTouchUpInsideBlock)(NSUInteger selectedIdx);

//未下载成功、预显示的替换图片
@property (nonatomic, strong) UIImage * placeImage;
@property (nonatomic, copy) NSString * placeImageurl;

//存储所有图片路径
@property (nonatomic, strong) NSArray * imagesUrlArray;

/**
 *  设置PageControl的位置和是否循环播放
 *
 *  @param location PageControl的位置(0:左侧, 1:中间, 2:右侧)
 *  @param cycle    是否轮播
 */
- (void)setPageControlLocation:(NSUInteger)location
                       isCycle:(BOOL)cycle;

/**
 *  点击图片的回调方法
 *
 *  @param handle 返回选择的图片的Index
 */
- (void)dvvCycleShowViewTouchUpInside:(dvvCycleShowImagesViewTouchUpInsideBlock)handle;

/**
 *  更新图片
 *
 *  @param array 存储图片Url的数组
 */
- (void)reloadDataWithArray:(NSArray *)array;

@end
