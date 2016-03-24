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

#import "DrivingDetailDMSchoolbusroute.h"
#import "YYModel.h"
#import "DrivingDetailViewModel.h"
#import "DVVToast.h"
#import "DVVNoDataPromptView.h"
#import "JZBusDetailStationModel.h"




@interface JZShuttleBusController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isSelectionHeaderCell;

@property (nonatomic, strong) NSMutableArray *heightArray;

@property (nonatomic, strong) DrivingDetailViewModel *viewModel;

@property (nonatomic,strong) DVVNoDataPromptView *DvvView;

@property (nonatomic, strong) NSMutableArray *detailBusArray; // 详细路线数组;
@end

@implementation JZShuttleBusController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"班车信息";
   

    self.view.backgroundColor = RGBColor(226, 226, 233);
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
     _detailBusArray = [NSMutableArray array];
    _heightArray = [NSMutableArray array];
    for (NSDictionary *dict in dataArray) {
        
        DrivingDetailDMSchoolbusroute *dmBus = [DrivingDetailDMSchoolbusroute yy_modelWithDictionary:dict];
        [array addObject:dmBus];
         _dataArray = array;
        
        // 加载详细路线数据
        NSArray *detailArray = [dict objectForKey:@"stationinfo"];
        for (NSDictionary *dic in detailArray) {
            JZBusDetailStationModel *stationModel = [JZBusDetailStationModel yy_modelWithDictionary:dic];
            [_detailBusArray addObject:stationModel];
        }
    }
   
    if (!_dataArray.count) {
        [self obj_showTotasViewWithMes:@"暂无班车路线"];
    }
    [self.tableView reloadData];
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
    if (!_isSelectionHeaderCell) {
        return 3;
    }
    else if(_isSelectionHeaderCell){
        return _detailBusArray.count + 1;
    }
    return 0;
   
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
     self.DvvView.hidden =_dataArray.count;
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.row) {
        return 42;
    }
    return 65;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.row) {
        JZShuttleBusMainCell *mainCell = [tableView dequeueReusableCellWithIdentifier:@"mainCell"];
        if (!mainCell) {
            mainCell = [[JZShuttleBusMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mainCell"];
        }
        mainCell.backgroundColor = [UIColor whiteColor];
        mainCell.selectionStyle = UITableViewCellSelectionStyleNone;
        mainCell.titleModel  = self.dataArray[indexPath.row];
        return mainCell;
    }
    else{
        JZShuttleBusDesCell *desCell = [tableView dequeueReusableCellWithIdentifier:@"desCell"];
        if (!desCell) {
            desCell = [[JZShuttleBusDesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"desCell"];
        }
        desCell.backgroundColor = [UIColor whiteColor];
        
        // 隐藏班车信息不展开时最后的线
        if (_isSelectionHeaderCell) {
            if (self.detailBusArray.count - 1 == indexPath.row) {
                desCell.bottomView.hidden = NO;
            }
            if (self.detailBusArray.count == indexPath.row) {
                desCell.bottomView.hidden = YES;
            }
        } else if (!_isSelectionHeaderCell){
            if (self.detailBusArray.count - 1 == indexPath.row) {
                desCell.bottomView.hidden = YES;
            }
        }
        
        // 设置展示详情时,图标为圆点
        if (_isSelectionHeaderCell) {
            if (!(1 == indexPath.row) && !(self.detailBusArray.count == indexPath.row)) {
                desCell.titleImageView.image = [UIImage imageNamed:@"node"];
                [desCell.titleImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(10, 10));
                }];
            }
        }
        if (!_isSelectionHeaderCell){
            if (2 == indexPath.row) {
                desCell.titleImageView.image = [UIImage imageNamed:@"bus_red"];
                [desCell.titleImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(12, 14));
                }];
            }
        }
        
        // cell赋值
        if (_isSelectionHeaderCell) {
            //  路线详情数据
            desCell.detailStationModel = self.detailBusArray[indexPath.row - 1];
            
        } else if (!_isSelectionHeaderCell){
            // 始发站和目的站数据
            if (1 == indexPath.row) {
                // 始发站
                desCell.detailStationModel = [self.detailBusArray firstObject];
            }else if (2 == indexPath.row){
                // 终点站
                desCell.detailStationModel = [self.detailBusArray lastObject];
                
            }
        }
         desCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return desCell;

    }
    
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        if (_isSelectionHeaderCell) {
            // 不显示路线详细信息
            JZShuttleBusMainCell *mainCell = [tableView cellForRowAtIndexPath:indexPath];
            [UIView animateWithDuration:0.5 animations:^{
                mainCell.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI * 2);
            } completion:^(BOOL finished) {
                
            }];
            _isSelectionHeaderCell = NO;
            [self.tableView reloadData];
        }else if (!_isSelectionHeaderCell){
            // 显示路线详细信息
            JZShuttleBusMainCell *mainCell = [tableView cellForRowAtIndexPath:indexPath];
            [UIView animateWithDuration:0.5 animations:^{
                mainCell.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
            } completion:^(BOOL finished) {
                
            }];
            _isSelectionHeaderCell = YES;
            [self.tableView reloadData];

        }
        

    }
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
