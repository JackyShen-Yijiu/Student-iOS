//
//  YBSubjectQuestionsListController.m
//  studentDriving
//
//  Created by JiangangYang on 16/4/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBSubjectQuestionsListController.h"
#import "YBSubjectListCell.h"
#import "YBSubjectTool.h"
#import "YBSubjectData.h"
#import "YBSubjectQuestionsViewController.h"

@interface YBSubjectQuestionsListController()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation YBSubjectQuestionsListController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.frame = CGRectMake(0, 0, kSystemWide, self.view.height);
        _tableView.backgroundColor = YBMainViewControlerBackgroundColor;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 44;
    }
    return _tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [self.view addSubview:self.tableView];
    
    self.dataArray = [NSArray array];
    self.dataArray =  [YBSubjectTool getAllSubjectChapterWithType:_kemu];
    [self.tableView reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"YBSubjectListCell";
    
    YBSubjectListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YBSubjectListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.numberLabel.backgroundColor = YBNavigationBarBgColor;
    cell.numberLabel.layer.masksToBounds = YES;
    cell.numberLabel.layer.cornerRadius = 3;
    cell.contentLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
    cell.contentLabel.font = [UIFont boldSystemFontOfSize:13];
    
    cell.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    
    YBSubjectData *data = self.dataArray[indexPath.row];
    
    cell.contentLabel.text = [NSString stringWithFormat:@"%@(%ld)",data.title,(long)data.count];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    YBSubjectData *data = self.dataArray[indexPath.row];
    NSLog(@"data.mid:%ld",(long)data.mid);
    
    YBSubjectQuestionsViewController *vc = [[YBSubjectQuestionsViewController alloc] init];
    vc.chapter = data.mid;
    vc.kemu = _kemu;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
