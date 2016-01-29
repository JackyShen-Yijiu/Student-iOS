//
//  JGTeachingNewsChangDiView.m
//  studentDriving
//
//  Created by JiangangYang on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//  训练场地

#import "JGTeachingNewsChangDiView.h"
#import "CoachDetail.h"

@interface photoViewCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *photoView;

@property (nonatomic,copy) NSString *picStr;

@end

@implementation photoViewCell

- (UIImageView *)photoView
{
    if (_photoView == nil) {
        _photoView = [[UIImageView alloc] initWithFrame:self.bounds];
        _photoView.backgroundColor = [UIColor clearColor];
    }
    return _photoView;
}

- (void)setPicStr:(NSString *)picStr
{
    _picStr = picStr;
    
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",picStr]] placeholderImage:[UIImage imageNamed:@"littleImage.png"]];
    
}

@end


@interface JGTeachingNewsChangDiView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation JGTeachingNewsChangDiView

- (UICollectionView *)collectionView {
    
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 12;
        //水平滑动
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 5, 194/2, 120/2) collectionViewLayout:flowLayout];
       
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[photoViewCell class] forCellWithReuseIdentifier:@"photoViewCell"];
        
    }
    return _collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor yellowColor];
        
        [self addSubview:self.collectionView];
        
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.detailModel.trainFieldInfo.pictures.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"photoViewCell";
    photoViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.picStr = self.detailModel.trainFieldInfo.pictures[indexPath.item];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    photoViewCell *cell = (photoViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSLog(@"cell.picStr:%@",cell.picStr);
    
}

@end
