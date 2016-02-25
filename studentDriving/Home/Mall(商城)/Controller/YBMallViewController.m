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

static NSString *const kGetMySaveCoach = @"userinfo/favoritecoach";

static NSString *const kGetMySaveSchool = @"userinfo/favoriteschool";

static NSString *const kDeleteMySaveCoach = @"userinfo/favoritecoach";

static NSString *const kDeleteMySaveSchool = @"userinfo/favoriteschool";

typedef NS_ENUM(NSUInteger,MallType){
    kIntegralMall,
    kDiscountMall
};

@interface YBMallViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView*navBarHairlineImageView;
}

@property (nonatomic, strong) UITableView *tabelView;

@property (nonatomic,retain) NSMutableArray *shopMainListArray; // 积分商城

@property (nonatomic,retain) NSMutableArray *discountArray; // 兑换劵商城

@property (strong, nonatomic) UIView *menuIndicator;

@property (nonatomic, strong) NSMutableArray *buttonArray;

@property (nonatomic, assign) MallType mallType;

@end

static NSString *kMagicShop = @"getmailproduct?index=1&count=10&producttype=1";
static NSString *kDiscountShop = @"getmailproduct?index=1&count=10&producttype=1";
@implementation YBMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shopMainListArray = [[NSMutableArray alloc] init];
    self.discountArray = [[NSMutableArray alloc] init];
    self.title = @"商城";
    _mallType = kIntegralMall;
    self.tabelView.delegate = self;
    self.tabelView.dataSource  = self;
    [self.view addSubview:self.tabelView];
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
    
    navBarHairlineImageView.hidden=NO;
    
    
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
                for (NSDictionary *dic in array)
                {
                    YBIntegralMallModel *mainDodel = [[YBIntegralMallModel alloc] init];
                    [mainDodel setValuesForKeysWithDictionary:dic];
                    [self.shopMainListArray removeAllObjects];
                    [self.shopMainListArray addObject:mainDodel];
                }
            }
            [self.tabelView reloadData];
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
                for (NSDictionary *dic in array)
                {
                    YBDiscountModel *mainDodel = [[YBDiscountModel alloc] init];
                    [mainDodel setValuesForKeysWithDictionary:dic];
                    [self.discountArray removeAllObjects];
                    [self.discountArray addObject:mainDodel];
                }
            }
            [self.tabelView reloadData];
        } ];

        
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_mallType == kIntegralMall) {
        return self.shopMainListArray.count;
    }else if (_mallType == kDiscountMall){
        return self.discountArray.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 165;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_mallType == kIntegralMall) {
        // 加载积分商城
        NSString *cellID =@"MallCellID";
        YBIntegralMallCell *mallCell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!mallCell) {
            mallCell = [[YBIntegralMallCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            mallCell.backgroundColor = [UIColor clearColor];
        }
        mallCell.integralMallModel = self.shopMainListArray[indexPath.row];
        return mallCell;
    }else if (_mallType == kDiscountMall){
        // 加载兑换券商城
        NSString *cellID =@"DiscountCellID";
        YBDiscountCell *mallCell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!mallCell) {
            mallCell = [[YBDiscountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            mallCell.backgroundColor = [UIColor clearColor];
        }
        mallCell.discountModel = self.discountArray[indexPath.row];
        return mallCell;
    }
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tabelView deselectRowAtIndexPath:indexPath animated:YES];
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
#pragma mark ---- Lazy 加载
- (UITableView *)tabelView{
    if (_tabelView == nil) {
        _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, self.view.frame.size.width, self.view.frame.size.height - 100) style:UITableViewStylePlain];
        _tabelView.backgroundColor = [UIColor clearColor];
        _tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tabelView;

}
- (UIView *)menuIndicator {
    if (_menuIndicator == nil) {
        _menuIndicator = [[UIView alloc] initWithFrame:CGRectMake(0,40-2, kSystemWide / 2, 2)];
        _menuIndicator.backgroundColor = [UIColor yellowColor];
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
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 40)];
    backGroundView.backgroundColor = YBNavigationBarBgColor;
    backGroundView.layer.shadowColor = RGBColor(204, 204, 204).CGColor;
    backGroundView.layer.shadowOffset = CGSizeMake(0, 1);
    backGroundView.layer.shadowOpacity = 0.5;
    backGroundView.userInteractionEnabled = YES;
    // 积分商城
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:@"积分商城" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor colorWithHexString:@"f4c7c3"] forState:UIControlStateNormal];
    leftButton.selected = YES;
    [leftButton addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [backGroundView addSubview:leftButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backGroundView.mas_left).offset(0);
        make.top.mas_equalTo(backGroundView.mas_top).offset(0);
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide/2];
        make.width.mas_equalTo(height);
        make.height.mas_equalTo(@40);
    }];
    [self.buttonArray addObject:leftButton];
    // 兑换劵商城
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"兑换劵商城" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor colorWithHexString:@"f4c7c3"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [backGroundView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(backGroundView.mas_right).offset(0);
        make.top.mas_equalTo(backGroundView.mas_top).offset(0);
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide/2];
        make.width.mas_equalTo(height);
        make.height.mas_equalTo(@40);
    }];
    [self.buttonArray addObject:rightButton];
    
    [backGroundView addSubview:self.menuIndicator];
    
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
    [UIView animateWithDuration:0.5 animations:^{
        self.menuIndicator.frame = CGRectMake(kSystemWide/2, self.menuIndicator.calculateFrameWithY, self.menuIndicator.calculateFrameWithWide, self.menuIndicator.calculateFrameWithHeight);
    }];
    sender.selected = YES;
    _mallType = kDiscountMall;
    [self startDownLoad];
}

@end
