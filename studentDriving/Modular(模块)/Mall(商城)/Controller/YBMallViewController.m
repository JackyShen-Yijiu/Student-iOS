//
//  YBMallViewController.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBMallViewController.h"
#import "YBIntegralMallCell.h"
#import "YBIntegralMallModel.h"
#import "YBDiscountModel.h"
#import "YBDiscountCell.h"
#import "MagicDetailViewController.h"
#import "UIView+CalculateUIView.h"
#import "WMCommon.h"
#import <MJRefresh.h>
#import "MallCollectionView.h"
#import "DiscountCollectionView.h"

static NSString *const kGetMySaveCoach = @"userinfo/favoritecoach";

static NSString *const kGetMySaveSchool = @"userinfo/favoriteschool";

static NSString *const kDeleteMySaveCoach = @"userinfo/favoritecoach";

static NSString *const kDeleteMySaveSchool = @"userinfo/favoriteschool";

typedef NS_ENUM(NSUInteger,MallType){
    kIntegralMall,
    kDiscountMall
};

@interface YBMallViewController ()<UIScrollViewDelegate>
{
    UIImageView*navBarHairlineImageView;
}

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic,retain) NSMutableArray *shopMainListArray; // 积分商城

@property (nonatomic,retain) NSMutableArray *discountArray; // 兑换劵商城

@property (strong, nonatomic) UIView *menuIndicator;

@property (nonatomic, strong) NSMutableArray *buttonArray;

@property (nonatomic, assign) MallType mallType;

@property (nonatomic,assign) NSInteger index;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) MallCollectionView *mallCollectionView;

@property (nonatomic, strong) DiscountCollectionView *discountCollectionView;

@end

static NSString *kMagicShop = @"getmailproduct";
static NSString *kDiscountShop = @"getmailproduct";
static NSString *kMallID = @"MallID";

@implementation YBMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.shopMainListArray = [[NSMutableArray alloc] init];
    self.discountArray = [[NSMutableArray alloc] init];
    self.title = @"商城";
    _mallType = kIntegralMall;
    [self initMallMoreData:NO];
    _index = 1;
     self.view.backgroundColor = [UIColor colorWithHexString:@"e8e8ed"];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.mallCollectionView];
    [self.scrollView addSubview:self.discountCollectionView];
    [self.view addSubview:[self tableViewHeadView]];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // 隐藏导航条底部分割线
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden=YES;
    
    [self initMallMoreData:NO];
    [self initDiscountMoreData:NO];
    [self refresh];
    
}
-(void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
}
- (UIImageView*)findHairlineImageViewUnder:(UIView*)view {
    
    if([view isKindOfClass:UIImageView.class] && view.bounds.size.height<=1.0) {
        return(UIImageView*)view;
    }
    for(UIView*subview in view.subviews) {
        UIImageView*imageView = [self findHairlineImageViewUnder:subview];
        if(imageView) {
            return imageView;
        }
    }
    return nil;
}

