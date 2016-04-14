//
//  JZSideMenuOrderDiscountView.m
//  studentDriving
//
//  Created by ytzhang on 16/4/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZSideMenuOrderDiscountView.h"
#import "JZSideMenuOrderDiscountCell.h"
#import "JZSideMenuOrderListViewModel.h"


@interface JZSideMenuOrderDiscountView () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) JZSideMenuOrderListViewModel *viewModel;

@property (nonatomic, assign) CGRect rect;

@property (nonatomic, assign) BOOL networkSuccess;

@end


@implementation JZSideMenuOrderDiscountView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self configViewModel];
    }
    return self;
}


#pragma mark - config view model
- (void)configViewModel {
    
    __weak typeof(self) ws = self;
    _viewModel = [[JZSideMenuOrderListViewModel alloc] init];
    
    [_viewModel dvv_setRefreshSuccessBlock:^{
        _networkSuccess = YES;
        
        [ws reloadData];
    }];
    [_viewModel dvv_setNilResponseObjectBlock:^{
//        [ws.view addSubview:ws.noDataPromptView];
//        //        [ws obj_showTotasViewWithMes:@"暂无数据"];
    }];
    [_viewModel dvv_setNetworkCallBackBlock:^{
        
    }];
    [_viewModel dvv_setNetworkErrorBlock:^{
//        //        [ws obj_showTotasViewWithMes:@"网络错误"];
//        [ws.view addSubview:ws.noDataPromptView];
    }];
    
    [_viewModel dvv_networkRequestRefresh];
}

#pragma mark ---- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _viewModel.listDataArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *IDCell = @"IDCell";
    JZSideMenuOrderDiscountCell *cell = [tableView dequeueReusableCellWithIdentifier:IDCell];
    if (!cell) {
        cell = [[JZSideMenuOrderDiscountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDCell];
    }
    cell.listDataModel = _viewModel.listDataArray[indexPath.row];
    return cell;
}
@end
