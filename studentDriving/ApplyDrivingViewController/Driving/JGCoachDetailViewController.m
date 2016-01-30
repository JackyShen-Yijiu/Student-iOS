//
//  DetailViewController.m
//  BlackCat
//
//  Created by 董博 on 15/9/17.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "JGCoachDetailViewController.h"
#import "SignUpViewController.h"
#import "DrivingDetailViewController.h"
#import "CoachIntroductionCell.h"
#import "StudentCommentCell.h"
#import "JsonTransformManager.h"
#import "CoachDetail.h"
#import "BLPFAlertView.h"
#import "SignUpInfoManager.h"
#import "StudentCommentModel.h"
#import "LoginViewController.h"
#import "SignUpListViewController.h"
#import "DVVUserManager.h"
#import "MJRefresh.h"
#import "SearchCoachViewModel.h"
#import "YYModel.h"
#import "serverclasslistModel.h"

#import "JGDrivingDetailTopCell.h"
#import "JGDrivingDetailTeachingNewsCell.h"
#import "JGDrivingDetailPersonalNoteCell.h"
#import "JGDrivingDetailEvalutionCell.h"

static NSString *const kCoachDetailInfo = @"userinfo/getuserinfo/2/userid/%@";

static NSString *const kGetCommentInfo = @"courseinfo/getusercomment/2/%@/%@";

@interface JGCoachDetailViewController ()<UITableViewDataSource,UITableViewDelegate,JGDrivingDetailPersonalNoteCellDelegate>

@property (strong, nonatomic)UIButton *phoneBtn;
@property (strong, nonatomic) UITableView *tableView;

//@property (strong, nonatomic)UIButton *signUpButton;
@property (nonatomic, strong) UIImageView *heartImageView;

/*
 * 教练详情信息
 */
@property (strong, nonatomic) CoachDetail *detailModel;
/*
 * 教练详情底部评论列表
 */
@property (strong, nonatomic) NSMutableArray *commentArray;

@end

@implementation JGCoachDetailViewController

- (NSMutableArray *)commentArray
{
    if (_commentArray == nil) {
        
        _commentArray = [NSMutableArray array];
        
    }
    return _commentArray;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, kSystemWide, kSystemHeight-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIButton *)phoneBtn{
    if (_phoneBtn == nil) {
        _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _phoneBtn.frame = CGRectMake(0, 0, 50, 20);
        [_phoneBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_phoneBtn setTitle:@"确认" forState:UIControlStateHighlighted];
        [_phoneBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        [_phoneBtn setTitleColor:MAINCOLOR forState:UIControlStateHighlighted];
        _phoneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [_phoneBtn addTarget:self action:@selector(clickPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.coachUserId = @"5666365ef14c20d07ffa6ae8";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:@"kLoginSuccess" object:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"教练详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self configBarItem];
    
    [self createUI];
    
    // 获取用户信息数据
    [self startDownLoad];
    
    // 下载教练
    [self startDownLoadComment];
    
}
- (void)loginSuccess {
    
    DYNSLog(@"login");
    [self startDownLoad];

}

#pragma mark ----- 加载评论列表
- (void)startDownLoadComment {
    
    __block NSString *urlString = [NSString stringWithFormat:kGetCommentInfo,self.coachUserId,[NSNumber numberWithInt:1]];
    
    __block NSString *urlComment = [NSString stringWithFormat:BASEURL,urlString];
    
    [JENetwoking startDownLoadWithUrl:urlComment postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSDictionary *param = data;
        NSError *error = nil;
        NSNumber *type = param[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@",param[@"msg"]];
        
        if (type.integerValue == 1) {
            
            //            self.commentArray = [[MTLJSONAdapter modelsOfClass:StudentCommentModel.class fromJSONArray:param[@"data"] error:&error] mutableCopy];
            
            NSArray *array = data[@"data"];
            
            for (NSDictionary *dict in array) {
                
                StudentCommentModel *dmData = [StudentCommentModel yy_modelWithDictionary:dict];
                
                [self.commentArray addObject:dmData];
                
            }
            
            [self.tableView reloadData];
            
        }else {
            
            kShowFail(msg);
            
        }
        
    }];
    
    __weak typeof(self) ws = self;
    
    // 加载
    MJRefreshBackNormalFooter *refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        // 判断加载时当前的请求的页面
        NSInteger dataCount = 0;
        if (self.commentArray.count) {
            if (self.commentArray.count <= 10) {
                dataCount = 10;
            }else {
                NSInteger temp = self.commentArray.count % 10;
                if (temp) {
                    temp += 10 - temp;
                }
                dataCount = self.commentArray.count + temp;
            }
        }
        NSInteger index = dataCount / 10 + 1;
        NSLog(@"index:%ld",(long)index);
        
        urlString = [NSString stringWithFormat:kGetCommentInfo,ws.coachUserId,[NSNumber numberWithInt:(int)index]];
        urlComment = [NSString stringWithFormat:BASEURL,urlString];
        
        [JENetwoking startDownLoadWithUrl:urlComment postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
            
            NSDictionary *param = data;
            NSError *error = nil;
            NSNumber *type = param[@"type"];
            
            NSString *msg = [NSString stringWithFormat:@"%@",param[@"msg"]];
            
            if (type.integerValue == 1) {
                
                NSArray *array = data[@"data"];
                
                //                NSArray *dataArray = [MTLJSONAdapter modelsOfClass:StudentCommentModel.class fromJSONArray:param[@"data"] error:&error];
                
                if (array && array.count!=0) {
                    
                    NSMutableArray *tempArray = [NSMutableArray array];
                    
                    for (NSDictionary *dict in array) {
                        
                        StudentCommentModel *dmData = [StudentCommentModel yy_modelWithDictionary:dict];
                        
                        [tempArray addObject:dmData];
                        
                    }
                    [ws.commentArray addObjectsFromArray:tempArray];
                    
                    [ws.tableView reloadData];
                    
                }else{
                    
                    [self showTotasViewWithMes:@"已经加载完成全部数据"];
                    
                }
                
            }else {
                
                kShowFail(msg);
                
            }
            
            [ws.tableView.mj_footer endRefreshing];
            
        }];
        
    }];
    
    self.tableView.mj_footer = refreshFooter;
    
}

- (void)startDownLoad {
    
    NSString *infoString = [NSString stringWithFormat:kCoachDetailInfo,self.coachUserId];
    NSString *urlString = [NSString stringWithFormat:BASEURL,infoString];
    DYNSLog(@"urlString = %@",urlString);
    
    __weak JGCoachDetailViewController *weakSelf = self;
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSDictionary *dataParam = data;
        NSNumber *messege = dataParam[@"type"];
        
        if (messege.intValue == 1) {
            
            NSError *error = nil;
            
            // CoachDetail *coachDetail = [MTLJSONAdapter modelOfClass:CoachDetail.class fromJSONDictionary:dataParam[@"data"] error:&error];
            
            CoachDetail *coachDetail = [CoachDetail yy_modelWithDictionary:dataParam[@"data"]];
            
            weakSelf.detailModel = coachDetail;
            
            [weakSelf.tableView reloadData];
            
        }else{
            [self showTotasViewWithMes:@"网络错误"];
            return;
        }
    }];
    
}