#pragma mark --------加载数据
- (void)initMallMoreData:(BOOL)isMoreData{
// 积分商城数据
    // 加载积分商城数据
    NSString *urlString = [NSString stringWithFormat:BASEURL,kMagicShop];
    NSLog(@"%@",urlString);
    NSDictionary *parm = @{@"cityname":@"北京",
                           @"index":@"1",
                           @"count":@"10",
                           @"producttype":@"0"};
    //    NSLog(@"%@",[AcountManager manager].userCity);
    [JENetwoking startDownLoadWithUrl:urlString postParam:parm WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        DYNSLog(@"data = %@",data);
        if (data == nil) {
            return ;
        }
        NSDictionary *dataDic = [data objectForKey:@"data"];
        
        {
            NSArray *array = [dataDic objectForKey:@"mainlist"];
            if (array.count == 0) {
                [self obj_showTotasViewWithMes:@"还没有商品哦!"];
                 [self.collectionView.mj_header endRefreshing];
                return;
            }
            [self.shopMainListArray removeAllObjects];
            for (NSDictionary *dic in array)
            {
                YBIntegralMallModel *mainDodel = [[YBIntegralMallModel alloc] init];
                [mainDodel setValuesForKeysWithDictionary:dic];
                [self.shopMainListArray addObject:mainDodel];
                [self.collectionView.mj_header endRefreshing];
            }
        }
         self.mallCollectionView.shopMainListArray = self.shopMainListArray;
        self.mallCollectionView.viewController = self;
        [self.mallCollectionView reloadData];
    } withFailure:^(id data) {
         [self.collectionView.mj_header endRefreshing];
    }];

}
- (void)initDiscountMoreData:(BOOL)isMoreData{
    // 优惠劵商城数据
    // 加载兑换劵商城数据
    NSString *urlString = [NSString stringWithFormat:BASEURL,kDiscountShop];
    NSLog(@"%@",urlString);
    NSDictionary *parm = @{@"cityname":@"北京",
                           @"index":@"1",
                           @"count":@"10",
                           @"producttype":@"1"};
    //    NSLog(@"%@",[AcountManager manager].userCity);
    [JENetwoking startDownLoadWithUrl:urlString postParam:parm WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        DYNSLog(@"data = %@",data);
        if (data == nil) {
            return ;
        }
        NSDictionary *dataDic = [data objectForKey:@"data"];
        
        {
            NSArray *array = [dataDic objectForKey:@"mainlist"];
            if (array.count == 0) {
                [self obj_showTotasViewWithMes:@"还没有商品哦!"];
                [self.collectionView.mj_header endRefreshing];
                return;
            }
            [self.discountArray removeAllObjects];
            for (NSDictionary *dic in array)
            {
                YBDiscountModel *mainDodel = [[YBDiscountModel alloc] init];
                [mainDodel setValuesForKeysWithDictionary:dic];
                [self.discountArray addObject:mainDodel];
                
                [self.collectionView.mj_header endRefreshing];
            }
        }
        self.discountCollectionView.discountArray = self.discountArray;
        self.discountCollectionView.viewController = self;
        [self.discountCollectionView reloadData];
    }withFailure:^(id data) {
         [self.collectionView.mj_header endRefreshing];
    } ];

}

- (void)refresh{
    
        __weak typeof(self) ws = self;
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if (_mallType == kIntegralMall) {
                [ws initMallMoreData:NO];
                _mallCollectionView.mj_header = header;
                
            }else {
                [ws initDiscountMoreData:NO];
                 _discountCollectionView.mj_header = header;
            }
        }];
   

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
#pragma mark - bntAciton
// 积分商城
- (void)clickLeftBtn:(UIButton *)sender {
    for (UIButton *b in self.buttonArray) {
        b.selected = NO;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.menuIndicator.frame = CGRectMake(0, self.menuIndicator.calculateFrameWithY, self.menuIndicator.calculateFrameWithWide, self.menuIndicator.calculateFrameWithHeight);
    }];
    sender.selected = YES;
    _mallType = kIntegralMall;
//    [self initMallMoreData:NO];
    CGFloat contentOffsetX = 0;
    [UIView animateWithDuration:0.5 animations:^{
                _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
    }];

}
// 兑换劵商城
- (void)clickRightBtn:(UIButton *)sender {
    for (UIButton *b in self.buttonArray) {
        b.selected = NO;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.menuIndicator.frame = CGRectMake(kSystemWide/2, self.menuIndicator.calculateFrameWithY, self.menuIndicator.calculateFrameWithWide, self.menuIndicator.calculateFrameWithHeight);
    }];
    sender.selected = YES;
    _mallType = kDiscountMall;
//    [self initDiscountMoreData:NO];
    CGFloat contentOffsetX = kSystemWide;
    [UIView animateWithDuration:0.5 animations:^{
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
    }];
}
#pragma mark -- UIScrollerView 的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat width = self.view.frame.size.width;
    if (0 == scrollView.contentOffset.x) {
        // 积分商城
//        _mallType = kIntegralMall;
        [self selectLeftItem:500];
    }
    if (width == scrollView.contentOffset.x) {
        // 优惠劵商城
        [self selectItem:501];
        
        
    }

}

