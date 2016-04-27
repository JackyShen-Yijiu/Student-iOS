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
#import "DVVShare.h"
#import "YBMallViewController.h"
#import "YBMyWalletMallViewController.h"
#import "JZHowAddJiFenViewController.h"
#import <YYModel.h>
#import "JZMyWalletDuiHuanJuanData.h"
#import "JZMyWalletDuiHuanJuanUseproductidlist.h"
#import "DVVNoDataPromptView.h"
#import "JZExchangeRecordController.h"
#import "JZDiscountRecodeController.h"
#import "JZTiXianListController.h"


#define kLKSize [UIScreen mainScreen].bounds.size

@interface JZMyWalletViewController ()<UIScrollViewDelegate>

{
    UIImageView *navBarHairlineImageView;
}
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


@property (nonatomic, strong) JZMyWalletDuiHuanJuanData *dataModel;
@property (nonatomic, strong) JZMyWalletDuiHuanJuanUseproductidlist *listModel;


@property (nonatomic, strong) NSMutableArray *duiHuanJuanDataArrM;

@property (nonatomic, strong) NSMutableArray *duihuanJuanListArrM;


@property (nonatomic,strong)DVVNoDataPromptView *DvvView;

@property (nonatomic, strong) UILabel *noDataLabel;

///  遮罩按钮
@property (nonatomic, strong) UIButton *coverButton;


@end

@implementation JZMyWalletViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 隐藏导航条底部分割线
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden=YES;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = YBMainViewControlerBackgroundColor;
    self.title = @"我的钱包";
    
    if (YBIphone6Plus) {
     
        UIColor * color = [UIColor whiteColor];
        UIFont *font = [UIFont systemFontOfSize:19];
        
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        [dict setObject:color forKey:NSForegroundColorAttributeName];
        [dict setObject:font forKey:NSFontAttributeName];
        
        self.navigationController.navigationBar.titleTextAttributes = dict;
        
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setUI];
    [self getJiFenData];
    //    [self getXianJinData];
    //
    //    [self getDuiHuanJuanData];
    
    
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
    //    contentScrollView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:contentScrollView];
    
    self.contentScrollView = contentScrollView;
    
    self.contentScrollView.delegate = self;
