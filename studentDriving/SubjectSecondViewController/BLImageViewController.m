//
//  BLImageViewController.m
//  studentDriving
//
//  Created by bestseller on 15/11/12.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "BLImageViewController.h"
#import <SVProgressHUD.h>
@interface BLImageViewController ()
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIScrollView *scrollview;

@end

@implementation BLImageViewController
- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}
- (UIScrollView *)scrollview {
    if (_scrollview == nil) {
        _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight)];
        _scrollview.showsHorizontalScrollIndicator = NO;
        
    }
    return _scrollview;
}
- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollview];
    [self.scrollview addSubview:self.imageView];
    
    [SVProgressHUD show];
    __weak BLImageViewController *weakSelf = self;
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:self.videourl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {} completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        DYNSLog(@"进入 = %@",imageURL);

        [SVProgressHUD dismiss];
        if (image) {
            CGSize size = image.size;
            CGFloat rate =size.height/ size.width;
            weakSelf.imageView.frame = CGRectMake(0, 0, kSystemWide, kSystemWide*rate);
            weakSelf.imageView.image = image;
            [weakSelf.scrollview setContentSize:CGSizeMake(kSystemWide, kSystemWide*rate)];
        }
    }];
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}


@end
