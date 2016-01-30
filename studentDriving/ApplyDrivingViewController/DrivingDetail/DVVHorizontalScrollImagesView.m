//
//  DVVHorizontalScrollImagesView.m
//  DVVTest_内容横向滑动的CollectionView
//
//  Created by 大威 on 16/1/20.
//  Copyright © 2016年 DaWei. All rights reserved.
//

#import "DVVHorizontalScrollImagesView.h"
#import "DVVHorizontalScrollImagesCell.h"
#import "SDWebImage/UIImageView+WebCache.h"

#define kCellIdentifier @"kCellIdentifier"

@interface DVVHorizontalScrollImagesView()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) DVVHorizontalScrollImagesViewBlock selectedBlock;

@end

@implementation DVVHorizontalScrollImagesView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _edgeInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _lineSpace = 10;
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _collectionView.frame = self.bounds;
}

- (void)refreshData:(NSArray *)array {
    _imagesUrlArray = array;
    [self.collectionView reloadData];
}

#pragma mark - collectionView delegate datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imagesUrlArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DVVHorizontalScrollImagesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.imageView.backgroundColor = [UIColor orangeColor];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:_imagesUrlArray[indexPath.row]]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_selectedBlock) {
        _selectedBlock(indexPath.row);
    }
}

#pragma mark - collectionView flowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(_imageWidth, _imageHeight);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return _edgeInset;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return _lineSpace;
}

#pragma mark - lazy load
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
        // 注册Cell
        [_collectionView registerClass:[DVVHorizontalScrollImagesCell class] forCellWithReuseIdentifier:kCellIdentifier];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

#pragma mark - set block
- (void)setSelectedItemBlock:(DVVHorizontalScrollImagesViewBlock)handle {
    _selectedBlock = handle;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
