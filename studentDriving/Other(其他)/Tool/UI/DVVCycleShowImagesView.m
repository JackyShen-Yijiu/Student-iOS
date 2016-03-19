//
//  DVVCycleShowImagesView.m
//  studentDriving
//
//  Created by 大威 on 15/12/14.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "DVVCycleShowImagesView.h"
#import "UIImageView+WebCache.h"
//#define VIEW_WIDTH [UIScreen mainScreen].bounds.size.width
#define VIEW_WIDTH self.bounds.size.width
#define VIEW_HEIGHT self.bounds.size.height

@interface DVVCycleShowImagesView()<UIScrollViewDelegate>

//用于回调用的Block
@property (nonatomic, copy) dvvCycleShowImagesViewTouchUpInsideBlock imageTUIBlock;

//用于滚动展示图片
@property (nonatomic, strong) UIScrollView * scrollView;

//UIPageControl的位置（左侧、中间、右侧）
@property (nonatomic, assign) NSUInteger pageControlLocation;

//标示现在显示的是第几张图片
@property (nonatomic, strong) UIPageControl * pageControl;

//循环复用的3个UIImageView
@property (nonatomic, strong) UIImageView * leftImageView;
@property (nonatomic, strong) UIImageView * centerImageView;
@property (nonatomic, strong) UIImageView * rightImageView;

//自动循环播放的计时器
@property (nonatomic, strong) NSTimer * cycleTimer;

//是否循环播放
@property (nonatomic, assign) BOOL isCycle;

@end

@implementation DVVCycleShowImagesView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.scrollView];
        
        [self.scrollView addSubview:self.leftImageView];
        [self.scrollView addSubview:self.centerImageView];
        [self.scrollView addSubview:self.rightImageView];
        
        [self addSubview:self.pageControl];
        
        [self initialProperty];
       
        
    }
    return self;
}

//初始化属性
- (void)initialProperty {
    
    _placeImage = nil;
    _pageControlLocation = 2;
    _isCycle = 1;
}

- (void)setPlaceImage:(UIImage *)placeImage {
    if (placeImage) {
        _leftImageView.image = placeImage;
        _centerImageView.image = placeImage;
        _rightImageView.image = placeImage;
        _centerImageView.backgroundColor = [UIColor orangeColor];
    }
}

//设置数据
- (void)setPageControlLocation:(NSUInteger)location
                       isCycle:(BOOL)cycle {
    
    _pageControlLocation = location;
    _isCycle = cycle;
}

//刷新数据
- (void)reloadDataWithArray:(NSArray *)array {
    
    NSLog(@"刷新数据array:%@",array);
    
    self.imagesUrlArray = array;
    self.pageControl.numberOfPages = self.imagesUrlArray.count;
    self.pageControl.currentPage = 0;
    [self setPageControlFrame];
    [self loadImages];
    
    if (_isCycle) {
        if (_imagesUrlArray.count > 1) {
            [self beginCycle];
        }else {
            [self endCycle];
        }
    }

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _scrollView.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    _leftImageView.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    _centerImageView.frame = CGRectMake(VIEW_WIDTH, 0, VIEW_WIDTH, VIEW_HEIGHT);
    _rightImageView.frame = CGRectMake(VIEW_WIDTH * 2, 0, VIEW_WIDTH, VIEW_HEIGHT);
    _pageControl.numberOfPages = _imagesUrlArray.count;
    
    // 绘制渐变颜色
    UIImage *maskImg = [UIImage imageNamed:@"shade"];
    [maskImg resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch];
    UIImageView *maskView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 64)];
    maskView.alpha = 0.1;
    maskView.image = maskImg;
    [self addSubview:maskView];

//    _leftImageView.maskView = maskView;
//    _centerImageView.maskView = maskView;
//    _rightImageView.maskView = maskView;
    
    [self setPageControlFrame];
    _pageControl.currentPage = 0;
    [self reloadDataWithArray:_imagesUrlArray];
    
}

#pragma mark - 设置点击图片的回调方法 method

- (void)dvvCycleShowViewTouchUpInside:(dvvCycleShowImagesViewTouchUpInsideBlock)handle {
    
    self.imageTUIBlock = handle;
}

- (void)imageClickAction {
    
    if (self.imageTUIBlock && self.imagesUrlArray.count) {
        
        self.imageTUIBlock(self.pageControl.currentPage);
    }
}

#pragma mark - 计时器 method

- (void)beginCycle {
    [self endCycle];
    self.cycleTimer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(cycleTimerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.cycleTimer forMode:NSDefaultRunLoopMode];
}

