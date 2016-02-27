//
//  YBMyWalletViewController.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/26.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBMyWalletViewController.h"
#import "YBStudyTableView.h"
#import "YBToolBarView.h"
#import "YBJianglijifenTableView.h"
#import "YBBaoMingDuiHuanQuanTableView.h"
#import "MJRefresh.h"

#define topViewH 175
#define toolBarHeight 40

@interface YBMyWalletViewController ()<UIScrollViewDelegate>
{
    UIImageView*navBarHairlineImageView;
    YBStudyProgress studyProgress;
    NSInteger kequxianjineduIndex;
}

@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *countLabel;

@property (nonatomic, strong) YBToolBarView *dvvToolBarView;

@property (nonatomic, strong) UIView *toolBarBottomLineView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) YBJianglijifenTableView *jianglijifenTableView;
@property (nonatomic, strong) YBBaoMingDuiHuanQuanTableView *baomingduihuanquanTableView;
@property (nonatomic, strong) YBJianglijifenTableView *kequxianjinedu;

@property (nonatomic, strong) NSMutableArray *jianglijifenArray;
@property (nonatomic, strong) NSMutableArray *baomingduihuanquanArray;
@property (nonatomic, strong) NSMutableArray *kequxianjineduArray;

@property (nonatomic, copy) NSString *jianglijifenCount;
@property (nonatomic, copy) NSString *baomingduihuanquanCount;
@property (nonatomic, copy) NSString *kequxianjineduCount;

@end

@implementation YBMyWalletViewController

- (NSMutableArray *)jianglijifenArray
{
    if (_jianglijifenArray==nil) {
        _jianglijifenArray = [NSMutableArray array];
    }
    return _jianglijifenArray;
}
- (NSMutableArray *)baomingduihuanquanArray
{
    if (_baomingduihuanquanArray==nil) {
        _baomingduihuanquanArray = [NSMutableArray array];
    }
    return _baomingduihuanquanArray;
}
- (NSMutableArray *)kequxianjineduArray
{
    if (_kequxianjineduArray==nil) {
        _kequxianjineduArray = [NSMutableArray array];
    }
    return _kequxianjineduArray;
}
#pragma mark - lazy load
- (YBToolBarView *)dvvToolBarView {
    if (!_dvvToolBarView) {
        _dvvToolBarView = [YBToolBarView new];
        _dvvToolBarView.titleArray = @[ @"奖励积分", @"报名兑换券", @"可取现金额度" ];
        _dvvToolBarView.titleNormalColor = [UIColor lightGrayColor];
        _dvvToolBarView.titleSelectedColor = [UIColor whiteColor];
        _dvvToolBarView.buttonNormalColor = YBNavigationBarBgColor;
        _dvvToolBarView.buttonSelectedColor = YBNavigationBarBgColor;
        __weak typeof(self) ws = self;
        [_dvvToolBarView dvvSetItemSelectedBlock:^(UIButton *button) {
            [ws toolBarItemSelectedAction:button];
        }];
        _dvvToolBarView.backgroundColor = YBNavigationBarBgColor;
    }
    return _dvvToolBarView;
}
- (UIView *)topView
{
    if (_topView==nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, topViewH)];
        _topView.backgroundColor = YBNavigationBarBgColor;
        // 标题
        [_topView addSubview:self.titleLabel];
        // 数量
        [_topView addSubview:self.countLabel];
        // 顶部segment
        [_topView addSubview:self.dvvToolBarView];
        // 分割线
        [_topView addSubview:self.toolBarBottomLineView];
        
    }
    return _topView;
}

