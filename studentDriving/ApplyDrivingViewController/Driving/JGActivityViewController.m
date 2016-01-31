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
        _tableView.backgroundColor = RGBColor(255, 255, 255);
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGBColor(251, 251, 251);;
    
    self.title = @"活动";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];

    __weak typeof(self) ws = self;
    [DVVLocation reverseGeoCode:^(BMKReverseGeoCodeResult *result, NSString *city, NSString *address) {
        ws.cityName = city;
    } error:^{
        ;
    }];
    
    // 获取活动列表
    [self startDownLoad];
    [self.tableView.mj_header beginRefreshing];
    
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
                
                NSArray *array = data[@"data"];
                
                for (NSDictionary *dic in array) {
                    NSError *error = nil;
                    JGActivityModel *dModel = [MTLJSONAdapter modelOfClass:JGActivityModel.class fromJSONDictionary:dic error:&error];
                    [ws.activityArray addObject:dModel];
                }
                
//                for (NSDictionary *dict in array) {
//                    
//                    JGActivityModel *dmData = [JGActivityModel yy_modelWithDictionary:dict];
//                    
//                    [ws.activityArray addObject:dmData];
//                    
//                }
                
                [ws.tableView reloadData];
                
            }else {
                
                kShowFail(msg);
                
            }
            
        }];
        
    }];
    
    self.tableView.mj_header = refreshHeader;
    
}

#pragma mark --- 4组数据
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 3;
//}
#pragma mark --- 每一组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.activityArray.count;
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
        
    cell.activityModel = self.activityArray[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
}


@end