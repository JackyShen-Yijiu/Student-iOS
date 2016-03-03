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
#import "YBConsultationController.h"

@interface MyConsultationListController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *dataTabelView;
@property (nonatomic,strong) YBAppointMentNoCountentView *noCountmentView;

@property (nonatomic,strong) UIView *footView;

@property (nonatomic,strong) UIButton *askBtn;
@property (nonatomic,strong) UIButton *callBtn;

@property(nonatomic,strong)UIView * delive;
@property(nonatomic,strong)UIView * topDelive;

@end

@implementation MyConsultationListController

- (YBAppointMentNoCountentView *)noCountmentView
{
    if (_noCountmentView==nil) {
        _noCountmentView = [[YBAppointMentNoCountentView alloc] init];
        _noCountmentView.label1.text = @"暂无数据";
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

// 中间分割线
- (UIView *)delive
{
    if (_delive == nil) {
        _delive = [[UIView alloc] initWithFrame:CGRectMake(self.view.width/2, 0, 1, 46)];
        _delive.backgroundColor = [UIColor lightGrayColor];
        _delive.alpha = 0.3;
    }
    return _delive;
}
- (UIView *)topDelive
{
    if (_topDelive == nil) {
        _topDelive = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 1)];
        _topDelive.backgroundColor = [UIColor lightGrayColor];
        _topDelive.alpha = 0.3;
    }
    return _topDelive;
}
- (UIButton *)askBtn
{
    if (_askBtn==nil) {
        
        _askBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width/2, 1, _footView.width/2, 46)];
        _askBtn.backgroundColor = [UIColor whiteColor];
        [_askBtn setTitle:@"我要提问" forState:UIControlStateNormal];
        [_askBtn setTitle:@"我要提问" forState:UIControlStateNormal];
        [_askBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_askBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_askBtn addTarget:self action:@selector(askBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        _askBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
    }
    
    return _askBtn;
    
}

- (UIButton *)callBtn
{
    if (_callBtn==nil) {
        
        _callBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 1, _footView.width/2, 46)];
        _callBtn.backgroundColor = [UIColor whiteColor];
        [_callBtn setTitle:@"拨打客服" forState:UIControlStateNormal];
        [_callBtn setTitle:@"拨打客服" forState:UIControlStateNormal];
        _callBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_callBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_callBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_callBtn addTarget:self action:@selector(callBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return  _callBtn;
}

- (UIView *)footView
{
    if (_footView==nil) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height-46-64, self.view.width, 46)];
        _footView.backgroundColor = [UIColor whiteColor];
    }
    return _footView;
}

- (void)callBtnDidClick
{
    UIAlertView  * alert = [[UIAlertView alloc] initWithTitle:@"咨询电话" message:@"400-626-9255" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        
        NSLog(@"%s",__func__);
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"400-626-9255"];
        //            NSLog(@"str======%@",str);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }
}

- (void)askBtnDidClick
{
    NSLog(@"%s",__func__);
    YBConsultationController *vc = [[YBConsultationController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - lazy load
- (UITableView *)dataTabelView {
    if (!_dataTabelView) {
        _dataTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-64-46)];
        _dataTabelView.dataSource = self;
        _dataTabelView.delegate = self;
        // 如果是固定高度的话在这里设置比较好
        _dataTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _dataTabelView.backgroundColor = [UIColor clearColor];
    }
    return _dataTabelView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBColor(232, 232, 237);
    
    self.title = @"咨询答疑";
    
    [self.view addSubview:self.dataTabelView];
    
    [self.view addSubview:self.footView];
    [self.footView addSubview:self.askBtn];
    [self.footView addSubview:self.callBtn];
    [self.footView addSubview:self.delive];
    [self.footView addSubview:self.topDelive];
    
    // 没有内容，占位图
    [self.view addSubview:self.noCountmentView];
    
}

- (void)loadData
{
    
    NSString *urlString = [NSString stringWithFormat:BASEURL, @"getuserconsult"];
    NSDictionary *paramsDict = @{@"index": @"1"};
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:paramsDict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"咨询答疑data:%@",data);
        
        NSArray *dictArray = data[@"data"];
        
        if ([[data objectForKey:@"type"] integerValue]) {
            
            for (NSDictionary *listDict in dictArray) {
                [self.dataArray addObject:listDict];
            }
            
            [self.noCountmentView setHidden:self.dataArray.count];
            
            [self.dataTabelView reloadData];
            
        }
        //
    } withFailure:^(id data) {
        
    }];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MyConsultationListCell heightWithModel:self.dataArray[indexPath.row]];
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
