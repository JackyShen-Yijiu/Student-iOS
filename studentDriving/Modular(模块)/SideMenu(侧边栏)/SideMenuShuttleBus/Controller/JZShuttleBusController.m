//
//  JZShuttleBusController.m
//  studentDriving
//
//  Created by ytzhang on 16/3/18.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZShuttleBusController.h"
#import "JZShuttleBusMainCell.h"
#import "JZShuttleBusDesCell.h"

@interface JZShuttleBusController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation JZShuttleBusController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(226, 226, 233);
    [self.view addSubview:self.tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (1 == section) {
        return 10;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   return  3;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.row) {
        return 34;
    }
    return 37;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.row) {
        JZShuttleBusMainCell *mainCell = [tableView dequeueReusableCellWithIdentifier:@"mainCell"];
        if (!mainCell) {
            mainCell = [[JZShuttleBusMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mainCell"];
        }
        mainCell.backgroundColor = [UIColor whiteColor];
        return mainCell;
    }
    if (1 == indexPath.row || 2 == indexPath.row) {
        JZShuttleBusDesCell *desCell = [tableView dequeueReusableCellWithIdentifier:@"desCell"];
        if (!desCell) {
            desCell = [[JZShuttleBusDesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"desCell"];
        }
        desCell.backgroundColor = [UIColor whiteColor];
        return desCell;
    }
    
    
    
    
    
    return nil;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.frame = self.view.bounds;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
//        [_tableView registerClass:[ShuttleBusCell class] forCellReuseIdentifier:kShuttleBusCellID];
    }
    return _tableView;
}


@end
