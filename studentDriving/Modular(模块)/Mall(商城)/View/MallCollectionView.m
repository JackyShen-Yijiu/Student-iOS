//
//  MallCollectionView.m
//  studentDriving
//
//  Created by ytzhang on 16/3/9.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "MallCollectionView.h"
#import "YBIntegralMallCell.h"
#import "WMCommon.h"
#import "MagicDetailViewController.h"

static NSString *kMallID = @"MallID";
@interface MallCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation MallCollectionView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[YBIntegralMallCell class] forCellWithReuseIdentifier:kMallID];
        self.backgroundColor = [UIColor clearColor];
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:4];
    }
    return self;
}
#pragma mark - collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.shopMainListArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 加载积分商城
    
    YBIntegralMallCell *mallCell = [collectionView dequeueReusableCellWithReuseIdentifier:kMallID forIndexPath:indexPath];
    mallCell.integralMallModel = self.shopMainListArray[indexPath.row];
    return mallCell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 退出侧边栏
    if ([WMCommon getInstance].homeState==kStateMenu) {
        [[NSNotificationCenter defaultCenter] postNotificationName:KhiddenSlide object:self];
        return;
    }
    
    MagicDetailViewController *detailVC = [[MagicDetailViewController alloc] init];
    detailVC.integralModel = _shopMainListArray[indexPath.row];
    detailVC.mallWay = 0;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - collectionView flowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 机型适配
    
    if (kSystemHeight < 667) {
        // iphone 5
        return CGSizeMake((kSystemWide - 1) / 2, 219);
    } else if (kSystemHeight > 667) {
        // iphone 6p
        return CGSizeMake((kSystemWide - 1) / 2, 269);
    } else{
        // iphone 6
        return CGSizeMake((kSystemWide - 1) / 2, 249);
    }
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
// 行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}
// 列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

@end
