//
//  YBCoachListSearchController.m
//  BlackCat
//
//  Created by 董博 on 15/9/8.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "YBCoachListSearchController.h"
#import "YBCoachListViewCell.h"
#import "ToolHeader.h"
#import <Masonry.h>
#import "UIView+CalculateUIView.h"
#import "CoachModel.h"
#import "UIColor+Hex.h"
#import "YBCoachListSearchController.h"

static NSString *const kappointmentCoachUrl = @"userinfo/getusefulcoach/index/1";

@interface YBCoachListSearchController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (nonatomic,weak)UISearchBar *searchBar;

@end

@implementation YBCoachListSearchController

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
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.placeholder = @"搜索";
    //searchBar.font = [UIFont systemFontOfSize:13];
    searchBar.frame = CGRectMake(0, 0, self.view.width-50, 0.f);
    //UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconfont-chazhao-2"]];
    //leftView.backgroundColor = [UIColor clearColor];
    //leftView.frame = CGRectMake(0, 0, 22, 22);
    //searchBar.leftView = leftView;
    //searchBar.leftViewMode = UITextFieldViewModeUnlessEditing;
    searchBar.backgroundColor = [UIColor clearColor];
    searchBar.layer.masksToBounds = YES;
    searchBar.layer.cornerRadius = 5;
    searchBar.delegate = self;
    //searchBar.clearsOnBeginEditing = YES;
    self.navigationItem.titleView = searchBar;
    self.searchBar = searchBar;

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
    [self loadData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.searchBar resignFirstResponder];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar endEditing:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"searchBar.text:%@",searchBar.text);
    [self.searchBar endEditing:YES];
    
    [self loadData];
    
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

@end
