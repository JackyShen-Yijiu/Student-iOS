//
//  YBMyComplaintListController.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBMyComplaintListController.h"
#import "YBMyComplaintListCell.h"
#import "YBAppointMentNoCountentView.h"

@interface YBMyComplaintListController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *dataTabelView;
@property (nonatomic,strong) YBAppointMentNoCountentView *noCountmentView;

@end

@implementation YBMyComplaintListController

- (YBAppointMentNoCountentView *)noCountmentView
{
    if (_noCountmentView==nil) {
        _noCountmentView = [[YBAppointMentNoCountentView alloc] init];
        _noCountmentView.message = @"暂无投诉记录";
        _noCountmentView.frame = self.view.bounds;
    }
    return _noCountmentView;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - lazy load
- (UITableView *)dataTabelView {
    if (!_dataTabelView) {
        _dataTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-64)];
        _dataTabelView.dataSource = self;
        _dataTabelView.delegate = self;
        // 如果是固定高度的话在这里设置比较好
        _dataTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _dataTabelView.backgroundColor = RGBColor(232, 232, 237);
    }
    return _dataTabelView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBColor(232, 232, 237);
    
    self.title = @"我的投诉";
    
    [self.view addSubview:self.dataTabelView];
        
    // 没有内容，占位图
    [self.view addSubview:self.noCountmentView];

    [self loadData];
    
}

- (void)loadData
{
    NSString *urlString = [NSString stringWithFormat:BASEURL, @"userinfo/getmywallet"];
    NSDictionary *paramsDict = @{@"userid": [AcountManager manager].userid,@"usertype":@"1",@"seqindex":@"1"};
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:paramsDict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        if ([[data objectForKey:@"type"] integerValue]) {
            
            NSArray *listArray = data[@"list"];
            for (NSDictionary *listDict in listArray) {
                [self.dataArray addObject:listDict];
            }
            
            [self.noCountmentView setHidden:listArray.count];

            [self.dataTabelView reloadData];
            
        }
        
    } withFailure:^(id data) {
        
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [YBMyComplaintListCell heightWithModel:self.dataArray[indexPath.row]];
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"YBCheatslistViewCell";
    
    YBMyComplaintListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YBMyComplaintListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.detailModel = self.dataArray[indexPath.row];
    
    return cell;
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