- (void)cycleTimerAction {
    
    if (self.imagesUrlArray.count) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.scrollView.contentOffset = CGPointMake(VIEW_WIDTH * 2, 0);
        }];
        [self reloadImage];
    }
}

- (void)endCycle {
    
    [self.cycleTimer invalidate];
}

#pragma mark - UIScrollViewDelegate method
//完成减速时执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self reloadImage];
}

#pragma mark - 加载显示的图片，设置当前显示的是第几个图片
- (void)reloadImage {
    
    [self setCurrentPage];
    [self loadImages];
}

#pragma mark - 设置当前显示的图片 method
- (void)setCurrentPage {
    
    if (!_imagesUrlArray.count) {
        return;
    }
    NSInteger currentPage;
    //判断滑动的方向
    //向右
    if (_scrollView.contentOffset.x < VIEW_WIDTH) {
        
        currentPage = _pageControl.currentPage - 1;
        if (currentPage < 0) {
            currentPage = _imagesUrlArray.count - 1;
        }
        _pageControl.currentPage = currentPage;
        
    }else { //向左
        
        currentPage = _pageControl.currentPage + 1;
        if (currentPage > _imagesUrlArray.count - 1) {
            currentPage = 0;
        }
        _pageControl.currentPage = currentPage;
    }
}

#pragma mark - 滑动过后重置位置、刷新图片 method
- (void)loadImages {
    
    if (!_imagesUrlArray.count) {
        self.scrollView.contentOffset = CGPointMake(VIEW_WIDTH, 0);
        return;
    }
    NSUInteger maxIdx = _imagesUrlArray.count - 1;
    NSUInteger currentIdx = _pageControl.currentPage;
    NSInteger left;
    NSUInteger center;
    NSUInteger right;
    
    left = currentIdx - 1;
    if (left < 0) {
        left = maxIdx;
    }
    
    center = currentIdx;
    
    right = currentIdx + 1;
    if (right > maxIdx) {
        right = 0;
    }
    //下载并缓存图片
    [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:_imagesUrlArray[center]] placeholderImage:self.placeImage options:SDWebImageLowPriority | SDWebImageRetryFailed];
    self.scrollView.contentOffset = CGPointMake(VIEW_WIDTH, 0);
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:_imagesUrlArray[left]] placeholderImage:self.placeImage options:SDWebImageLowPriority | SDWebImageRetryFailed];
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:_imagesUrlArray[right]] placeholderImage:self.placeImage options:SDWebImageLowPriority | SDWebImageRetryFailed];
}

#pragma mark - 设置pageControl的坐标和大小 method
- (void)setPageControlFrame {
    if (_imagesUrlArray.count) {
        CGRect rect = self.frame;
        rect.origin.y = rect.size.height - 15;
        rect.size.height = 10;
        rect.size.width = _imagesUrlArray.count * 20.f;
        switch (_pageControlLocation) {
            case 0:
                rect.origin.x = 0;
                break;
            case 1:
            {
                rect.origin.x = VIEW_WIDTH / 2.f - rect.size.width / 2.f;
            }
                break;
            case 2:
                rect.origin.x = VIEW_WIDTH - rect.size.width;
                break;
            default:
                break;
        }
        _pageControl.frame = rect;
    }
}

#pragma mark - lazyLoad method

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.delegate = self;
        self.scrollView.contentSize = CGSizeMake(VIEW_WIDTH * 3, VIEW_HEIGHT);
        _scrollView.contentOffset = CGPointMake(VIEW_WIDTH, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [UIPageControl new];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    }
    return _pageControl;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView){
        _leftImageView = [UIImageView new];
        _leftImageView.backgroundColor = [UIColor clearColor];
    }
    return _leftImageView;
}
- (UIImageView *)centerImageView {
    if (!_centerImageView){
        _centerImageView = [UIImageView new];
        _centerImageView.backgroundColor = [UIColor clearColor];
        [self addTouchForImageView:_centerImageView];
    }
    return _centerImageView;
}

- (void)addTouchForImageView:(UIImageView *)imageView {
    
    UITapGestureRecognizer *touch = [UITapGestureRecognizer new];
    touch.numberOfTouchesRequired = 1;
    [touch addTarget:self action:@selector(imageClickAction)];
    [imageView addGestureRecognizer:touch];
    imageView.userInteractionEnabled = YES;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView){
        _rightImageView = [UIImageView new];
        _rightImageView.backgroundColor = [UIColor clearColor];
    }
    return _rightImageView;
}

- (NSTimer *)cycleTimer {
    if (!_cycleTimer) {
        _cycleTimer = [NSTimer new];
    }
    return _cycleTimer;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
