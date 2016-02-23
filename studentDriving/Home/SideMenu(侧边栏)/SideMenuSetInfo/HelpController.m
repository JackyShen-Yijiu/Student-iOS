//
//  HelpController.m
//  studentDriving
//
//  Created by zyt on 16/2/22.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "HelpController.h"
#import "HelpCell.h"

@interface HelpController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *strArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation HelpController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"使用帮助";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self setUpData];
    
}
- (void)setUpData
{
    // JSON文件的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"YBHelpData.json" ofType:nil];
    
    // 加载JSON文件
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    // 将JSON数据转为NSArray或者NSDictionary
    NSDictionary *dictArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSLog(@"dictArray:%@",dictArray);
    
    NSArray *dataArray = [dictArray objectForKey:@"data"];
    
    NSLog(@"dataArray:%@",dataArray);
    
    for (NSDictionary *dict in dataArray) {
        [self.strArray addObject:dict];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _strArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = @"signUpID";
    HelpCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[HelpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.strDic = self.strArray[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)strArray
{
    if (_strArray==nil) {
        _strArray = [NSMutableArray array];
    }
    return _strArray;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.row) {
        // 使用指南
    }else if (1 == indexPath.row){
        // 理论考试
    }
    else if (2 == indexPath.row){
        // 新手上路
    }
    else if (3 == indexPath.row){
        // 常见问题
    }
    
}
@end