-(UILabel *)titleLabel
{
    if (_titleLabel==nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"奖励积分";
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UILabel *)countLabel
{
    if (_countLabel==nil) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.text = @"积分";
        _countLabel.font = [UIFont boldSystemFontOfSize:30];
        _countLabel.textColor = [UIColor whiteColor];
        _countLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _countLabel;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 隐藏导航条底部分割线
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden=YES;
    
    // 更新数据
    [self changeScrollViewOffSetX:0];
    
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
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"钱包";
    
    // 顶部view
    [self.view addSubview:self.topView];
    
    // 滚动视图
    [self.view addSubview:self.scrollView];
    
    [_scrollView addSubview:self.jianglijifenTableView];
    [_scrollView addSubview:self.baomingduihuanquanTableView];
    [_scrollView addSubview:self.kequxianjinedu];
    
    __weak typeof(self) ws = self;
    // 刷新
    MJRefreshFooter *refreshHeader = [MJRefreshFooter footerWithRefreshingBlock:^{
        [ws getMorejianglijifenData];
    }];
    self.jianglijifenTableView.dataTabelView.mj_footer = refreshHeader;
    
    // 刷新
    MJRefreshFooter *refreshHeader2 = [MJRefreshFooter footerWithRefreshingBlock:^{
        [ws getMorekequxianjineduData];
    }];
    self.baomingduihuanquanTableView.dataTabelView.mj_footer = refreshHeader2;
    
    [self configUI];
    
    // 请求数据
    [self setUpData];
    
}


#pragma mark 奖励积分
- (void)getjianglijifenData{
    
    NSString *urlString = [NSString stringWithFormat:BASEURL, @"userinfo/getmywallet"];
    NSDictionary *paramsDict = @{@"userid": [AcountManager manager].userid,@"usertype":@"1",@"seqindex":@"1"};
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:paramsDict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"奖励积分:%@",data);
        
        /*
         
         {
         data =     {
         list =         (
         );
         wallet = 100;
         };
         msg = "";
         type = 1;
         }
         
         */
        if ([[data objectForKey:@"type"] integerValue]) {
            
            if (data[@"wallet"]) {
                self.jianglijifenCount = [NSString stringWithFormat:@"+%@积分",data[@"wallet"]];
            }else{
                self.jianglijifenCount = nil;
            }
            
            NSArray *listArray = data[@"list"];
            for (NSDictionary *listDict in listArray) {
                [self.jianglijifenArray addObject:listDict];
            }
            
            [self reloadData];
            
        }
        
    } withFailure:^(id data) {
        
    }];
    
}
#pragma mark 奖励积分
- (void)getMorejianglijifenData{
    
    NSDictionary *dict = [self.jianglijifenArray lastObject];
    NSString *index = [dict objectForKey:@"seqindex"];
    
    NSString *urlString = [NSString stringWithFormat:BASEURL, @"userinfo/getmywallet"];
    NSDictionary *paramsDict = @{@"userid": [AcountManager manager].userid,@"usertype":@"1",@"seqindex":index};
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:paramsDict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSDictionary *dict = data;
        
        NSLog(@"更多奖励积分:%@",data);
        
        if ([[dict objectForKey:@"type"] integerValue]) {
            
            NSArray *listArray = dict[@"list"];
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSDictionary *listDict in listArray) {
                [tempArray addObject:listDict];
            }
            [self.jianglijifenArray addObjectsFromArray:tempArray];

            [self reloadData];

        }
        
    } withFailure:^(id data) {
        
    }];
    
}

#pragma mark 查询优惠券
- (void)getBaomingduihuanquanData{
    
    NSString *urlString = [NSString stringWithFormat:BASEURL, @"userinfo/getmycupon"];
    NSDictionary *paramsDict = @{@"userid": [AcountManager manager].userid};
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:paramsDict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"查询优惠券:%@",data);
        /*
         
         {
         data =     (
         {
             "_id" = 568570de8ec8f1535cb1f73f;
             couponcomefrom = 1;
             createtime = "2015-12-31T17:41:43.249Z";
             "is_forcash" = 1;
             state = 0;
             userid = 56855575470b6ca057d15bad;
             }
             );
             msg = "";
             type = 1;
         }
         
         */
        if ([[data objectForKey:@"type"] integerValue]) {
            
            NSArray *dataArray = data[@"data"];
            if (dataArray && dataArray.count!=0) {
                self.baomingduihuanquanCount = [NSString stringWithFormat:@"%lu张",(unsigned long)dataArray.count];
            }else{
                self.baomingduihuanquanCount = nil;
            }
            
            for (NSDictionary *dict in dataArray) {
                [self.baomingduihuanquanArray addObject:dict];
            }
            
            [self reloadData];

        }
        
    } withFailure:^(id data) {
        
    }];
    
}