- (void)selectItem:(NSInteger)tag{
    for (UIButton *btn in self.buttonArray) {
        if (btn.tag == tag) {
            [self clickRightBtn:btn];
        }
    }
}
- (void)selectLeftItem:(NSInteger)tag{
    for (UIButton *btn in self.buttonArray) {
        if (btn.tag == tag) {
            [self clickLeftBtn:btn];
        }
    }
}
#pragma mark - lazy load
- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight - 94)];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(2 * kSystemWide, 0);
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}
- (MallCollectionView *)mallCollectionView {
    if (!_mallCollectionView) {
        
        // 自动布局方式
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _mallCollectionView = [[MallCollectionView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 160) collectionViewLayout:flowLayout];
        // 注册Cell
        
    }
    return _mallCollectionView;
}
- (DiscountCollectionView *)discountCollectionView {
    if (!_discountCollectionView) {
        
        // 自动布局方式
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _discountCollectionView = [[DiscountCollectionView alloc] initWithFrame:CGRectMake(kSystemWide, 44, self.view.frame.size.width, self.view.frame.size.height - 110) collectionViewLayout:flowLayout];
        // 注册Cell
        
    }
    return _discountCollectionView;
}

- (UIView *)menuIndicator {
    if (_menuIndicator == nil) {
        _menuIndicator = [[UIView alloc] initWithFrame:CGRectMake(5,44-2, (kSystemWide - 10) / 2, 2)];
        _menuIndicator.backgroundColor = YBNavigationBarBgColor;
    }
    return _menuIndicator;
}
- (NSMutableArray *)buttonArray {
    if (_buttonArray == nil) {
        _buttonArray = [[NSMutableArray alloc] init];
    }
    return _buttonArray;
}

- (UIView *)tableViewHeadView {
    // 背景
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 44)];
    backGroundView.backgroundColor = [UIColor whiteColor];
    backGroundView.layer.shadowColor = RGBColor(204, 204, 204).CGColor;
    backGroundView.layer.shadowOffset = CGSizeMake(0, 1);
    backGroundView.layer.shadowOpacity = 0.08;
    backGroundView.userInteractionEnabled = YES;
    // 积分商城
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:@"积分商城" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor colorWithHexString:@"6e6e6e"] forState:UIControlStateNormal];
    leftButton.selected = YES;
    leftButton.tag = 500;
    [leftButton addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [leftButton setTitleColor:YBNavigationBarBgColor forState:UIControlStateSelected];
    [backGroundView addSubview:leftButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backGroundView.mas_left).offset(0);
        make.top.mas_equalTo(backGroundView.mas_top).offset(0);
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide/2];
        make.width.mas_equalTo(height);
        make.height.mas_equalTo(@44);
    }];
    [self.buttonArray addObject:leftButton];
    // 兑换劵商城
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"兑换劵商城" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor colorWithHexString:@"6e6e6e"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    rightButton.tag = 501;

    [rightButton setTitleColor:YBNavigationBarBgColor forState:UIControlStateSelected];
    [backGroundView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(backGroundView.mas_right).offset(0);
        make.top.mas_equalTo(backGroundView.mas_top).offset(0);
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide/2];
        make.width.mas_equalTo(height);
        make.height.mas_equalTo(@44);
    }];
    [self.buttonArray addObject:rightButton];
    
    [backGroundView addSubview:self.menuIndicator];
    
    // 添加底部的阴影效果
    backGroundView.layer.shadowColor = [UIColor blackColor].CGColor;
    backGroundView.layer.shadowOffset = CGSizeMake(0, 2);
    backGroundView.layer.shadowOpacity = 0.3;
    backGroundView.layer.shadowRadius = 2;
    
    return backGroundView;
}

@end
