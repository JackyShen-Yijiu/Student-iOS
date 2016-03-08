//
//  DrivingCityListView.m
//  studentDriving
//
//  Created by 大威 on 15/12/17.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "DrivingCityListView.h"
#import "JENetwoking.h"
#import "DrivingCityListDMRootClass.h"
#import "CityListCell.h"

#define ROW_HEIGHT 40

@interface DrivingCityListView()<JENetwokingDelegate>

@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@property (nonatomic, copy) DrivingCityListViewSelectedItemBlock selectedItemBlock;
@property (nonatomic, copy) dispatch_block_t removedBlock;

@end

@implementation DrivingCityListView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _dataList = [NSMutableArray array];
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)setSelectedItemBlock:(DrivingCityListViewSelectedItemBlock)handle {
    _selectedItemBlock = handle;
}
- (void)setRemovedBlock:(dispatch_block_t)handle {
    _removedBlock = handle;
}

#pragma mark - show method
- (void)show {
    
    [self network];
    
}

- (void)configLayout {
    
//    CGFloat width = 73;
    CGFloat height = self.bounds.size.height - 64;
    if (self.dataList.count * ROW_HEIGHT < height) {
        height = self.dataList.count * ROW_HEIGHT;
    }

    _tableView.frame = CGRectMake(0, 0, self.bounds.size.width, height);
//    _tableView.frame = CGRectMake(self.bounds.size.width - width, 0, width, height);
    CGRect rect = self.tableView.frame;
    CGRect tempRect = rect;
    tempRect.size.height = 0;
//    [UIView animateWithDuration:0.2 animations:^{
//        _activityView.alpha = 0;
//    } completion:^(BOOL finished) {
//        [_activityView removeFromSuperview];
//    }];
    [_activityView removeFromSuperview];
    self.tableView.frame = tempRect;
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.frame = rect;
    }];
}

#pragma mark - network
- (void)network {
    
    [JENetwoking startDownLoadWithUrl:[NSString stringWithFormat:BASEURL, @"getopencity"] postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"%@",data);
        DrivingCityListDMRootClass *rootClass = [[DrivingCityListDMRootClass alloc] initWithDictionary:data];
        if (rootClass.type == 1) {
            
            [self.dataList removeAllObjects];
            
            DrivingCityListDMData *dmData = [DrivingCityListDMData new];
            dmData.name = @"当前城市";
            [self.dataList addObject:dmData];
            
            for (DrivingCityListDMData *item in rootClass.data) {
                [self.dataList addObject:item];
            }
        }
        //    for (int i = 0; i < 3; i++) {
        //        DrivingCityListDMData *dmData = [DrivingCityListDMData new];
        //        dmData.name = @"测试";
        //        dmData.idField = 123456;
        //        [self.dataList addObject:dmData];
        //    }
        [self.tableView reloadData];
        [self configLayout];
        
    } withFailure:^(id data) {
        [self obj_showTotasViewWithMes:@"网络错误"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self closeSelf];
        });
    }];
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kCellId = @"cellId";
    CityListCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    if (!cell) {
        cell = [[CityListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellId];
    }
    cell.tag = indexPath.row;
    DrivingCityListDMData *data = self.dataList[indexPath.row];
    cell.nameLabel.text = data.name;
    
    if (self.dataList.count - 1 == indexPath.row) {
        cell.bottomLineImageView.hidden = YES;
    }else {
        cell.bottomLineImageView.hidden = NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectedItemBlock) {
        DrivingCityListDMData *data = self.dataList[indexPath.row];
        _selectedItemBlock(data.name, indexPath);
    }
    [self closeSelf];
}

- (void)closeSelf {
    
    CGRect rect = self.tableView.frame;
    rect.size.height = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.frame = rect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (_removedBlock) {
            _removedBlock();
        }
    }];
}

#pragma mark - lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = ROW_HEIGHT;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"393f4b" alpha:0.85];
//        _tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        _tableView.layer.borderWidth = 1;
        
        _tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0);
//
//        [UIView animateWithDuration:0.3 animations:^{
//            _tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, ROW_HEIGHT);
//        }];
//        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//        [_activityView startAnimating];
//        _activityView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, ROW_HEIGHT);
//        _activityView.alpha = 0;
//        [_tableView addSubview:_activityView];
//        [UIView animateWithDuration:0.2 animations:^{
//            _activityView.alpha = 1;
//        }];
    }
    return _tableView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self closeSelf];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