- (void)configBarItem {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.phoneBtn];
    self.navigationItem.rightBarButtonItems = @[rightItem];
}

#pragma mark - createUI
- (void)createUI {
    
    [self.view addSubview:self.tableView];
}

#pragma mark --- 4组数据
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
#pragma mark --- 每一组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) {// 个人信息、授课信息
        return 2;
    }else if (section==1){// 个人说明
        return 1;
    }else{// // 学员评价
        return self.commentArray.count;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section==2){// 学员评价
        return 30;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section==2) {
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 30)];
        headerView.backgroundColor = RGBColor(251, 251, 251);
        
        UILabel *titleLabe = [[UILabel alloc] init];
        titleLabe.textColor = MAINCOLOR;
        titleLabe.textAlignment = NSTextAlignmentLeft;
        titleLabe.backgroundColor = [UIColor clearColor];
        titleLabe.frame = CGRectMake(0, 7, headerView.frame.size.width, 15);
        titleLabe.text = @"   学员评价";
        titleLabe.font = [UIFont boldSystemFontOfSize:13];
        [headerView addSubview:titleLabe];
        
        return headerView;
        
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {// 个人信息、授课信息
        
        if (indexPath.row==0) {// 个人信息
            return 150;
        }else if (indexPath.row==1){// 授课信息
            // 减去顶部灰色view高度
            return [JGDrivingDetailTeachingNewsCell heightWithModel:self.detailModel]-10;
        }
        
    }else if (indexPath.section==1){// 个人说明
        
        // 更新高度
        return [JGDrivingDetailPersonalNoteCell heightWithModel:self.detailModel indexPath:indexPath];
        
    }
    // 学员评价
    StudentCommentModel *model = self.commentArray[indexPath.row];
    return [StudentCommentCell heightWithModel:model];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {// 个人信息、授课信息
        
        if (indexPath.row==0) {//个人信息
            
            static NSString *cellId = @"cellOne";
            JGDrivingDetailTopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[JGDrivingDetailTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            cell.detailModel = self.detailModel;
            
            return cell;
            
        }else if (indexPath.row==1){// 授课信息
            
            static NSString *cellId = @"cellTwo";
            
            JGDrivingDetailTeachingNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            
            if (!cell) {
                cell = [[JGDrivingDetailTeachingNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            cell.detailModel = self.detailModel;
            
            return cell;
            
        }
        
    }else if (indexPath.section==1){// 个人说明
        
        static NSString *cellId = @"cellThree";
        JGDrivingDetailPersonalNoteCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[JGDrivingDetailPersonalNoteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        cell.delegate = self;
        
        cell.detailModel = self.detailModel;
        
        return cell;
        
    }else if (indexPath.section==2){// 评论
        
        static NSString *cellId = @"cellFour";
        StudentCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[StudentCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        StudentCommentModel *model = self.commentArray[indexPath.row];
        [cell receiveCommentMessage:model];
        return cell;
    }
    
    return nil;
}

- (void)JGDrivingDetailPersonalNoteCellWithMoreBtnDidClick:(JGDrivingDetailPersonalNoteCell *)cell
{
    self.detailModel.isMore = !self.detailModel.isMore;
    
    [self.tableView reloadData];
}

@end