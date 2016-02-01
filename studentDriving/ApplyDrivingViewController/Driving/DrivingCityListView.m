//
//  DrivingCityListView.m
//  studentDriving
//
//  Created by 大威 on 15/12/17.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "DrivingCityListView.h"
#import "JENetwoking.h"
#import "ToolHeader.h"
#import "DrivingCityListDMRootClass.h"
#import "CityListCell.h"

#define ROW_HEIGHT 30

@interface DrivingCityListView()<JENetwokingDelegate>

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
    
    CGFloat width = 73;
    CGFloat height = self.bounds.size.height;
    if (self.dataList.count * ROW_HEIGHT < height) {
        height = self.dataList.count * ROW_HEIGHT;
    }

//    _tableView.frame = CGRectMake(0, 0, self.bounds.size.width, height);
    _tableView.frame = CGRectMake(self.bounds.size.width - width, 0, width, height);
    CGRect rect = self.tableView.frame;
    CGRect tempRect = rect;
    tempRect.size.height = 0;
    _tableView.tableHeaderView = nil;
    self.tableView.frame = tempRect;
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.frame = rect;
    }];
}

#pragma mark - network
- (void)network {
    [JENetwoking initWithUrl:[NSString stringWithFormat:BASEURL, @"getopencity"] WithMethod:JENetworkingRequestMethodGet WithDelegate:self];
}

- (void)jeNetworkingCallBackData:(id)data {
    
    NSLog(@"%@",data);
    DrivingCityListDMRootClass *rootClass = [[DrivingCityListDMRootClass alloc] initWithDictionary:data];
    if (rootClass.type == 1) {
        [self.dataList removeAllObjects];
        for (DrivingCityListDMData *item in rootClass.data) {
            [self.dataList addObject:item];
        }
    }
    [self.tableView reloadData];
    [self configLayout];
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
    DrivingCityListDMData *data = self.dataList[indexPath.row];
    cell.nameLabel.text = data.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectedItemBlock) {
        DrivingCityListDMData *data = self.dataList[indexPath.row];
        _selectedItemBlock(data.name);
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
        _tableView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
//        _tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        _tableView.layer.borderWidth = 1;
        _tableView.frame = CGRectMake(self.bounds.size.width - 73, 0, 73, ROW_HEIGHT);
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [activityView startAnimating];
        activityView.frame = CGRectMake(0, 0, 73, ROW_HEIGHT);
        _tableView.tableHeaderView = activityView;
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
