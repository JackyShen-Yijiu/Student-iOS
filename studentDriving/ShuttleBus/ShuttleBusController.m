//
//  ShuttleBusController.m
//  studentDriving
//
//  Created by 大威 on 16/1/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "ShuttleBusController.h"
#import "ShuttleBusCell.h"
#import "ShuttleBusViewModel.h"

#define kShuttleBusCellID @"kShuttleBusCell"

@interface ShuttleBusController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ShuttleBusViewModel *viewModel;

@property (nonatomic, strong) ShuttleBusCell *dynamicHeightCell;

@end

@implementation ShuttleBusController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"班车";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
}

#pragma mark config view model
- (void)configViewModel {
    
    _viewModel = [ShuttleBusViewModel new];
    [_viewModel dvvSetRefreshSuccessBlock:^{
        
    }];
    [_viewModel dvvSetRefreshErrorBlock:^{
        
    }];
    [_viewModel dvvSetLoadMoreSuccessBlock:^{
        
    }];
    [_viewModel dvvSetLoadMoreErrorBlock:^{
        
    }];
    
    [_viewModel dvvNetworkRequestRefresh];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [ShuttleBusCell dynamicHeight:@"fjkdljflksdjflkkjfkldsjfkdsljflkfkldslkdjsfklsjflksdjflsdkjflksdjflksdjlfsj"];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShuttleBusCell *cell = [tableView dequeueReusableCellWithIdentifier:kShuttleBusCellID];
    
//    if (3 == indexPath.row) {
        cell.contentLabel.text = @"fjkdljflksdjflkkjfkldsjfkdsljflkfkldslkdjsfklsjflksdjflsdkjflksdjflksdjlfsj";
//    }
    
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.frame = self.view.bounds;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ShuttleBusCell class] forCellReuseIdentifier:kShuttleBusCellID];
    }
    return _tableView;
}
- (ShuttleBusCell *)dynamicHeightCell {
    if (!_dynamicHeightCell) {
        _dynamicHeightCell = [ShuttleBusCell new];
    }
    return _dynamicHeightCell;
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
