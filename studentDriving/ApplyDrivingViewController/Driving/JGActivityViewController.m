//
//  DetailViewController.m
//  BlackCat
//
//  Created by 董博 on 15/9/17.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "JGActivityViewController.h"
#import "MJRefresh.h"
#import "YYModel.h"
#import "JGActivityCell.h"
#import "DVVLocation.h"
#import "JGActivityModel.h"
#import "JGActivityDetailsViewController.h"
#import "DVVShare.h"

@interface JGActivityViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

/*
 * 活动列表
 */
@property (strong, nonatomic) NSMutableArray *activityArray;

@property (nonatomic,copy) NSString *cityName;

@end

@implementation JGActivityViewController

- (NSMutableArray *)activityArray
{
    if (_activityArray == nil) {
        
        _activityArray = [NSMutableArray array];
        
    }
    return _activityArray;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, kSystemWide, kSystemHeight-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGBColor(244, 249, 250);
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGBColor(244, 249, 250);
    
    self.title = @"活动";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];

    // 获取活动列表
    [self startDownLoad];
    [self.tableView.mj_header beginRefreshing];

    __weak typeof(self) ws = self;
    
    [DVVLocation reverseGeoCode:^(BMKReverseGeoCodeResult *result, CLLocationCoordinate2D coordinate, NSString *city, NSString *address) {
        ws.cityName = city;
        [ws.tableView.mj_header beginRefreshing];
    } error:^{
        [ws.tableView.mj_header beginRefreshing];
    }];
    
    // 添加分享
    UIButton *button = [UIButton new];
    [button setTitle:@"分享" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.bounds = CGRectMake(0, 0, 14 * 2, 44);
    [button addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)share {
    
    // 显示分享
    [DVVShare shareWithTitle:DVV_Share_Default_Title content:DVV_Share_Default_Content image:DVV_Share_Default_Image location:nil urlResource:nil success:^(NSString *platformName) {
        [self obj_showTotasViewWithMes:DVV_Share_Default_Success_Mark_Word];
    }];
}

- (void)startDownLoad {
    
    
    if (self.cityName==nil) {
        self.cityName = @"北京";
    }
    
    __weak typeof(self) ws = self;
    
    NSString *urlComment = [NSString stringWithFormat:BASEURL,@"getactivity"];

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"cityname"] = self.cityName;
    
    // 加载
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [JENetwoking startDownLoadWithUrl:urlComment postParam:dict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
            
            [ws.tableView.mj_header endRefreshing];
            
            NSDictionary *param = data;
            NSNumber *type = param[@"type"];
            NSString *msg = [NSString stringWithFormat:@"%@",param[@"msg"]];
            
            if (type.integerValue == 1) {
                
                [ws.activityArray removeAllObjects];
                
                NSMutableArray *tempArray = [NSMutableArray array];
                NSMutableArray *tempArray1 = [NSMutableArray array];
                NSMutableArray *tempArray2 = [NSMutableArray array];

                NSArray *array = data[@"data"];
                for (NSDictionary *dataDict in array) {
                    
                    NSError *error = nil;
                    
                    JGActivityModel *dModel = [MTLJSONAdapter modelOfClass:JGActivityModel.class fromJSONDictionary:dataDict error:&error];

                    NSLog(@"dModel.activitystate:%ld",(long)dModel.activitystate);
                    
                    if (dModel.activitystate==activitystateRead) {//@"  准备中"
                        [tempArray addObject:dModel];
                    }else if (dModel.activitystate==activitystateIng){//@"  进行中"
                        [tempArray1 addObject:dModel];
                    }else if (dModel.activitystate==activitystateComplete){//@"  已结束"
                        [tempArray2 addObject:dModel];
                    }
                    
                    
                }
                
                [self.activityArray addObject:tempArray1];
                [self.activityArray addObject:tempArray];
                [self.activityArray addObject:tempArray2];
                
                NSLog(@"self.activityArray:%@",self.activityArray);
                
                [ws.tableView reloadData];
                
            }else {
                
                kShowFail(msg);
                
            }
            
        }];
        
    }];
    
    self.tableView.mj_header = refreshHeader;
    
}

#pragma mark --- 4组数据
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
#pragma mark --- 每一组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"self.activityArray:%@",self.activityArray);
    
    if (self.activityArray&&self.activityArray.count!=0) {
        NSArray *tempArray = self.activityArray[section];
        if (tempArray&&tempArray.count!=0) {
            return tempArray.count;
        }else{
            return 0;
        }
    }
    return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 30)];
    headerView.backgroundColor = RGBColor(244, 249, 250);
    
    UILabel *titleLabe = [[UILabel alloc] init];
    titleLabe.textColor = [UIColor lightGrayColor];
    titleLabe.textAlignment = NSTextAlignmentCenter;
    titleLabe.backgroundColor = [UIColor clearColor];
    titleLabe.frame = CGRectMake(0, 7, headerView.frame.size.width, 15);
    titleLabe.text = @"进行中";
    if (section==1) {
        titleLabe.text = @"敬请期待";
        headerView.backgroundColor = [UIColor whiteColor];
    }else if (section==2){
        titleLabe.text = @"已结束";
        headerView.backgroundColor = [UIColor whiteColor];
    }
    titleLabe.font = [UIFont boldSystemFontOfSize:13];
    [headerView addSubview:titleLabe];
    
    return headerView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"JGActivityCell";
    JGActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[JGActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.backgroundColor = RGBColor(244, 249, 250);
    cell.contentView.backgroundColor = RGBColor(244, 249, 250);
    
    cell.activityImgView.contentMode = UIViewContentModeScaleToFill;
    
    NSArray *tempArray = self.activityArray[indexPath.section];

    cell.activityModel = tempArray[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *tempArray = self.activityArray[indexPath.section];
    
    JGActivityModel *model = tempArray[indexPath.row];
    
    JGActivityDetailsViewController *vc = [[JGActivityDetailsViewController alloc] init];
    
    vc.activityModel = model;

    [self.navigationController pushViewController:vc animated:YES];
    
}


@end