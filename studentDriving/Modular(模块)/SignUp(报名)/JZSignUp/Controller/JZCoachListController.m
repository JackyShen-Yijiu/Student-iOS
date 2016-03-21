//
//  JZCoachListController.m
//  studentDriving
//
//  Created by ytzhang on 16/3/17.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZCoachListController.h"
#import "YBCoachListViewCell.h"
#import "JZCoachListMoel.h"
#import "YYModel.h"
#import "JZSignUpCoachListCell.h"
#import <MJRefresh.h>

@interface JZCoachListController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger moreIndex; // 上拉加载更多时,下标

}

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *coachListDataArray;
@end

@implementation JZCoachListController

- (void)viewDidLoad {
    [super viewDidLoad];
    moreIndex = 1;
    self.title = @"教练列表";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self initDataWithRefresh:YES];
    [self refresh];
}
- (void)initDataWithRefresh:(BOOL)isRefresh{
    if (isRefresh) {
        moreIndex = 1;
    }
    if (!isRefresh) {
        ++moreIndex;
    }
    NSString *index =  [NSString stringWithFormat:@"/%lu",moreIndex];
    NSString *coachListUrl = [NSString stringWithFormat:kdriveschoolofcoach,self.dmData.schoolinfo.schoolid];
    NSLog(@"coachListUrl%@",coachListUrl);
    NSString *resultURl = [NSString stringWithFormat:@"%@%@",coachListUrl,index];

    NSString *url = [NSString stringWithFormat:BASEURL,resultURl];
//    NSDictionary *param = @{@"index":@"1",
//                            @"schoolid":self.dmData.schoolinfo.schoolid
//                        };
    NSLog(@"url = %@",url);
    [JENetwoking startDownLoadWithUrl:url postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSLog( @"%@",data);
        
        NSDictionary *param = data;
        if ([param[@"type"] integerValue] == 1) {
            NSArray *array = param[@"data"];
            if (isRefresh) {
                // 下拉刷新
               [ self.tableView.mj_header  endRefreshing];
                if (array.count) {
                    [self.coachListDataArray removeAllObjects];
                    for (NSDictionary *dic in array) {
                        JZCoachListMoel *coachListModel = [JZCoachListMoel yy_modelWithDictionary:dic];
                        [self.coachListDataArray addObject:coachListModel];
                        
                    }
                    [self.tableView reloadData];
                } else if (array.count == 0){
                    [self obj_showTotasViewWithMes:@"暂没有教练"];
                    return ;
                }

            } else if (!isRefresh){
                // 上拉加载更多
                if (array.count) {
                    for (NSDictionary *dic in array) {
                        JZCoachListMoel *coachListModel = [JZCoachListMoel yy_modelWithDictionary:dic];
                        [self.coachListDataArray addObject:coachListModel];
                        [self.tableView reloadData];
                        
                    }

                }else if (array.count == 0){
                    [self obj_showTotasViewWithMes:@"已加载全部数据"];
                    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                }
            }
           
            [self.tableView.mj_footer endRefreshing];
        
        }
        
    } withFailure:^(id data) {
         [self.tableView.mj_header  endRefreshing];
        [self.tableView.mj_footer  endRefreshing];
        [self obj_showTotasViewWithMes:data[@"msg"]];
    }];
}
- (void)refresh{
    
    __weak typeof(self) ws = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self initDataWithRefresh:YES];
       
    
    }];
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self initDataWithRefresh:NO];
            }];

   ws.tableView.mj_header = header;
    ws.tableView.mj_footer = footer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 104;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.coachListDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    YBCoachListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YBCoachListViewCell"];
    if (!cell) {
        cell = [[YBCoachListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBCoachListViewCell"];
    }
    
    JZCoachListMoel *model = self.coachListDataArray[indexPath.row];
    
    [cell receivedCellModelFormSignUpWith:model];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    JZCoachListMoel *model = self.coachListDataArray[indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(JZCoachListViewControllerWithCoach:)]) {
        [self.delegate JZCoachListViewControllerWithCoach:model];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark -- Lazy 加载

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

@end
