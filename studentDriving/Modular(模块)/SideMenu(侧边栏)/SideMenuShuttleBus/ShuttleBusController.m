//
//  ShuttleBusController.m
//  studentDriving
//
//  Created by 大威 on 16/1/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "ShuttleBusController.h"
#import "ShuttleBusCell.h"
#import "DrivingDetailDMSchoolbusroute.h"
#import "YYModel.h"
#import "DrivingDetailViewModel.h"
#import "DVVToast.h"
#import "DVVNoDataPromptView.h"

#define kShuttleBusCellID @"kShuttleBusCell"

@interface ShuttleBusController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ShuttleBusCell *dynamicHeightCell;

@property (nonatomic, strong) NSMutableArray *heightArray;

@property (nonatomic, strong) DrivingDetailViewModel *viewModel;

@property (nonatomic,strong) DVVNoDataPromptView *DvvView;

@end

@implementation ShuttleBusController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"班车接送";
    self.view.backgroundColor = YBMainViewControlerBackgroundColor;
    
    [self.view addSubview:self.tableView];
    if (!_dataArray) {
        [self configViewModel];
    }
    
    self.DvvView = [[DVVNoDataPromptView alloc] initWithTitle:@"暂时没有班车接送信息" image:[UIImage imageNamed:@"YBNocountentimage_bus"] subTitle:nil];
    [self.tableView addSubview:self.DvvView];
    
}

#pragma mark - config view model
- (void)configViewModel {
    
    _viewModel = [DrivingDetailViewModel new];
    _viewModel.schoolID = [AcountManager manager].applyschool.infoId;
    __weak typeof(self) ws = self;
    [_viewModel dvvSetRefreshSuccessBlock:^{
        ws.dataArray = ws.viewModel.dmData.schoolbusroute;
    }];
    [_viewModel dvvSetNilResponseObjectBlock:^{
        [ws obj_showTotasViewWithMes:@"没有数据啦"];
    }];
    [_viewModel dvvSetRefreshErrorBlock:^{
        [ws obj_showTotasViewWithMes:@"数据加载失败"];
    }];
    [_viewModel dvvSetNetworkErrorBlock:^{
        [ws obj_showTotasViewWithMes:@"网络错误"];
    }];
    [_viewModel dvvSetNetworkCallBackBlock:^{
        [DVVToast hideFromView:ws.view];
    }];
    [DVVToast showFromView:self.view];
    [_viewModel dvvNetworkRequestRefresh];
}

- (void)setDataArray:(NSArray *)dataArray {
    NSMutableArray *array = [NSMutableArray array];
    _heightArray = [NSMutableArray array];
    for (NSDictionary *dict in dataArray) {
        
        DrivingDetailDMSchoolbusroute *dmBus = [DrivingDetailDMSchoolbusroute yy_modelWithDictionary:dict];
        
        CGFloat height = [ShuttleBusCell dynamicHeight:dmBus.routecontent];
        [_heightArray addObject:@(height)];
        [array addObject:dmBus];
    }
    _dataArray = array;
    if (!_dataArray.count) {
        [self obj_showTotasViewWithMes:@"暂无班车路线"];
    }
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.DvvView.hidden =_dataArray.count;
    return _dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [_heightArray[indexPath.row] floatValue];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShuttleBusCell *cell = [tableView dequeueReusableCellWithIdentifier:kShuttleBusCellID];
    
    [cell refreshData:_dataArray[indexPath.row]];
    
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