#pragma mark - 积分页面
    MyJiFenHeaderTypeView *jiFenHeaderTypeView = [[MyJiFenHeaderTypeView alloc]initWithFrame:CGRectMake(0, 0, kLKSize.width, 36)];
    
    self.jiFenHeaderTypeView = jiFenHeaderTypeView;
    
    [self.contentScrollView addSubview:jiFenHeaderTypeView];
    
    [self.jiFenHeaderTypeView.duiHuanList addTarget:self action:@selector(goToDuiHuanListClick) forControlEvents:UIControlEventTouchUpInside];
    
    JZMyWalletJiFenView *jiFenView = [[JZMyWalletJiFenView alloc]initWithFrame:CGRectMake(0, 36, kLKSize.width, kLKSize.height - 238-64-40.5-36)];
    
    self.jiFenView = jiFenView;
    [self.contentScrollView addSubview:jiFenView];
    
    self.jiFenView.showsVerticalScrollIndicator = NO;
    self.jiFenView.showsHorizontalScrollIndicator = NO;
    
    [self.jiFenHeaderView.howDoBtn addTarget:self action:@selector(howAddJiFenClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
#pragma mark - 兑换券页面
    MyDuiHuanJuanHeaderTypeView *duiHuanJuanHeaderTypeView = [[MyDuiHuanJuanHeaderTypeView alloc]initWithFrame:CGRectMake(kLKSize.width, 0, kLKSize.width, 36)];
    
    self.duiHuanJuanHeaderTypeView = duiHuanJuanHeaderTypeView;
    
    [self.contentScrollView addSubview:duiHuanJuanHeaderTypeView];
    
    JZMyWalletDuiHuanJuanView *duiHuanJuanView = [[JZMyWalletDuiHuanJuanView alloc]initWithFrame:CGRectMake(kLKSize.width, 36, kLKSize.width, kLKSize.height -238-64-36)];
    
    self.jiFenHeaderView.headerNumLabel.text = [NSString stringWithFormat:@"%zd张",self.duihuanJuanListArrM.count];
    
    self.duiHuanJuanView = duiHuanJuanView;
    [self.contentScrollView addSubview:duiHuanJuanView];
    self.duiHuanJuanView.showsVerticalScrollIndicator = NO;
    self.duiHuanJuanView.showsHorizontalScrollIndicator = NO;
    
    [self.duiHuanJuanHeaderTypeView.useListButton addTarget:self action:@selector(useListButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
#pragma mark - 现金页面
    
    MyXianJinHeaderTypeView *xianJinHeaderTypeView = [[MyXianJinHeaderTypeView alloc]initWithFrame:CGRectMake(kLKSize.width * 2, 0, kLKSize.width, 36)];
    self.xianJinHeaderTypeView = xianJinHeaderTypeView;
    
    [self.contentScrollView addSubview:xianJinHeaderTypeView];
    
    
    JZMyWalletXianJinView *xianJinView = [[JZMyWalletXianJinView alloc]initWithFrame:CGRectMake(kLKSize.width * 2, 36, kLKSize.width, kLKSize.height -238-64-40.5-36)];
    
    self.xianJinView = xianJinView;
    
    [self.contentScrollView addSubview:xianJinView];
    self.xianJinView.showsVerticalScrollIndicator = NO;
    self.xianJinView.showsHorizontalScrollIndicator = NO;
    
    [self.xianJinHeaderTypeView.seeXianJinListBtn addTarget:self action:@selector(seeXianJinListBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
#pragma mark - 底部页面
    JZMyWalletBottomView *bottomView = [[JZMyWalletBottomView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(jiFenView.frame), kLKSize.width, 40.5)];
    
    self.bottomView = bottomView;
    
    [self.contentScrollView addSubview:bottomView];
    
    if (self.Ycode) {
        self.bottomView.myYCodeLabel.text = self.Ycode;
        
    }else{
        self.bottomView.myYCodeLabel.text = @"暂无";
    }
    
    
    [self.bottomView.inviteFriendBtn addTarget:self action:@selector(inviteFriendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.jiFenHeaderView.goToOthersBtn.userInteractionEnabled = YES;
    [self.jiFenHeaderView.goToOthersBtn addTarget:self action:@selector(goToJiFenMallClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
#pragma mark - scrollowVie的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    NSLog(@"self.contentScrollView.contentOffset.x:%f",self.contentScrollView.contentOffset.x);
    
//    if (scrollView.contentOffset.x > kLKSize.width*1.8) {
//        
//        
//        self.bottomView.transform = CGAffineTransformMakeTranslation(kLKSize.width * 2,0);
//        self.jiFenHeaderView.goToOthersBtn.hidden = NO;
//        
//        self.jiFenHeaderView.goToOthersBtn.userInteractionEnabled = NO;
//        self.jiFenHeaderView.goToOthersBtn.backgroundColor = RGBColor(206, 206, 206);
//        
//    }
    
//    if (scrollView.contentOffset.x < kLKSize.width) {
//        self.bottomView.transform = CGAffineTransformMakeTranslation(0,0);
//        self.jiFenHeaderView.goToOthersBtn.hidden = NO;
//        self.jiFenHeaderView.goToOthersBtn.userInteractionEnabled = YES;
//        self.jiFenHeaderView.goToOthersBtn.backgroundColor = RGBColor(219,68,55);
//        
//        
//        [self getJiFenData];
//        
//    }
    if (scrollView.contentOffset.x == 0) {
        
        
        self.bottomView.transform = CGAffineTransformMakeTranslation(0,0);
        self.jiFenHeaderView.goToOthersBtn.hidden = NO;
        self.jiFenHeaderView.goToOthersBtn.userInteractionEnabled = YES;
        self.jiFenHeaderView.goToOthersBtn.backgroundColor = RGBColor(219,68,55);
        
        [self getJiFenData];
        [self clickJiFenBtn];
        
        [self.jiFenHeaderView.jiFenBtn setTitleColor:RGBColor(219, 68, 55) forState:UIControlStateNormal];

    }
    
    
    
    if (scrollView.contentOffset.x == kLKSize.width) {
        
        
        
        self.jiFenHeaderView.goToOthersBtn.hidden = YES;
        
        [self clickDuiHuanJuanBtn];
        
        [self getDuiHuanJuanData];
        
        [self.jiFenHeaderView.duiHuanJuanBtn setTitleColor:RGBColor(219, 68, 55) forState:UIControlStateNormal];

        
        
    }
    
    if (scrollView.contentOffset.x == kLKSize.width * 2) {
        
        self.bottomView.transform = CGAffineTransformMakeTranslation(kLKSize.width * 2,0);
        self.jiFenHeaderView.goToOthersBtn.hidden = NO;
        
        self.jiFenHeaderView.goToOthersBtn.userInteractionEnabled = NO;
        self.jiFenHeaderView.goToOthersBtn.backgroundColor = RGBColor(206, 206, 206);
        [self.jiFenHeaderView.xianJinBtn setTitleColor:RGBColor(219, 68, 55) forState:UIControlStateNormal];
        
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
            [self.noDataLabel removeFromSuperview];
            if (resultData[@"wallet"]) {
                
                self.jiFenHeaderView.headerNumLabel.text = [NSString stringWithFormat:@"%@",resultData[@"wallet"]];
            }
            //            NSArray *array = resultData[@"list"];
            
            if (!resultData[@"wallet"]) {
                
                self.jiFenHeaderView.headerNumLabel.text = @"暂无";
                
                self.noDataLabel = [[UILabel alloc]init];
                
                self.noDataLabel.textAlignment = NSTextAlignmentCenter;
                
                self.noDataLabel.textColor = JZ_FONTCOLOR_LIGHT;
                [self.noDataLabel setFont:[UIFont systemFontOfSize:16]];
                
                self.noDataLabel.text = @"暂无积分明细";
                
                self.noDataLabel.frame =  CGRectMake(0,0, kLKSize.width, self.xianJinView.bounds.size.height);
                //                self.noDataLabel.transform = CGAffineTransformMakeTranslation(0,0);
                [self.contentScrollView addSubview:self.noDataLabel];
            }
            
            
            
        }
        
    } withFailure:^(id data) {
        [self.noDataLabel removeFromSuperview];
        self.jiFenHeaderView.headerNumLabel.text = @"暂无";
        
        self.noDataLabel = [[UILabel alloc]init];
        
        self.noDataLabel.textAlignment = NSTextAlignmentCenter;
        
        self.noDataLabel.textColor = JZ_FONTCOLOR_LIGHT;
        [self.noDataLabel setFont:[UIFont systemFontOfSize:16]];
        
        self.noDataLabel.text = @"网络开小差啦";
        
        self.noDataLabel.frame =  CGRectMake(0,0, kLKSize.width, self.xianJinView.bounds.size.height);
        //        self.noDataLabel.transform = CGAffineTransformMakeTranslation(0,0);
        [self.contentScrollView addSubview:self.noDataLabel];
        
        
    }];
    
    
}
#pragma mark 获取现金
- (void)getXianJinData{
    
    NSString *urlString = [NSString stringWithFormat:BASEURL, @"userinfo/getmymoneylist"];
    NSDictionary *paramsDict = @{@"userid": [AcountManager manager].userid,@"usertype":@"1"};
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:paramsDict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSDictionary *resultData = data[@"data"];
        NSLog(@"获取现金:%@",data);
        
        if ([[data objectForKey:@"type"] integerValue]) {
            
            [self.noDataLabel removeFromSuperview];
            
            if (resultData[@"money"]) {
                
                self.jiFenHeaderView.headerNumLabel.text = [NSString stringWithFormat:@"￥%@",resultData[@"money"]];
            }
            
            NSArray *array = resultData[@"moneylist"];
            
            if (array.count == 0) {
                
                
                self.noDataLabel = [[UILabel alloc]init];
                
                self.noDataLabel.textAlignment = NSTextAlignmentCenter;
                
                self.noDataLabel.textColor = JZ_FONTCOLOR_LIGHT;
                [self.noDataLabel setFont:[UIFont systemFontOfSize:16]];
                
                self.noDataLabel.text = @"暂无现金明细";
                
                self.noDataLabel.frame =  CGRectMake(0,0, kLKSize.width, self.xianJinView.bounds.size.height);
                self.noDataLabel.transform = CGAffineTransformMakeTranslation(kLKSize.width*2,0);
                [self.contentScrollView addSubview:self.noDataLabel];
                
            }
            
        }
        
    } withFailure:^(id data) {
        
        
        [self.noDataLabel removeFromSuperview];
        self.noDataLabel = [[UILabel alloc]init];
        
        self.noDataLabel.textAlignment = NSTextAlignmentCenter;
        
        self.noDataLabel.textColor = JZ_FONTCOLOR_LIGHT;
        [self.noDataLabel setFont:[UIFont systemFontOfSize:16]];
        
        self.noDataLabel.text = @"网络开小差啦";
        
        self.noDataLabel.frame =  CGRectMake(0,0, kLKSize.width, self.xianJinView.bounds.size.height);
        self.noDataLabel.transform = CGAffineTransformMakeTranslation(kLKSize.width*2,0);
        [self.contentScrollView addSubview:self.noDataLabel];
        
        
    }];
    
    
}
#pragma mark - 获取兑换券
-(void)getDuiHuanJuanData {
    
    NSString *urlString = [NSString stringWithFormat:BASEURL, @"userinfo/getmycupon"];
    NSDictionary *paramsDict = @{@"userid": [AcountManager manager].userid};
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:paramsDict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        if ([[data objectForKey:@"type"] integerValue]) {
            [self.duiHuanJuanDataArrM removeAllObjects];
            [self.noDataLabel removeFromSuperview];
            NSArray *array = data[@"data"];
            
            NSLog(@"%@",array);
            if (array.count) {
                
                NSArray *duiHuanJuanDataArr = data[@"data"];
                
                for (NSDictionary *dict in duiHuanJuanDataArr) {
                    
                    JZMyWalletDuiHuanJuanData *data = [JZMyWalletDuiHuanJuanData yy_modelWithDictionary:dict];
                    if(data.state == 0 || data.state == 1){
                        
                        [self.duiHuanJuanDataArrM addObject:data];
                    }
                    
                    
                    NSArray *listArr = data.useproductidlist;
                    
                    
                    if (listArr.count == 0) {
                        [self.noDataLabel removeFromSuperview];
                        
                        //                        self.jiFenHeaderView.headerNumLabel.text = @"暂无";
                        
                        self.noDataLabel = [[UILabel alloc]init];
                        
                        self.noDataLabel.textAlignment = NSTextAlignmentCenter;
                        
                        self.noDataLabel.textColor = JZ_FONTCOLOR_LIGHT;
                        [self.noDataLabel setFont:[UIFont systemFontOfSize:16]];
                        
                        self.noDataLabel.text = @"暂无兑换券";
                        
                        self.noDataLabel.frame =  CGRectMake(0,0, kLKSize.width, self.duiHuanJuanView.bounds.size.height);
                        self.noDataLabel.transform = CGAffineTransformMakeTranslation(kLKSize.width,0);
                        [self.contentScrollView addSubview:self.noDataLabel];
                        
                    }
                    
                    
                }
                [self addcountDiscount];
                
                
            }else {
                
                [self.noDataLabel removeFromSuperview];
                
                //                self.jiFenHeaderView.headerNumLabel.text = @"暂无";
                
                self.noDataLabel = [[UILabel alloc]init];
                
                self.noDataLabel.textAlignment = NSTextAlignmentCenter;
                
                self.noDataLabel.textColor = JZ_FONTCOLOR_LIGHT;
                [self.noDataLabel setFont:[UIFont systemFontOfSize:16]];
                
                //        self.noDataLabel.backgroundColor = [UIColor blueColor];
                self.noDataLabel.text = @"暂无兑换券";
                
                self.noDataLabel.frame =  CGRectMake(0,0, kLKSize.width, self.duiHuanJuanView.bounds.size.height);
                self.noDataLabel.transform = CGAffineTransformMakeTranslation(kLKSize.width,0);
                [self.contentScrollView addSubview:self.noDataLabel];
                
                
            }
            
            
            
            
        }
        
    } withFailure:^(id data) {
        
        [self.noDataLabel removeFromSuperview];
        
        //        self.jiFenHeaderView.headerNumLabel.text = @"暂无";
        
        self.noDataLabel = [[UILabel alloc]init];
        
        self.noDataLabel.textAlignment = NSTextAlignmentCenter;
        
        self.noDataLabel.textColor = JZ_FONTCOLOR_LIGHT;
        [self.noDataLabel setFont:[UIFont systemFontOfSize:16]];
        
        //        self.noDataLabel.backgroundColor = [UIColor blueColor];
        self.noDataLabel.text = @"网络开小差了";
        
        self.noDataLabel.frame =  CGRectMake(0,0, kLKSize.width, self.duiHuanJuanView.bounds.size.height);
        self.noDataLabel.transform = CGAffineTransformMakeTranslation(kLKSize.width,0);
        [self.contentScrollView addSubview:self.noDataLabel];
        
        
        
    }];
    
    
    
}
- (void)addcountDiscount{
    self.jiFenHeaderView.headerNumLabel.text = [NSString stringWithFormat:@"%lu张",self.duiHuanJuanDataArrM.count];
}
#pragma mark - 顶部按钮的点击事件
#pragma mark - 点击积分
-(void)clickJiFenBtn {
    
    [self.contentScrollView setContentOffset:CGPointMake(0, 0)];
    
    self.jiFenHeaderView.goToOthersBtn.userInteractionEnabled = YES;
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
    
    [self.contentScrollView setContentOffset:CGPointMake(kLKSize.width, 0)];
    [self.jiFenHeaderView.duiHuanJuanBtn setTitleColor:RGBColor(219, 68, 55) forState:UIControlStateNormal];
    self.jiFenHeaderView.jiFenBtn.titleLabel.textColor = RGBColor(110, 110, 110);
    self.jiFenHeaderView.xianJinBtn.titleLabel.textColor = RGBColor(110, 110, 110);
    
    [self.jiFenHeaderView.headerImg setImage:[UIImage imageNamed:@"wallet_ticket"]];
    [self.jiFenHeaderView.goToOthersBtn setTitle:@"" forState:UIControlStateNormal];
    self.jiFenHeaderView.howDoBtn.hidden = YES;
    
    self.jiFenHeaderView.goToOthersBtn.layer.borderWidth = 0;
    
    self.jiFenHeaderView.headerNumLabel.text = [NSString stringWithFormat:@"%zd张",self.duiHuanJuanView.duiHuanJuanDataArrM.count];
    
    
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.jiFenHeaderView.rollLineView.transform = CGAffineTransformMakeTranslation(kLKSize.width/3,0);
        
    }];}
#pragma mark - 点击现金
-(void)clickXianJinBtn {
    
    [self.contentScrollView setContentOffset:CGPointMake(kLKSize.width*2, 0)];
    
    self.jiFenHeaderView.goToOthersBtn.userInteractionEnabled = NO;
    
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

#pragma mark - 邀请好友按钮点击
- (void)inviteFriendBtnClick{
    
    [DVVShare shareWithTitle:DVV_Share_Default_Title
                     content:DVV_Share_Default_Content
                       image:DVV_Share_Default_Image
                    location:nil
                         url:nil
                     success:^(NSString *platformName) {
                         [self obj_showTotasViewWithMes:DVV_Share_Default_Success_Mark_Word];
                     }];
}


#pragma mark - 积分商城按钮点击
-(void)goToJiFenMallClick {
    
    YBMyWalletMallViewController *mallVC = [[YBMyWalletMallViewController alloc]init];
    
    [self.navigationController pushViewController:mallVC animated:YES];
}
#pragma mark - 如何赚取积分
-(void)howAddJiFenClick:(UIButton *)btn {
    JZHowAddJiFenViewController *howAddVC = [[JZHowAddJiFenViewController alloc]init];
    
    
    howAddVC.myJiFenCount = self.jiFenHeaderView.headerNumLabel.text;
    [self.navigationController pushViewController:howAddVC animated:YES];
    
    
}

#pragma mark - 跳转到兑换记录界面
-(void)goToDuiHuanListClick {
    
    JZExchangeRecordController *duiHuanListVC = [[JZExchangeRecordController alloc]init];
    
    [self.navigationController pushViewController:duiHuanListVC animated:YES];
    
}

#pragma mark - 跳转到使用记录的页面
-(void)useListButtonClick {
    
    JZDiscountRecodeController *discountRecordVC = [[JZDiscountRecodeController alloc]init];
    [self.navigationController pushViewController:discountRecordVC animated:YES];
    
    
    
}

#pragma mark - 现金提现记录

-(void)seeXianJinListBtn {
    
    JZTiXianListController *tiXianVC = [[JZTiXianListController alloc]init];
    
    [self.navigationController pushViewController:tiXianVC animated:YES];
    
}
-(NSMutableArray *)duiHuanJuanDataArrM {
    
    if (_duiHuanJuanDataArrM ==  nil) {
        
        _duiHuanJuanDataArrM = [[NSMutableArray alloc]init];
    }
    return _duiHuanJuanDataArrM;
}
-(NSMutableArray *)duihuanJuanListArrM {
    
    if (_duihuanJuanListArrM==  nil) {
        
        _duihuanJuanListArrM = [[NSMutableArray alloc]init];
    }
    return _duihuanJuanListArrM;
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

@end
