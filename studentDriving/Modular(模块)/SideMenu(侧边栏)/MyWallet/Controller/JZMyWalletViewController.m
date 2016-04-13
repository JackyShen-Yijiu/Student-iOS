//
//  JZMyWalletViewController.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZMyWalletViewController.h"
#import "JZMyWalletHeaderView.h"
#import "JZMyWalletJiFenView.h"
#import "JZMyWalletDuiHuanJuanView.h"
#import "JZMyWalletXianJinView.h"
#import "JZMyWalletBottomView.h"
#import "MyJiFenHeaderTypeView.h"
#import "MyXianJinHeaderTypeView.h"
#import "MyDuiHuanJuanHeaderTypeView.h"

#define kLKSize [UIScreen mainScreen].bounds.size

@interface JZMyWalletViewController ()<UIScrollViewDelegate>
///  头部视图
@property (nonatomic, weak)JZMyWalletHeaderView  *jiFenHeaderView;
///  滚动父视图
@property (nonatomic, weak) UIScrollView *contentScrollView;
///  积分的视图
@property (nonatomic, weak) JZMyWalletJiFenView *jiFenView;
///  兑换券的视图
@property (nonatomic, weak) JZMyWalletDuiHuanJuanView *duiHuanJuanView;
///  现金的视图
@property (nonatomic, weak) JZMyWalletXianJinView *xianJinView;
///  底部视图
@property (nonatomic, weak) JZMyWalletBottomView *bottomView;

@property (nonatomic, weak) MyJiFenHeaderTypeView *jiFenHeaderTypeView;

@property (nonatomic, weak) MyXianJinHeaderTypeView *xianJinHeaderTypeView;

@property (nonatomic, weak) MyDuiHuanJuanHeaderTypeView *duiHuanJuanHeaderTypeView;




@end

