//
//  JGTeachingNewsChangDiView.m
//  studentDriving
//
//  Created by JiangangYang on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//  训练场地

#import "JGTeachingNewsChangDiView.h"
#import "CoachDetail.h"
#import "MWPhotoBrowser.h"

@interface photoViewCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *photoView;

@property (nonatomic,copy) NSString *picStr;

@end

@implementation photoViewCell

- (UIImageView *)photoView
{
    if (_photoView == nil) {
        _photoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (kSystemWide-2*10-20)/3, 70)];
        _photoView.backgroundColor = [UIColor clearColor];
    }
    return _photoView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.photoView];
    }
    return self;
}

- (void)setPicStr:(NSString *)picStr
{
    _picStr = picStr;
    
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",picStr]] placeholderImage:[UIImage imageNamed:@"littleImage.png"]];
    
}

@end


@interface JGTeachingNewsChangDiView ()<UICollectionViewDataSource,UICollectionViewDelegate,MWPhotoBrowserDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *photosArray;

@property (strong, nonatomic) MWPhotoBrowser *photoBrowser;

@property (strong, nonatomic) UINavigationController *photoNavigationController;

@property (strong, nonatomic) UIWindow *keyWindow;

@end

@implementation JGTeachingNewsChangDiView

- (UICollectionView *)collectionView {
    
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake((kSystemWide-2*10-20)/3, 70);
        //水平滑动
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide-2*10,70) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[photoViewCell class] forCellWithReuseIdentifier:@"photoViewCell"];
        
    }
    return _collectionView;
}


- (UIWindow *)keyWindow
{
    if(_keyWindow == nil)
    {
        _keyWindow = [[UIApplication sharedApplication] keyWindow];
    }
    
    return _keyWindow;
}

- (NSMutableArray *)photosArray
{
    if (_photosArray == nil) {
        _photosArray = [[NSMutableArray alloc] init];
    }
    return _photosArray;
}

- (MWPhotoBrowser *)photoBrowser
{
    if (_photoBrowser == nil) {
        _photoBrowser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        _photoBrowser.displayActionButton = YES;
        _photoBrowser.displayNavArrows = YES;
        _photoBrowser.displaySelectionButtons = NO;
        _photoBrowser.alwaysShowControls = NO;
        _photoBrowser.wantsFullScreenLayout = YES;
        _photoBrowser.zoomPhotosToFill = YES;
        _photoBrowser.enableGrid = NO;
        _photoBrowser.startOnGrid = NO;
        [_photoBrowser setCurrentPhotoIndex:0];
    }
    
    return _photoBrowser;
}

- (UINavigationController *)photoNavigationController
{
    if (_photoNavigationController == nil) {
        _photoNavigationController = [[UINavigationController alloc] initWithRootViewController:self.photoBrowser];
        _photoNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    [self.photoBrowser reloadData];
    return _photoNavigationController;
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return [self.photosArray count];
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < self.photosArray.count)
    {
        return [self.photosArray objectAtIndex:index];
    }
    
    return nil;
}


#pragma mark - private


#pragma mark - public

- (void)showBrowserWithImages:(NSArray *)imageArray
{
    if (imageArray && [imageArray count] > 0) {
        
        NSMutableArray *photoArray = [NSMutableArray array];
        
        for (id object in imageArray) {
            
            NSLog(@"object:%@",object);
            
            MWPhoto *photo;
            
            if ([object isKindOfClass:[UIImage class]]) {
                NSLog(@"UIImage");
                photo = [MWPhoto photoWithImage:object];
            }
            else if ([object isKindOfClass:[NSURL class]])
            {
                NSLog(@"NSURL");
                photo = [MWPhoto photoWithURL:object];
            }
            else if ([object isKindOfClass:[NSString class]])
            {
                NSLog(@"NSString");
                photo = [MWPhoto photoWithURL:[NSURL URLWithString:object]];
            }
            [photoArray addObject:photo];
        }
        
        self.photosArray = photoArray;
    }
    
    UIViewController *rootController = [self.keyWindow rootViewController];
    [rootController presentViewController:self.photoNavigationController animated:YES completion:nil];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.collectionView];
        
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"self.pictures.count:%lu",self.pictures.count);
    
    return self.pictures.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"photoViewCell";
    photoViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    NSLog(@"self.pictures[indexPath.item]:%@",self.pictures[indexPath.item]);
    
    cell.picStr = self.pictures[indexPath.item];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [_photoBrowser setCurrentPhotoIndex:indexPath.row];
    
    [self showBrowserWithImages:self.pictures];
    
}

- (void)setPictures:(NSArray *)pictures
{
    _pictures = pictures;
    
    [self.collectionView reloadData];
}

@end
