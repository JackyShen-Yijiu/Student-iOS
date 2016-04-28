//
//  YBCompletedAppointmentListController.m
//  studentDriving
//
//  Created by 大威 on 16/3/10.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBCompletedAppointmentListController.h"
#import "DVVToast.h"
#import "YBCompletedAppointmentDetailController.h"
#import "YBAppointMentDetailsController.h"

#import "JZCompletedAppointmentListCell.h"

static NSString *kCellIdentifier = @"kCellIdentifier";

@interface YBCompletedAppointmentListController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YBCompletedAppointmentListController


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"已完成预约";
    self.edgesForExtendedLayout = NO;
    self.view.backgroundColor = YBMainViewControlerBackgroundColor;
    
    if (!_dataArray.count) {
        [DVVToast showMessage:@"暂无已完成预约"];
    }else {
        [self.view addSubview:self.tableView];
    }
}


#pragma mark - tableView delegate and data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (YBIphone6Plus) {
        return  90 * YB_Height_Ratio;
    }
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JZCompletedAppointmentListCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    [cell refreshData:_dataArray[indexPath.row]];
    if (indexPath.row == _dataArray.count - 1) {
        cell.lineView.hidden = YES;
    }else {
        cell.lineView.hidden = NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HMCourseModel *model = _dataArray[indexPath.row];
    
    if ([[model getStatueString] isEqualToString:@"已漏课"]) {
        YBAppointMentDetailsController *vc = [[YBAppointMentDetailsController alloc] init];
        vc.courseModel = model;
        vc.appointMentID = model.courseId;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    YBCompletedAppointmentDetailController *vc = [YBCompletedAppointmentDetailController new];
    vc.courseModel = model;
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - lazy load

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.frame = CGRectMake(0, 0, kSystemWide, [UIScreen mainScreen].bounds.size.height - 64);
        _tableView.backgroundColor = YBMainViewControlerBackgroundColor;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[JZCompletedAppointmentListCell class] forCellReuseIdentifier:kCellIdentifier];
    }
    return _tableView;
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