@implementation JZMyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = YBMainViewControlerBackgroundColor;
    self.title = @"我的钱包";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setUI];
    
    [self getXianJinData];
    
    
}
#pragma mark - 界面控件搭建
-(void)setUI {
    JZMyWalletHeaderView *jiFenHeaderView = [[JZMyWalletHeaderView alloc]initWithFrame:CGRectMake(0, 0, kLKSize.width, 238)];
    
    self.jiFenHeaderView = jiFenHeaderView;
    
    [self.view addSubview:jiFenHeaderView];
    
    self.jiFenHeaderView.jiFenBtn.tag = 2016;
    self.jiFenHeaderView.duiHuanJuanBtn.tag = 2017;
    self.jiFenHeaderView.xianJinBtn.tag = 2018;
    
    
    [self.jiFenHeaderView.jiFenBtn addTarget:self action:@selector(clickJiFenBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.jiFenHeaderView.duiHuanJuanBtn addTarget:self action:@selector(clickDuiHuanJuanBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.jiFenHeaderView.xianJinBtn addTarget:self action:@selector(clickXianJinBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 238, kLKSize.width, kLKSize.height - 238)];
    contentScrollView.showsVerticalScrollIndicator = NO;
    contentScrollView.showsHorizontalScrollIndicator = NO;
    contentScrollView.pagingEnabled = YES;
    contentScrollView.bounces = NO;
    contentScrollView.contentSize = CGSizeMake(kLKSize.width * 3, kLKSize.height - 238);
    contentScrollView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:contentScrollView];
    
    self.contentScrollView = contentScrollView;
    
    self.contentScrollView.delegate = self;
#pragma mark - 积分页面
    MyJiFenHeaderTypeView *jiFenHeaderTypeView = [[MyJiFenHeaderTypeView alloc]initWithFrame:CGRectMake(0, 0, kLKSize.width, 36)];
    
    self.jiFenHeaderTypeView = jiFenHeaderTypeView;
    
    [self.contentScrollView addSubview:jiFenHeaderTypeView];

    
    JZMyWalletJiFenView *jiFenView = [[JZMyWalletJiFenView alloc]initWithFrame:CGRectMake(0, 36, kLKSize.width, kLKSize.height - 238-64-40.5-36)];
    
    self.jiFenView = jiFenView;
    [self.contentScrollView addSubview:jiFenView];
    
#pragma mark - 兑换券页面
    MyDuiHuanJuanHeaderTypeView *duiHuanJuanHeaderTypeView = [[MyDuiHuanJuanHeaderTypeView alloc]initWithFrame:CGRectMake(kLKSize.width, 0, kLKSize.width, 36)];
    
    self.duiHuanJuanHeaderTypeView = duiHuanJuanHeaderTypeView;
    
    [self.contentScrollView addSubview:duiHuanJuanHeaderTypeView];
    
    JZMyWalletDuiHuanJuanView *duiHuanJuanView = [[JZMyWalletDuiHuanJuanView alloc]initWithFrame:CGRectMake(kLKSize.width, 36, kLKSize.width, kLKSize.height -238-64-36)];
    
    self.duiHuanJuanView = duiHuanJuanView;
    [self.contentScrollView addSubview:duiHuanJuanView];
    
    
    
#pragma mark - 现金页面
    
    MyXianJinHeaderTypeView *xianJinHeaderTypeView = [[MyXianJinHeaderTypeView alloc]initWithFrame:CGRectMake(kLKSize.width * 2, 0, kLKSize.width, 36)];
    self.xianJinHeaderTypeView = xianJinHeaderTypeView;
    
    [self.contentScrollView addSubview:xianJinHeaderTypeView];
    

    JZMyWalletXianJinView *xianJinView = [[JZMyWalletXianJinView alloc]initWithFrame:CGRectMake(kLKSize.width * 2, 36, kLKSize.width, kLKSize.height -238-64-40.5-36)];
    
    self.xianJinView = xianJinView;
    
    [self.contentScrollView addSubview:xianJinView];
    
#pragma mark - 底部页面
JZMyWalletBottomView *bottomView = [[JZMyWalletBottomView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(jiFenView.frame), kLKSize.width, 40.5)];
    
    self.bottomView = bottomView;
    
    [self.contentScrollView addSubview:bottomView];
    
}


#pragma mark - scrollowVie的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    NSLog(@"%f",self.contentScrollView.contentOffset.x);
    

    
    if (scrollView.contentOffset.x > kLKSize.width) {
        
        self.bottomView.transform = CGAffineTransformMakeTranslation(kLKSize.width * 2,0);
    }
    
    if (scrollView.contentOffset.x < kLKSize.width) {
        self.bottomView.transform = CGAffineTransformMakeTranslation(0,0);
        
        [self getJiFenData];
        
    }
    if (scrollView.contentOffset.x == 0) {
        
        [self clickJiFenBtn];
    }
    
    if (scrollView.contentOffset.x == kLKSize.width) {
        
        [self clickDuiHuanJuanBtn];
    }if (scrollView.contentOffset.x == kLKSize.width * 2) {
        
        [self clickXianJinBtn];
    }
    

    
    
}

#pragma mark 获取积分
- (void)getJiFenData{
    
    NSString *urlString = [NSString stringWithFormat:BASEURL, @"userinfo/getmywallet"];
    NSDictionary *paramsDict = @{@"userid": [AcountManager manager].userid,@"usertype":@"1",@"seqindex":@"1"};
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:paramsDict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSDictionary *resultData = data[@"data"];
        NSLog(@"奖励积分:%@",data);
        
        if ([[data objectForKey:@"type"] integerValue]) {
            
            if (resultData[@"wallet"]) {
                
                self.jiFenHeaderView.headerNumLabel.text = [NSString stringWithFormat:@"%@",resultData[@"wallet"]];
            }else{
                self.jiFenHeaderView.headerNumLabel.text = @"暂无";
            }
        }
        
    } withFailure:^(id data) {
        
        [self obj_showTotasViewWithMes:@"网络错误"];
        
    }];
    
    
}

#pragma mark 获取现金
- (void)getXianJinData{
    
    NSString *urlString = [NSString stringWithFormat:BASEURL, @"userinfo/getmymoney"];
    NSDictionary *paramsDict = @{@"userid": [AcountManager manager].userid,@"usertype":@"1"};
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:paramsDict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSDictionary *resultData = data[@"data"];
        NSLog(@"获取现金:%@",data);
        
        if ([[data objectForKey:@"type"] integerValue]) {
            
            if (resultData[@"money"]) {
                
                self.jiFenHeaderView.headerNumLabel.text = [NSString stringWithFormat:@"￥%@",resultData[@"money"]];
            }else{
                self.jiFenHeaderView.headerNumLabel.text = @"暂无";
            }
        }
        
    } withFailure:^(id data) {
        
        [self obj_showTotasViewWithMes:@"网络错误"];
        
    }];
    
    
}