#pragma mark 可取现金额度
- (void)getkequxianjineduData{
    
    NSString *urlString = [NSString stringWithFormat:BASEURL, @"userinfo/getmymoneylist"];
    NSDictionary *paramsDict = @{@"userid": [AcountManager manager].userid,@"usertype":@"1",@"seqindex":[NSString stringWithFormat:@"%ld",(long)kequxianjineduIndex]};
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:paramsDict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"可取现金额度:%@",data);
        
        /*
         
         {
         data =     {
         fcode = YBRL0J;
         money = 150;
         moneylist =         (
         {
         createtime = "2016-01-08T18:16:03.404Z";
         income = 0;
         type = 1;
         },
         {
         createtime = "2016-01-07T09:25:40.470Z";
         income = 150;
         type = 2;
         }
         );
         userid = 56855575470b6ca057d15bad;
         };
         msg = "";
         type = 1;
         }
         
         */
        if ([[data objectForKey:@"type"] integerValue]) {
            
            NSDictionary *dataDict = data[@"data"];
            if (dataDict[@"money"]) {
                self.kequxianjineduCount = [NSString stringWithFormat:@"%@元",dataDict[@"money"]];
            }else{
                self.kequxianjineduCount = nil;
            }
            
            NSArray *moneylistArray = dataDict[@"moneylist"];
            for (NSDictionary *dict in moneylistArray) {
                [self.kequxianjineduArray addObject:dict];
            }
            
            [self reloadData];

            kequxianjineduIndex+=1;
            
        }
        
    } withFailure:^(id data) {
        
    }];
    
}

#pragma mark 可取现金额度
- (void)getMorekequxianjineduData{
    
    
    
    NSString *urlString = [NSString stringWithFormat:BASEURL, @"userinfo/getmymoneylist"];
    NSDictionary *paramsDict = @{@"userid": [AcountManager manager].userid,@"usertype":@"1",@"seqindex":[NSString stringWithFormat:@"%ld",(long)kequxianjineduIndex]};
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:paramsDict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSDictionary *dict = data;
        
        NSLog(@"可取现金额度:%@",data);
        
        if ([[dict objectForKey:@"type"] integerValue]) {
            
            NSDictionary *dataDict = dict[@"data"];
            self.kequxianjineduCount = [NSString stringWithFormat:@"%@元",dataDict[@"money"]];
            
            NSArray *moneylistArray = dataDict[@"moneylist"];
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSDictionary *dict in moneylistArray) {
                [tempArray addObject:dict];
            }
            [self.kequxianjineduArray addObjectsFromArray:tempArray];
            
            kequxianjineduIndex+=1;
            
            [self reloadData];

        }
        
    } withFailure:^(id data) {
        
    }];
    
}

- (void)setUpData
{
    
    // GET /userinfo/getmycupon 奖励积分
    [self getjianglijifenData];
    
    // GET /userinfo/getmywallet    报名兑换券
    [self getBaomingduihuanquanData];
    
    // GET /userinfo/getmymoneylist 可取现金额度
    [self getkequxianjineduData];
    
    
}

- (void)toolBarItemSelectedAction:(UIButton *)sender {
    [self changeScrollViewOffSetX:sender.tag];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSUInteger tag = scrollView.contentOffset.x / CGRectGetWidth(_scrollView.frame);
    [self changeScrollViewOffSetX:tag];
    [_dvvToolBarView selectItem:tag];
}

#pragma mark - public
- (void)changeScrollViewOffSetX:(NSUInteger)tag {
    
    [UIView animateWithDuration:0.3 animations:^{
        _scrollView.contentOffset = CGPointMake(CGRectGetWidth(_scrollView.frame) * tag, 0);
    }];
    
    NSLog(@"tag:%lu",(unsigned long)tag);
    
    studyProgress = tag;
    
    // 更新数据
    [self reloadData];
    
}

