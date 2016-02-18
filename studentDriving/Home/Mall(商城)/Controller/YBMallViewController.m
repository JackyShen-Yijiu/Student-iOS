//
//  YBMallViewController.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBMallViewController.h"
#import "YBIntegralMallCell.h"

@interface YBMallViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tabelView;
@end

@implementation YBMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商城";
    self.tabelView.delegate = self;
    self.tabelView.dataSource  = self;
    [self.view addSubview:self.tabelView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 165;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID =@"MallCellID";
    YBIntegralMallCell *mallCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!mallCell) {
        mallCell = [[YBIntegralMallCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        mallCell.backgroundColor = [UIColor clearColor];
    }
    return mallCell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (UITableView *)tabelView{
    if (_tabelView == nil) {
        _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 65) style:UITableViewStylePlain];
        _tabelView.backgroundColor = [UIColor clearColor];
        _tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tabelView;

}
@end
