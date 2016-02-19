//
//  YBCoachListViewController.m
//  BlackCat
//
//  Created by 董博 on 15/9/8.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "YBCoachListViewController.h"
#import "YBCoachListViewCell.h"
#import "ToolHeader.h"
#import <Masonry.h>
#import "UIView+CalculateUIView.h"
#import "CoachModel.h"
#import "UIColor+Hex.h"
#import "YBCoachListSearchController.h"
#import "YBCoachListSearchController.h"

static NSString *const kappointmentCoachUrl = @"userinfo/getusefulcoach/index/1";

@interface YBCoachListViewController ()<UITableViewDelegate,UITableViewDataSource,BMKLocationServiceDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation YBCoachListViewController

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
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
    if (self.isModifyCoach) {
        dict[@"timeid"] = self.timeid;
        dict[@"coursedate"] = self.coursedate;
    }
    
    [JENetwoking startDownLoadWithUrl:url postParam:dict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
       
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (data) {
            NSDictionary *param = data;
            NSNumber *type = param[@"type"];
            NSString *msg = [NSString stringWithFormat:@"%@", param[@"msg"]];
            if (type.integerValue == 1) {
                NSArray *array = param[@"data"];
                NSLog(@"%@", array);
                if (!self.dataArray.count && !array.count) {
                    [self showTotasViewWithMes:@"没有查询到教练"];
                }
                NSError *error = nil;
                [self.dataArray addObjectsFromArray: [MTLJSONAdapter modelsOfClass:CoachModel.class fromJSONArray:array error:&error]];
    
                [self.tableView reloadData];
                
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
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    YBCoachListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YBCoachListViewCell"];
    if (!cell) {
        cell = [[YBCoachListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBCoachListViewCell"];
    }
    
    CoachModel *model = self.dataArray[indexPath.row];
    
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
