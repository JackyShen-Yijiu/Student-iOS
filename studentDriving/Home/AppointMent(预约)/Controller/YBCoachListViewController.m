//
//  YBCoachListViewController.m
//  BlackCat
//
//  Created by 董博 on 15/9/8.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "YBCoachListViewController.h"
#import "YBCoachListViewCell.h"
#import "CoachModel.h"
#import "YBCoachListSearchController.h"
#import "YBCoachListSearchController.h"

@interface YBCoachListViewController ()<UITableViewDelegate,UITableViewDataSource,BMKLocationServiceDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *coachListDataArray;

@end

@implementation YBCoachListViewController

- (NSMutableArray *)coachListDataArray {
    if (_coachListDataArray == nil) {
        _coachListDataArray = [[NSMutableArray alloc] init];
    }
    return _coachListDataArray;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"教练列表";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-chazhao_coach"] style:UIBarButtonItemStyleDone target:self action:@selector(clickRight)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
   
    [self loadData];
    
}

- (void)clickRight{
    NSLog(@"%s",__func__);
    
    YBCoachListSearchController *vc = [[YBCoachListSearchController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)loadData {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    NSString *url = [NSString stringWithFormat:BASEURL,kappointmentCoachUrl];
    
    // 更换某时段可预约教练
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    WS(ws);
    [JENetwoking startDownLoadWithUrl:url postParam:dict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
       
        NSLog(@"教练列表data:%@",data);
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (data) {
            
            NSDictionary *param = data;
            NSNumber *type = param[@"type"];
            NSString *msg = [NSString stringWithFormat:@"%@", param[@"msg"]];
            
            if (type.integerValue == 1) {
                
                NSArray *array = param[@"data"];
                NSLog(@"%@", array);
                if (!self.coachListDataArray.count && !array.count) {
                    [self showTotasViewWithMes:@"没有查询到教练"];
                }
                NSError *error = nil;
                
                [ws.coachListDataArray addObjectsFromArray: [MTLJSONAdapter modelsOfClass:CoachModel.class fromJSONArray:array error:&error]];
            
                [ws.tableView reloadData];
                
            }else {
                kShowFail(msg);
            }
        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.coachListDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    YBCoachListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YBCoachListViewCell"];
    if (!cell) {
        cell = [[YBCoachListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBCoachListViewCell"];
    }
    
    CoachModel *model = self.coachListDataArray[indexPath.row];
    
    [cell receivedCellModelWith:model];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSLog(@"%s",__func__);
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

@end
