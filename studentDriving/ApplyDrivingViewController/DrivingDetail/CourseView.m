//
//  CourseView.m
//  studentDriving
//
//  Created by 大威 on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "CourseView.h"
#import "CourseViewModel.h"
#import "CourseCell.h"

#define kCellIdentifier @"kCellIdentifier"

@interface CourseView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) CourseViewModel *viewModel;

@end

@implementation CourseView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[CourseCell class] forCellReuseIdentifier:kCellIdentifier];
        
        [self configViewModel];
    }
    return self;
}

#pragma mark - config view model
- (void)configViewModel {
    
    _viewModel = [CourseViewModel new];
    
    [_viewModel dvvSetRefreshSuccessBlock:^{
        
    }];
    [_viewModel dvvSetRefreshErrorBlock:^{
        
    }];
    [_viewModel dvvSetNetworkErrorBlock:^{
        
    }];
    
    [_viewModel dvvNetworkRequestRefresh];
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_viewModel.heightArray[indexPath.row] floatValue];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CourseCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