-(void)getDuiHuanJuanData {
    
    NSString *urlString = [NSString stringWithFormat:BASEURL, @"userinfo/getmymoney"];
    NSDictionary *paramsDict = @{@"userid": [AcountManager manager].userid,@"usertype":@"1"};
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:paramsDict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSDictionary *resultData = data[@"data"];
        NSLog(@"获取现金:%@",data);
        
        if ([[data objectForKey:@"type"] integerValue]) {
            
            if (resultData[@"money"]) {
                
                self.jiFenHeaderView.headerNumLabel.text = [NSString stringWithFormat:@"￥%@",resultData[@"money"]];
            }else{
                self.jiFenHeaderView.headerNumLabel.text = @"暂无";
            }
        }
        
    } withFailure:^(id data) {
        
        [self obj_showTotasViewWithMes:@"网络错误"];
        
    }];
    

    
}







#pragma mark - 顶部按钮的点击事件
#pragma mark - 点击积分
-(void)clickJiFenBtn {
    [self getJiFenData];
    [self.jiFenHeaderView.jiFenBtn setTitleColor:RGBColor(219, 68, 55) forState:UIControlStateNormal];
    self.jiFenHeaderView.duiHuanJuanBtn.titleLabel.textColor = RGBColor(110, 110, 110);
    self.jiFenHeaderView.xianJinBtn.titleLabel.textColor = RGBColor(110, 110, 110);
    self.jiFenHeaderView.howDoBtn.hidden = NO;
    
    [self.jiFenHeaderView.headerImg setImage:[UIImage imageNamed:@"wallet_integral"]];
    [self.jiFenHeaderView.goToOthersBtn setTitle:@"积分商城" forState:UIControlStateNormal];
    self.jiFenHeaderView.goToOthersBtn.layer.borderWidth = 2;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.jiFenHeaderView.rollLineView.transform = CGAffineTransformMakeTranslation(0,0);
        
    }];
}
#pragma mark - 点击兑换券
-(void)clickDuiHuanJuanBtn {
    [self.jiFenHeaderView.duiHuanJuanBtn setTitleColor:RGBColor(219, 68, 55) forState:UIControlStateNormal];
    self.jiFenHeaderView.jiFenBtn.titleLabel.textColor = RGBColor(110, 110, 110);
    self.jiFenHeaderView.xianJinBtn.titleLabel.textColor = RGBColor(110, 110, 110);
    
    [self.jiFenHeaderView.headerImg setImage:[UIImage imageNamed:@"wallet_ticket"]];
    [self.jiFenHeaderView.goToOthersBtn setTitle:@"" forState:UIControlStateNormal];
    self.jiFenHeaderView.howDoBtn.hidden = YES;
    
    self.jiFenHeaderView.goToOthersBtn.layer.borderWidth = 0;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.jiFenHeaderView.rollLineView.transform = CGAffineTransformMakeTranslation(kLKSize.width/3,0);
        
        
        
        
    }];}
#pragma mark - 点击现金
-(void)clickXianJinBtn {
    
    [self getXianJinData];
    
    [self.jiFenHeaderView.xianJinBtn setTitleColor:RGBColor(219, 68, 55) forState:UIControlStateNormal];
    self.jiFenHeaderView.jiFenBtn.titleLabel.textColor = RGBColor(110, 110, 110);
    self.jiFenHeaderView.duiHuanJuanBtn.titleLabel.textColor = RGBColor(110, 110, 110);
    [self.jiFenHeaderView.headerImg setImage:[UIImage imageNamed:@"wallet_cash"]];
    [self.jiFenHeaderView.goToOthersBtn setTitle:@"立即提现" forState:UIControlStateNormal];
    
    self.jiFenHeaderView.goToOthersBtn.layer.borderWidth = 2;
    
    self.jiFenHeaderView.howDoBtn.hidden = YES;
    [UIView animateWithDuration:0.25 animations:^{
        
        self.jiFenHeaderView.rollLineView.transform = CGAffineTransformMakeTranslation(kLKSize.width/3*2,0);
        
    }];
}






@end
