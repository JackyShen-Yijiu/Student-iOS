//
//  MyConsultationListController.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "MyConsultationListController.h"
#import "MyConsultationListCell.h"
#import "YBAppointMentNoCountentView.h"

@interface MyConsultationListController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *dataTabelView;
@property (nonatomic,strong) YBAppointMentNoCountentView *noCountmentView;

@end

@implementation MyConsultationListController

- (YBAppointMentNoCountentView *)noCountmentView
{
    if (_noCountmentView==nil) {
        _noCountmentView = [[YBAppointMentNoCountentView alloc] init];
        _noCountmentView.message = @"暂无数据";
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
    
    self.title = @"咨询答疑";
    
    [self.view addSubview:self.dataTabelView];
    
    // 没有内容，占位图
    [self.view addSubview:self.noCountmentView];
    
    [self loadData];
    
}

- (void)loadData
{
    
    NSString *urlString = [NSString stringWithFormat:BASEURL, @"courseinfo/getmycomplaint"];
    
    NSString *url = [NSString stringWithFormat:@"%@?userid=%@",urlString,[AcountManager manager].userid];
    
    [JENetwoking startDownLoadWithUrl:url postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"咨询答疑urlString:%@ data:%@",url,data);
        
        NSArray *dictArray = data[@"data"];
        
        if ([[data objectForKey:@"type"] integerValue]) {
            
            for (NSDictionary *listDict in dictArray) {
                [self.dataArray addObject:listDict];
            }
            
            [self.noCountmentView setHidden:self.dataArray.count];
            
            [self.dataTabelView reloadData];
            
        }
        
    } withFailure:^(id data) {
        
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MyConsultationListCell heightWithModel:nil];

    return [MyConsultationListCell heightWithModel:self.dataArray[indexPath.row]];
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"YBMyComplaintListCell";
    
    MyConsultationListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MyConsultationListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor lightGrayColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    cell.detailModel = self.dataArray[indexPath.row];
    
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
