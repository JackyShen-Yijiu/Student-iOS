//
//  DrivingSelectMotorcycleTypeView.m
//  studentDriving
//
//  Created by 大威 on 15/12/15.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "DrivingSelectMotorcycleTypeView.h"
#import "JENetwoking.h"
#import "ToolHeader.h"
#import "DrivingCarTypeDMRootClass.h"

@interface DrivingSelectMotorcycleTypeView()<JENetwokingDelegate>

@property (nonatomic, copy) DrivingSelectMotorcycleTypeViewSelectedItemBlock selectedItemBlock;

@end

@implementation DrivingSelectMotorcycleTypeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
        _dataList = [NSMutableArray array];
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)setSelectedItemBlock:(DrivingSelectMotorcycleTypeViewSelectedItemBlock)handle {
    _selectedItemBlock = handle;
}

#pragma mark - show method
- (void)show {
    [self network];
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    }];
}

#pragma mark - network
- (void)network {
    [JENetwoking initWithUrl:[NSString stringWithFormat:BASEURL, @"info/carmodel"] WithMethod:JENetworkingRequestMethodGet WithDelegate:self];
}

- (void)jeNetworkingCallBackData:(id)data {
    
    NSLog(@"%@",data);
    DrivingCarTypeDMRootClass *rootClass = [[DrivingCarTypeDMRootClass alloc] initWithDictionary:data];
    if (rootClass.type == 1) {
        [self.dataList removeAllObjects];
        for (DrivingCarTypeDMData *item in rootClass.data) {
            [self.dataList addObject:item];
        }
    }
    [self configLayout];
    [self.tableView reloadData];
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kCellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellId];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment = 1;
        cell.textLabel.textColor = [UIColor orangeColor];
        cell.backgroundColor = [UIColor clearColor];
    }
    DrivingCarTypeDMData *data = self.dataList[indexPath.row];
    NSString *code = @"";
    if (![data.code isEqualToString:@"O"]) {
        code = data.code;
    }
    NSString *title = [NSString stringWithFormat:@"%@%@",code,data.name];
    cell.textLabel.text = title;
    cell.tag = data.modelsid;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectedItemBlock) {
        DrivingCarTypeDMData *data = self.dataList[indexPath.row];
        NSString *code = @"";
        if (![data.code isEqualToString:@"O"]) {
            code = data.code;
        }
        NSString *title = [NSString stringWithFormat:@"%@%@",code,data.name];
        _selectedItemBlock(data.modelsid, title);
    }
    [self closeSelf];
}

- (void)closeSelf {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - configUI
- (void)configLayout {
    
    CGFloat width = self.bounds.size.width / 2.f;
    CGFloat height = self.bounds.size.height / 2.f;
    if (self.dataList.count * 44 < height) {
        height = self.dataList.count * 44;
    }
    self.tableView.frame = CGRectMake(0, 0, width, height);
    self.tableView.center = CGPointMake(width, self.bounds.size.height / 2.f);
}

#pragma mark - lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:1];
//        _tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        _tableView.layer.borderWidth = 1;
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
