//
//  DVVHorizontalScrollImagesView.h
//  DVVTest_内容横向滑动的CollectionView
//
//  Created by 大威 on 16/1/20.
//  Copyright © 2016年 DaWei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DVVHorizontalScrollImagesViewBlock)(NSInteger selectedIndex);

@interface DVVHorizontalScrollImagesView : UIView

@property (nonatomic, strong) NSArray *imagesUrlArray;

@property (nonatomic, strong) UIImage *defaultImage;

@property (nonatomic, assign) CGFloat imageWidth;
@property (nonatomic, assign) CGFloat imageHeight;

@property (nonatomic, assign) UIEdgeInsets edgeInset;
@property (nonatomic, assign) CGFloat lineSpace;

/**
 *  刷新数据的方法
 *
 *  @param array 图片URL数组
 */
- (void)refreshData:(NSArray *)array;

- (void)setSelectedItemBlock:(DVVHorizontalScrollImagesViewBlock)handle;

@end
