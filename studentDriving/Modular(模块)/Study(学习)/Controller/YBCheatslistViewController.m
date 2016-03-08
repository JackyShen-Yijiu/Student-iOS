//
//  YBCheatslistViewController.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBCheatslistViewController.h"
#import "YBCheatsViewController.h"
#import "YBCheatslistViewCell.h"

@interface YBCheatslistViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *dataTabelView;

@property (nonatomic,strong) UIView *headView;

@end

@implementation YBCheatslistViewController

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UIView *)headView
{
    if (_headView == nil) {
        
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 128)];
        _headView.backgroundColor = RGBColor(247, 247, 247);
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(_headView.width/2-26/2, 34, 26, 34)];
        img.image = [UIImage imageNamed:@"lamp"];
        [_headView addSubview:img];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(img.frame)+20, _headView.width-20, 14)];
        label.text = @"科目三实战技巧大揭秘";
        if (_isSubjectTwo) {
            label.text = @"科目二实战技巧大揭秘";
        }
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor lightGrayColor];
        [_headView addSubview:label];
        
    }
    return _headView;
}

#pragma mark - lazy load
- (UITableView *)dataTabelView {
    if (!_dataTabelView) {
        _dataTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-64)];
//        _dataTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _dataTabelView.dataSource = self;
        _dataTabelView.delegate = self;
        // 如果是固定高度的话在这里设置比较好
        _dataTabelView.rowHeight = 54;
        _dataTabelView.tableHeaderView = self.headView;
        _dataTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _dataTabelView.backgroundColor = RGBColor(232, 232, 237);
    }
    return _dataTabelView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = RGBColor(232, 232, 237);
    
    self.title = @"学车秘籍";
    
    [self.view addSubview:self.dataTabelView];
    
    [self loadData];
    
}

- (void)loadData
{
    // JSON文件的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"YBCheatsData.json" ofType:nil];
    
    // 加载JSON文件
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    // 将JSON数据转为NSArray或者NSDictionary
    NSDictionary *dictArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSLog(@"dictArray:%@",dictArray);
    
    NSArray *dataArray = [dictArray objectForKey:@"data"];
    
    NSLog(@"dataArray:%@",dataArray);
    
    if (self.isSubjectTwo) {
        for (NSDictionary *dict in dataArray[0]) {
            [self.dataArray addObject:dict];
        }
    }else{
        for (NSDictionary *dict in dataArray[1]) {
            [self.dataArray addObject:dict];
        }
    }
   
    [self.dataTabelView reloadData];
    
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"YBCheatslistViewCell";
    
    YBCheatslistViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YBCheatslistViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.backgroundColor = RGBColor(247, 247, 247);
    cell.numberLabel.layer.masksToBounds = YES;
    cell.numberLabel.layer.cornerRadius = 2;
    
    cell.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    cell.countLabel.text = _dataArray[indexPath.row][@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dict = _dataArray[indexPath.row];
    
    YBCheatsViewController *vc = [[YBCheatsViewController alloc] init];
    vc.title = dict[@"title"];
    vc.weburl = dict[@"cheatsurl"];
    [self.navigationController pushViewController:vc animated:YES];
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
