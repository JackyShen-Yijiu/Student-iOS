//
//  YBAppointMentDetailsController.m
//  studentDriving
//
//  Created by 大威 on 16/2/20.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBAppointMentDetailsController.h"
#import "YBAppointMentDetailsDataModel.h"
#import "DrivingDetailTableHeaderView.h"
#import "DVVToast.h"
#import "DVVCoachDetailHeaderView.h"
#import "ShuttleBusController.h"
#import "HMCourseModel.h"
#import "DrivingDetailViewModel.h"
#import "YBAppointMentDetailsFootView.h"
#import "YBAppointMentDetailsCancleView.h"
#import "YBCancleAppointMentController.h"
#import "ChatViewController.h"

static NSString *infoCellID = @"kInfoCellID";
static NSString *introductionCellID = @"kIntroductionCellID";
static NSString *tagCellID = @"kTagCellID";
static NSString *courseCellID = @"kCourseCellID";

@interface YBAppointMentDetailsController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) YBAppointMentDetailsDataModel *viewModel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *shuttleBusButton;

@property (nonatomic, assign) BOOL isShowIntroduction;

@property (nonatomic,strong) YBAppointMentDetailsFootView *footView;
@property (nonatomic,strong) YBAppointMentDetailsCancleView *cancleFootView;

@property (nonatomic, assign) BOOL networkSuccess;

@property (nonatomic,strong) UIView *commentFooter;

@end

@implementation YBAppointMentDetailsController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = NO;
    self.view.backgroundColor = YBMainViewControlerBackgroundColor;
    self.title = @"预约详情";
    
    [self.view addSubview:self.tableView];
    
    [self configViewModel];

    NSLog(@"self.courseModel.courseStatue:%ld",(long)self.courseModel.courseStatue);
    
    if (self.courseModel.courseStatue == KCourseStatueapplyconfirm || self.courseModel.courseStatue == KCourseStatueapplying) {// 预约中,取消预约
        [self.view addSubview:self.footView];
    }else if (self.courseModel.courseStatue == KCourseStatueapplyrefuse){// 教练拒绝或者取消->教练取消
        [self.view addSubview:self.cancleFootView];
    }
    
}

#pragma mark 聊天
- (void)shuttleBusButtonAction {
    
    ChatViewController *chatController = [[ChatViewController alloc] initWithChatter:_courseModel.userModel.coachid
                                                                    conversationType:eConversationTypeChat];
    chatController.title = _courseModel.userModel.name;
    [self.navigationController pushViewController:chatController animated:YES];
}

#pragma mark - config view model
- (void)configViewModel {
    
    __weak typeof(self) ws = self;
    _viewModel = [YBAppointMentDetailsDataModel new];
    _viewModel.appointMentID = _appointMentID;
    
    [_viewModel dvv_setRefreshSuccessBlock:^{
        _networkSuccess = YES;
        [ws.tableView reloadData];
    }];
    [_viewModel dvv_setNilResponseObjectBlock:^{
        [ws obj_showTotasViewWithMes:@"暂无数据"];
    }];
    [_viewModel dvv_setNetworkCallBackBlock:^{
        [DVVToast hide];
    }];
    [_viewModel dvv_setNetworkErrorBlock:^{
        [ws obj_showTotasViewWithMes:@"网络错误"];
    }];
    [_viewModel dvv_networkRequestRefresh];
}

#pragma mark - tableView delegate datasourse

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_viewModel.dmData) {
        return 1;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:13];
    cell.accessoryView = nil;
    
    if (indexPath.row==0) {// 科目二 第多少课时
        cell.imageView.image = [UIImage imageNamed:@"YBAppointMentDetailsinformation"];
        cell.textLabel.text = _viewModel.dmData.courseprocessdesc;
    }else if (indexPath.row==1){//
        cell.imageView.image = [UIImage imageNamed:@"YBAppointMentDetailstime"];
        cell.textLabel.text = _viewModel.dmData.classdatetimedesc;//_viewModel.dmData.learningcontent;
    }else if (indexPath.row==2){// 签到时间
        cell.imageView.image = [UIImage imageNamed:@"YBAppointMentDetailstime"];
        cell.textLabel.text = _viewModel.dmData.sigintime;
    }else if (indexPath.row==3){// 学习内容
        cell.imageView.image = [UIImage imageNamed:@"YBAppointMentDetailsmodel"];
        cell.textLabel.text = _viewModel.dmData.learningcontent;
    }else if (indexPath.row==4){// 教练
        cell.imageView.image = [UIImage imageNamed:@"YBAppointMentDetailscoach"];
        cell.textLabel.text = _viewModel.dmData.coachid.name;
        
        _shuttleBusButton = [UIButton new];
        [_shuttleBusButton setImage:[UIImage imageNamed:@"YBAppointMentDetailstalk"] forState:UIControlStateNormal];
        _shuttleBusButton.bounds = CGRectMake(0, cell.contentView.width-24-20, 24, 44);
        [_shuttleBusButton addTarget:self action:@selector(shuttleBusButtonAction) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = _shuttleBusButton;
        
    }else if (indexPath.row==5){// 训练场地
        cell.imageView.image = [UIImage imageNamed:@"YBAppointMentDetailslocation"];
        cell.textLabel.text = _viewModel.dmData.coachid.driveschoolinfo.name;
    }
    
    return cell;
    
}

- (UIView *)commentFooter
{
    if (_commentFooter==nil) {
        
        _commentFooter = [[UIView alloc] init];
        
    }
    return _commentFooter;
}

#pragma mark - lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UITableView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
    }
    return _tableView;
}

- (YBAppointMentDetailsFootView *)footView
{
    
    WS(ws);
    if (_footView == nil) {
        
        _footView = [[YBAppointMentDetailsFootView alloc] initWithFrame:CGRectMake(0, self.view.height-50-64, self.view.width, 50)];
        _footView.courseModel = _courseModel;
        _footView.didClick = ^{
            NSLog(@"取消预约");
            YBCancleAppointMentController *vc = [[YBCancleAppointMentController alloc] init];
            vc.courseModel = ws.courseModel;
            [ws.navigationController pushViewController:vc animated:YES];
        };
    }
    return _footView;
}

- (YBAppointMentDetailsCancleView *)cancleFootView
{
    if (_cancleFootView == nil) {
        
        _cancleFootView = [[YBAppointMentDetailsCancleView alloc] initWithFrame:CGRectMake(0, self.view.height-80-64, self.view.width, 80)];
        _cancleFootView.courseModel = _courseModel;
    }
    return _cancleFootView;
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
