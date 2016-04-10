//
//  DiscountCollectionView.m
//  studentDriving
//
//  Created by ytzhang on 16/3/9.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DiscountCollectionView.h"
#import "YBDiscountCell.h"
#import "WMCommon.h"
#import "MagicDetailViewController.h"
static NSString *kMallID = @"discountID";
@interface DiscountCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation DiscountCollectionView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[YBDiscountCell class] forCellWithReuseIdentifier:kMallID];
        self.backgroundColor = [UIColor clearColor];
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:4];

    }
    return self;
}
#pragma mark - collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.discountArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 加载积分商城
    
    YBDiscountCell *mallCell = [collectionView dequeueReusableCellWithReuseIdentifier:kMallID forIndexPath:indexPath];
    mallCell.discountModel = self.discountArray[indexPath.row];
    return mallCell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
        // 退出侧边栏
        if ([WMCommon getInstance].homeState==kStateMenu) {
            [[NSNotificationCenter defaultCenter] postNotificationName:KhiddenSlide object:self];
            return;
        }
    
                    // 兑换劵商城详情
            MagicDetailViewController *detailVC = [[MagicDetailViewController alloc] init];
            detailVC.discountModel = _discountArray[indexPath.row];
            detailVC.mallWay = 1;
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
