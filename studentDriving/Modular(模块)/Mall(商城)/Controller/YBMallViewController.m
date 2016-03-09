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

static NSString *const kGetMySaveCoach = @"userinfo/favoritecoach";

static NSString *const kGetMySaveSchool = @"userinfo/favoriteschool";

static NSString *const kDeleteMySaveCoach = @"userinfo/favoritecoach";

static NSString *const kDeleteMySaveSchool = @"userinfo/favoriteschool";

typedef NS_ENUM(NSUInteger,MallType){
    kIntegralMall,
    kDiscountMall
};

@interface YBMallViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UIImageView*navBarHairlineImageView;
}

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic,retain) NSMutableArray *shopMainListArray; // 积分商城

@property (nonatomic,retain) NSMutableArray *discountArray; // 兑换劵商城

@property (strong, nonatomic) UIView *menuIndicator;

@property (nonatomic, strong) NSMutableArray *buttonArray;

@property (nonatomic, assign) MallType mallType;

@end

static NSString *kMagicShop = @"getmailproduct?index=1&count=10&producttype=0";
static NSString *kDiscountShop = @"getmailproduct?index=1&count=10&producttype=1";
static NSString *kMallID = @"MallID";

@implementation YBMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shopMainListArray = [[NSMutableArray alloc] init];
    self.discountArray = [[NSMutableArray alloc] init];
    self.title = @"商城";
    _mallType = kIntegralMall;
     self.view.backgroundColor = [UIColor colorWithHexString:@"e8e8ed"];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:[self tableViewHeadView]];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self startDownLoad];
    // 隐藏导航条底部分割线
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden=YES;
    
    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self startDownLoad];
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
- (void)startDownLoad {
    if (_mallType == kIntegralMall) {
        // 加载积分商城数据
        NSString *urlString = [NSString stringWithFormat:BASEURL,kMagicShop];
        NSLog(@"%@",urlString);
        NSDictionary *parm = @{@"cityname":@"北京"};
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
                    return;
                }
                [self.shopMainListArray removeAllObjects];
                for (NSDictionary *dic in array)
                {
                    YBIntegralMallModel *mainDodel = [[YBIntegralMallModel alloc] init];
                    [mainDodel setValuesForKeysWithDictionary:dic];
                    [self.shopMainListArray addObject:mainDodel];
                }
            }
            [self.collectionView reloadData];
        } ];
    }
    if (_mallType == kDiscountMall) {
        // 加载兑换劵商城数据
        NSString *urlString = [NSString stringWithFormat:BASEURL,kDiscountShop];
        NSLog(@"%@",urlString);
        NSDictionary *parm = @{@"cityname":@"北京"};
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
                    return;
                }
                [self.discountArray removeAllObjects];
                for (NSDictionary *dic in array)
                {
                    YBDiscountModel *mainDodel = [[YBDiscountModel alloc] init];
                    [mainDodel setValuesForKeysWithDictionary:dic];
                    [self.discountArray addObject:mainDodel];
                }
            }
            [self.collectionView reloadData];
        } ];

        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
#pragma mark - collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
        if (_mallType == kIntegralMall) {
            return self.shopMainListArray.count;
        }else if (_mallType == kDiscountMall){
            return self.discountArray.count;
        }
        return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
        if (_mallType == kIntegralMall) {
            // 加载积分商城
            YBIntegralMallCell *mallCell = [collectionView dequeueReusableCellWithReuseIdentifier:kMallID forIndexPath:indexPath];
                        mallCell.integralMallModel = self.shopMainListArray[indexPath.row];
//            mallCell.backgroundColor = [UIColor clearColor];
            

            return mallCell;
        }else if (_mallType == kDiscountMall){
            // 加载兑换券商城
            
            YBDiscountCell *mallCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"discountID" forIndexPath:indexPath];
            mallCell.discountModel = self.discountArray[indexPath.row];
            return mallCell;
        }
        return nil;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
        // 退出侧边栏
        if ([WMCommon getInstance].homeState==kStateMenu) {
            [[NSNotificationCenter defaultCenter] postNotificationName:KhiddenSlide object:self];
            return;
        }
    
        if (_mallType == kIntegralMall) {
            // 积分商城详情
            MagicDetailViewController *detailVC = [[MagicDetailViewController alloc] init];
            detailVC.integralModel = _shopMainListArray[indexPath.row];
            detailVC.mallWay = 0;
            detailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailVC animated:YES];
        }else if(_mallType == kDiscountMall){
            // 兑换劵商城详情
            MagicDetailViewController *detailVC = [[MagicDetailViewController alloc] init];
            detailVC.discountModel = _discountArray[indexPath.row];
            detailVC.mallWay = 1;
            detailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
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

#pragma mark - lazy load
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        // 自动布局方式
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 110) collectionViewLayout:flowLayout];
        // 注册Cell
        [_collectionView registerClass:[YBIntegralMallCell class] forCellWithReuseIdentifier:kMallID];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView.layer setMasksToBounds:YES];
        [_collectionView.layer setCornerRadius:4];
    }
    return _collectionView;
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
    [self startDownLoad];
}
// 兑换劵商城
- (void)clickRightBtn:(UIButton *)sender {
    for (UIButton *b in self.buttonArray) {
        b.selected = NO;
    }
    [_collectionView registerClass:[YBDiscountCell class] forCellWithReuseIdentifier:@"discountID"];
    [UIView animateWithDuration:0.5 animations:^{
        self.menuIndicator.frame = CGRectMake(kSystemWide/2, self.menuIndicator.calculateFrameWithY, self.menuIndicator.calculateFrameWithWide, self.menuIndicator.calculateFrameWithHeight);
    }];
    sender.selected = YES;
    _mallType = kDiscountMall;
    [self startDownLoad];
}

@end
