//
//  YBMyWalletMallViewController.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBMyWalletMallViewController.h"
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
#import "JZExchangeRecordController.h"

#define HeaderViewH 48

static NSString *const kIntegralMallURl = @"userinfo/getmywallet?userid=%@&usertype=1&seqindex=0&count=10";

typedef NS_ENUM(NSUInteger,MallType){
    kIntegralMall,
    kDiscountMall
};

@interface YBMyWalletMallViewController ()<UIScrollViewDelegate>
{
    UIImageView*navBarHairlineImageView;
}

@property (nonatomic,retain) NSMutableArray *shopMainListArray; // 积分商城

@property (nonatomic, strong) NSMutableArray *buttonArray;

@property (nonatomic, assign) MallType mallType;

@property (nonatomic,assign) NSInteger index;

@property (nonatomic, strong) MallCollectionView *mallCollectionView;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *titleLable;

@property (nonatomic, strong) UILabel *resultLabel;

@property (nonatomic, strong) UIButton *exangeButton;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, assign) NSInteger integralNumber;
@end

static NSString *kMagicShop = @"getmailproduct";
static NSString *kDiscountShop = @"getmailproduct";
static NSString *kMallID = @"MallID";

@implementation YBMyWalletMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.shopMainListArray = [[NSMutableArray alloc] init];
    self.title = @"商城";
    _mallType = kIntegralMall;
    [self initMallMoreData:NO];
    _index = 1;
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"e8e8ed"];
    [self.view addSubview:self.mallCollectionView];
    
//    [self.mallCollectionView bringSubviewToFront:self.view];
    [self.bgView addSubview:self.titleLable];
    [self.bgView addSubview:self.resultLabel];
    [self.bgView addSubview:self.exangeButton];
    [self.bgView addSubview:self.lineView];
    [self.mallCollectionView addSubview:self.bgView];
    
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 隐藏导航条底部分割线
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden=YES;
    
    [self initMallMoreData:NO];
    [self refresh];
    [self initData];
    
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
        
        DYNSLog(@"data = %@",data);
        if (data == nil) {
            return ;
        }
        NSDictionary *dataDic = [data objectForKey:@"data"];
        
        {
            NSArray *array = [dataDic objectForKey:@"mainlist"];
            if (array.count == 0) {
                [self obj_showTotasViewWithMes:@"还没有商品哦!"];
                [self.mallCollectionView.mj_header endRefreshing];
                return;
            }
            [self.shopMainListArray removeAllObjects];
            for (NSDictionary *dic in array)
            {
                YBIntegralMallModel *mainDodel = [[YBIntegralMallModel alloc] init];
                [mainDodel setValuesForKeysWithDictionary:dic];
                [self.shopMainListArray addObject:mainDodel];
                [self.mallCollectionView.mj_header endRefreshing];
            }
        }
        self.mallCollectionView.shopMainListArray = self.shopMainListArray;
        self.mallCollectionView.viewController = self;
        [self.mallCollectionView reloadData];
    } withFailure:^(id data) {
        [self.mallCollectionView.mj_header endRefreshing];
    }];
    
}
- (void)refresh{
    
    __weak typeof(self) ws = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (_mallType == kIntegralMall) {
            [ws initMallMoreData:NO];
            _mallCollectionView.mj_header = header;
            
        }
    }];
    
    
}
- (void)initData{
    
    // 积分商城
    NSString *appendString = [NSString stringWithFormat:kIntegralMallURl,[AcountManager manager].userid];
    NSString *finalString = [NSString stringWithFormat:BASEURL,appendString];
    [JENetwoking startDownLoadWithUrl:finalString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSDictionary *param = data;
        if ([param[@"type"] integerValue] == 1) {
            NSDictionary *data = param[@"data"];
            self.integralNumber = [data[@"wallet"] integerValue];
            self.resultLabel.text = [NSString stringWithFormat:@"%lu",self.integralNumber];
            
            // 保存积分数量
            [AcountManager manager].integrationNumber = self.integralNumber;
        }
        [self.mallCollectionView reloadData];
        
    } withFailure:^(id data) {
        NSString *str = data[@"msg"];
        [self obj_showTotasViewWithMes:str];
    }];
    
    
}
#pragma mark -- Action
- (void)exhangeBtn:(UIButton *)btn {
    
    JZExchangeRecordController *recordVC = [[JZExchangeRecordController alloc] init];
    recordVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:recordVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (MallCollectionView *)mallCollectionView {
    if (!_mallCollectionView) {
        
        // 自动布局方式
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _mallCollectionView = [[MallCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) collectionViewLayout:flowLayout];
        // 注册Cell
        _mallCollectionView.contentInset = UIEdgeInsetsMake(HeaderViewH, 0, 0, 0);
        
    }
    return _mallCollectionView;
}
- (NSMutableArray *)buttonArray {
    if (_buttonArray == nil) {
        _buttonArray = [[NSMutableArray alloc] init];
    }
    return _buttonArray;
}

- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, -HeaderViewH, kSystemWide, HeaderViewH)];
        _bgView.backgroundColor = [UIColor whiteColor];
        
    }
    return _bgView;
}
- (UILabel *)titleLable{
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(12, (HeaderViewH - 14) / 2, 64, 14)];
        _titleLable.text = @"我的积分:";
        _titleLable.font = [UIFont systemFontOfSize:14];
        _titleLable.textColor = JZ_FONTCOLOR_DRAK;
    }
    return _titleLable;
}
- (UILabel *)resultLabel{
    if (_resultLabel == nil) {
        _resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLable.frame) + 5, (HeaderViewH - 12) / 2, 200, 12)];
        _resultLabel.text = @"0";
        _resultLabel.font = [UIFont systemFontOfSize:12];
        _resultLabel.textColor = YBNavigationBarBgColor;
    }
    return _resultLabel;
}
- (UIButton *)exangeButton{
    if (_exangeButton == nil) {
        _exangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _exangeButton.frame = CGRectMake(CGRectGetWidth(self.bgView.frame) - 12 - 74 , (HeaderViewH - 30) / 2, 74, 30);
        [_exangeButton setTitle:@"兑换记录" forState:UIControlStateNormal];
        [_exangeButton setTitleColor:JZ_BlueColor forState:UIControlStateNormal];
        _exangeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _exangeButton.layer.borderWidth = 1;
        _exangeButton.layer.borderColor = JZ_BlueColor.CGColor;
        _exangeButton.layer.masksToBounds = YES;
        _exangeButton.layer.cornerRadius = 4;
        [_exangeButton addTarget:self action:@selector(exhangeBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exangeButton;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bgView.frame)- 1, kSystemWide, 1)];
        _lineView.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    }
    return _lineView;
}
@end