- (void)reloadData
{
    
    if (studyProgress==0) {
        
        self.titleLabel.text = @"奖励积分";
        self.countLabel.text = self.jianglijifenCount;
        
        /*
         
         "createtime": "2015-11-09T12:39:36.624Z",
         "amount": -5000,
         "type": 3,
         "seqindex": 36
         
         */
        self.jianglijifenTableView.isJianglijifen = YES;
        self.jianglijifenTableView.jianglijifenArrray = [self.jianglijifenArray mutableCopy];
        [self.jianglijifenTableView reloadData];
        
    }else if (studyProgress == 1){

        self.titleLabel.text = @"报名兑换券";
        self.countLabel.text = self.baomingduihuanquanCount;
        
        /*
         
         "_id": "56812f877b340f4e48423164",
         "userid": "562cb02e93d4ca260b40e544",
         "state": 0,
         "is_forcash": true,
         "couponcomefrom": 1,
         "createtime": "2015-12-28T12:48:07.805Z"
         
         */
        self.baomingduihuanquanTableView.dataArray = [self.baomingduihuanquanArray mutableCopy];
        [self.baomingduihuanquanTableView reloadData];
        
    }else if (studyProgress == 2){
        
        self.titleLabel.text = @"可取现金额度";
        self.countLabel.text = self.kequxianjineduCount;
        
        /*
         
         income :{type:Number,default:0}, //收入
         type:Number,  // 0 支出  1 报名奖励  2 邀请奖励  3 下线分红
         
         
         */
        self.kequxianjinedu.isJianglijifen = NO;
        self.kequxianjinedu.kequxianjineduArray = [self.kequxianjineduArray mutableCopy];
        [self.kequxianjinedu reloadData];
        
    }
    
}

#pragma mark - configUI
- (void)configUI {
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    self.titleLabel.frame = CGRectMake(20, topViewH-150, self.view.width-40, 20);
    self.countLabel.frame = CGRectMake(20, CGRectGetMaxY(self.titleLabel.frame), self.view.width-40, 50);
    
    _dvvToolBarView.frame = CGRectMake(0, topViewH-toolBarHeight, screenSize.width, toolBarHeight);
    
    _toolBarBottomLineView.frame = CGRectMake(0, CGRectGetMaxY(_dvvToolBarView.frame), screenSize.width, 1);
    
    _scrollView.frame = CGRectMake(0, topViewH, screenSize.width, screenSize.height - topViewH-64);
    _scrollView.contentSize = CGSizeMake(screenSize.width * 3, 0);
    
    _jianglijifenTableView.frame = CGRectMake(0, 0, screenSize.width, CGRectGetHeight(_scrollView.frame));
    _baomingduihuanquanTableView.frame = CGRectMake(screenSize.width, 0, screenSize.width, CGRectGetHeight(_scrollView.frame));
    _kequxianjinedu.frame = CGRectMake(screenSize.width * 2, 0, screenSize.width, CGRectGetHeight(_scrollView.frame));
    
}

- (UIView *)toolBarBottomLineView {
    if (!_toolBarBottomLineView) {
        _toolBarBottomLineView = [UIView new];
        _toolBarBottomLineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _toolBarBottomLineView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.bounces = NO;
    }
    return _scrollView;
}
- (YBJianglijifenTableView *)jianglijifenTableView {
    if (!_jianglijifenTableView) {
        _jianglijifenTableView = [YBJianglijifenTableView new];
        _jianglijifenTableView.parentViewController = self;
    }
    return _jianglijifenTableView;
}
- (YBBaoMingDuiHuanQuanTableView *)baomingduihuanquanTableView {
    if (!_baomingduihuanquanTableView) {
        _baomingduihuanquanTableView = [YBBaoMingDuiHuanQuanTableView new];
        _baomingduihuanquanTableView.parentViewController = self;
    }
    return _baomingduihuanquanTableView;
}
- (YBJianglijifenTableView *)kequxianjinedu {
    if (!_kequxianjinedu) {
        _kequxianjinedu = [YBJianglijifenTableView new];
        _kequxianjinedu.parentViewController = self;
    }
    return _kequxianjinedu;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
