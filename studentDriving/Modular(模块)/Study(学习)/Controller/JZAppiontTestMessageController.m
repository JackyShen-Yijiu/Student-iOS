//
//  JZAppiontTestMessageController.m
//  studentDriving
//
//  Created by ytzhang on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZAppiontTestMessageController.h"
#import "JZAppiontMessageTopCell.h"
#import "JZAppiontMessageBottomCell.h"

@interface JZAppiontTestMessageController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *toptitleArray;

@property (nonatomic, strong) NSArray *topdesArray;

@property (nonatomic, strong) NSArray *bottomTitleArray;


@end

@implementation JZAppiontTestMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.title = @"驾校代约";
    self.view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    [self initData];
    
}
- (void)initData{
    self.toptitleArray = @[@"姓名",@"电话",@"考试原因"];
    
    self.bottomTitleArray = @[@"开始时间",@"至",@"结束时间"];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (0 == section) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 10)];
        view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
        return view;
    }
    if (1 == section) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 40)];
        view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 200, 40)];
        label.text = @"预约考试起止时间";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = JZ_FONTCOLOR_DRAK;
        [view addSubview:label];
        return view;
    }
    return nil;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (0 == section) {
        return 10;
    }
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (1 == indexPath.section && 1 == indexPath.row) {
        return 33;
    }
    return 44;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        static NSString *IDexchange = @"ecchangeID";
        JZAppiontMessageTopCell *cell = [tableView dequeueReusableCellWithIdentifier:IDexchange];
        if (!cell) {
            cell = [[JZAppiontMessageTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDexchange];
        }
        
        return cell;
        
    }
    if (1 == indexPath.section) {
            static NSString *IDnumber = @"numberID";
            JZAppiontMessageBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:IDnumber];
            if (!cell) {
                cell = [[JZAppiontMessageBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDnumber];
            }
            return cell;
    
     
    }
    
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark --- Lazy加载
- (UITableView *)tableView
{
    if (_tableView == nil ) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kSystemWide , kSystemHeight - 64 ) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

@end
