//
//  AppointmentViewController.m
//  BlackCat
//
//  Created by bestseller on 15/9/18.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "AppointmentViewController.h"
#import "APWaitConfirmViewController.h"
#import "UIDevice+JEsystemVersion.h"
#import "UIView+CalculateUIView.h"
#import "AppointmentDetailViewController.h"
#import "MyReservationCell.h"
#import "APWaitEvaluationViewController.h"
#import "AppointmentDrivingViewController.h"
#import "MyAppointmentModel.h"
#import <MJRefresh.h>

//static NSString *const kappointmentUrl = @"courseinfo/getmyreservation?userid=%@&subjectid=%@";

// 强制评论
static NSString *const forceCommentURL = @"courseinfo/getmyuncommentreservation?userid=%@&subjectid=%@";

#define tableViewHeadH 80

@interface AppointmentViewController ()<UITableViewDataSource,UITableViewDelegate>
//废弃
@property (strong, nonatomic) UIButton *headViewTitleButton;
@property (strong, nonatomic) UILabel *headViewTitleLabel;

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *signUpButton;
@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) NSIndexPath *scrollIndexPath;


@property (strong, nonatomic) UILabel *yiyuexueshiLabel;
//@property (strong, nonatomic) UILabel *shijiliancheLabel;
@property (strong, nonatomic) UILabel *loukeLabel;
//@property (strong, nonatomic) UILabel *shengyuxueshiLabel;

@end

@implementation AppointmentViewController

- (UILabel *)headViewTitleLabel {
    if (_headViewTitleLabel == nil) {
        
        _headViewTitleLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
        
        if ([AcountManager manager].subjecttwo.progress == nil || [AcountManager manager].subjecttwo.progress.length == 0) {
            
            _headViewTitleLabel.text = @"您还没有学车记录";
            
        }else {
            
            if (self.markNum.integerValue == 2) {
                NSLog(@"[AcountManager manager].subjecttwo.progress:%@",[AcountManager manager].subjecttwo.progress);
                _headViewTitleLabel.text = [NSString stringWithFormat:@"当前学车进度:%@",[AcountManager manager].subjecttwo.progress];

            }else if (self.markNum.integerValue == 3) {
                NSLog(@"[AcountManager manager].subjectthree.progress:%@",[AcountManager manager].subjectthree.progress);
                _headViewTitleLabel.text =  [NSString stringWithFormat:@"当前学车进度:%@",[AcountManager manager].subjectthree.progress];

            }

        }
    }
    return _headViewTitleLabel;
}

// 已约学时
- (UILabel *)yiyuexueshiLabel {
    if (_yiyuexueshiLabel == nil) {
        _yiyuexueshiLabel = [WMUITool initWithTextColor:[UIColor lightGrayColor] withFont:[UIFont systemFontOfSize:12]];
       
        if (self.markNum.integerValue == 2) {
            
            if ([AcountManager manager].subjecttwo.reservation && [AcountManager manager].subjecttwo.finishcourse) {
                
                NSInteger yiyuexueshiCount = [[AcountManager manager].subjecttwo.reservation integerValue] + [[AcountManager manager].subjecttwo.finishcourse integerValue];

                NSLog(@"yiyuexueshiCount:%lu",yiyuexueshiCount);
                
                _yiyuexueshiLabel.text = [NSString stringWithFormat:@"已约学时:%ld课时",(long)yiyuexueshiCount];
            }
            
        }else if (self.markNum.integerValue == 3) {
            

            if ([AcountManager manager].subjectthree.reservation && [AcountManager manager].subjectthree.finishcourse) {
                
                NSInteger yiyuexueshiCount = [[AcountManager manager].subjectthree.reservation integerValue] + [[AcountManager manager].subjectthree.finishcourse integerValue];
                NSLog(@"yiyuexueshiCount:%lu",yiyuexueshiCount);
                
                _yiyuexueshiLabel.text = [NSString stringWithFormat:@"已约学时:%ld课时",(long)yiyuexueshiCount];
                
            }
            
        }
        
    }
    return _yiyuexueshiLabel;
}

// 漏课
- (UILabel *)loukeLabel {
    if (_loukeLabel == nil) {
        _loukeLabel = [WMUITool initWithTextColor:[UIColor lightGrayColor] withFont:[UIFont systemFontOfSize:12]];
        
        if (self.markNum.integerValue == 2) {
            
            if ([AcountManager manager].subjecttwo.missingcourse) {
              
                NSInteger loukeCount = [[AcountManager manager].subjecttwo.missingcourse integerValue];;
                NSLog(@"loukeCount:%ld",(long)loukeCount);
                
                _loukeLabel.text = [NSString stringWithFormat:@"漏课:%ld课时",(long)loukeCount];
                
            }
            
        }else if (self.markNum.integerValue == 3) {
            
            if ([AcountManager manager].subjectthree.missingcourse) {
                
                NSInteger loukeCount = [[AcountManager manager].subjectthree.missingcourse integerValue];
                NSLog(@"loukeCount:%ld",(long)loukeCount);
                
                _loukeLabel.text = [NSString stringWithFormat:@"漏课:%ld课时",(long)loukeCount];
                
            }
        }
        
    }
    return _loukeLabel;
}

- (UIButton *)headViewTitleButton {
    if (_headViewTitleButton == nil) {
        _headViewTitleButton = [WMUITool initWithTitle:[NSString stringWithFormat:@"%@",self.markNum] withTitleColor:[UIColor whiteColor] withTitleFont:[UIFont systemFontOfSize:12]];
        _headViewTitleButton.backgroundColor = MAINCOLOR;
        _headViewTitleButton.userInteractionEnabled = NO;
        _headViewTitleButton.frame = CGRectMake(15, 14, 16, 16);
        _headViewTitleButton.layer.cornerRadius = _headViewTitleButton.calculateFrameWithWide*0.5;
    }
    return _headViewTitleButton;
}


- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (UIButton *)signUpButton{
    if (_signUpButton == nil) {
        _signUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _signUpButton.backgroundColor = MAINCOLOR;
        _signUpButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_signUpButton addTarget:self action:@selector(dealSignUp:) forControlEvents:UIControlEventTouchUpInside];
        [_signUpButton setTitle:@"预约学车" forState:UIControlStateNormal];
        [_signUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    return _signUpButton;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+tableViewHeadH, kSystemWide, kSystemHeight-64-49-tableViewHeadH) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    if ([UIDevice jeSystemVersion] >= 7.0f) {
//        //当你的容器是navigation controller时，默认的布局将从navigation bar的顶部开始。这就是为什么所有的UI元素都往上漂移了44pt
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//    }
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:[self tableViewHead]];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector()];
    
    [self.view addSubview:self.signUpButton];

    [self.signUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
        make.height.mas_equalTo(@49);
    }];
    
}
- (void)startDownLoad {
    
    NSString *appointmentUrl = [NSString stringWithFormat:kappointmentUrl,[AcountManager manager].userid,self.markNum];
    if (self.isForceComment) {
        appointmentUrl = [NSString stringWithFormat:forceCommentURL,[AcountManager manager].userid,self.markNum];
    }
    
//    NSLog("%",[self.markNum integerValue]);
    NSString *downLoadUrl = [NSString stringWithFormat:BASEURL,appointmentUrl];
    DYNSLog(@"url = %@ %@",[AcountManager manager].userid,[AcountManager manager].userToken);

    __weak typeof (self) ws = self;
    [JENetwoking startDownLoadWithUrl:downLoadUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSDictionary *param = data;
        NSNumber *type = param[@"type"];
        NSArray *array = param[@"data"];
        NSError *error = nil;
        
        [ws.dataArray removeAllObjects];
        
        NSString *msg = [NSString stringWithFormat:@"%@", param[@"msg"]];
        if (type.integerValue == 1) {
            [ws.dataArray addObjectsFromArray:[MTLJSONAdapter modelsOfClass:MyAppointmentModel.class fromJSONArray:array error:&error]];
            
            [ws.tableView reloadData];
            [ws.tableView.mj_header endRefreshing];
            
        }else {
            kShowFail(msg);
        }
    }];

}

- (void)dealSignUp:(UIButton *)sender{
    AppointmentDrivingViewController *appDriving = [[AppointmentDrivingViewController alloc] init];
    [self.navigationController pushViewController:appDriving animated:YES];
}

#pragma mark - 废弃
- (UIView *)tableViewHead {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64,kSystemWide,tableViewHeadH)];
    view.backgroundColor = [UIColor whiteColor];
    
    
    UIView *delive = [[UIView alloc] initWithFrame:CGRectMake(0, tableViewHeadH-0.5, kSystemWide, 0.5)];
    delive.backgroundColor = [UIColor lightGrayColor];
    delive.alpha = 0.3;
    [view addSubview:delive];
    
    [view addSubview:self.headViewTitleButton];   //黄色的小圆圈
    
    [view addSubview:self.headViewTitleLabel];// @"您还没有学车记录"
    
    [view addSubview:self.yiyuexueshiLabel];

    [view addSubview:self.loukeLabel];

    [self.headViewTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view.mas_top).offset(13);
        make.left.mas_equalTo(self.headViewTitleButton.mas_right).offset(5);
        make.right.mas_equalTo(view.mas_right).offset(-15);
    }];
    [self.yiyuexueshiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headViewTitleLabel.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.headViewTitleButton.mas_right).offset(5);
    }];
    
    [self.loukeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.yiyuexueshiLabel.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(self.headViewTitleButton.mas_right).offset(5);
    }];
   
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollWithIndex:)];
    [view addGestureRecognizer:tap];
    
    return view;
}

- (void)scrollWithIndex:(UITapGestureRecognizer *)tap {
    DYNSLog(@"tap");
    [self.tableView scrollToRowAtIndexPath:self.scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 81;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    MyReservationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[MyReservationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    MyAppointmentModel *model = self.dataArray[indexPath.row];
    if ([AcountManager manager].subjecttwo.progress)
    {
        NSLog(@"subjecttwo=%@",[AcountManager manager].subjecttwo.progress);
        NSLog(@"subjectthree = %@",[AcountManager manager].subjectthree.progress);
        NSLog(@"%lu",[self.markNum integerValue]);
        if (self.markNum.integerValue == 2)
        {
            if ([model.courseprocessdesc containsString:[AcountManager manager].subjecttwo.progress])
             {
                self.scrollIndexPath = indexPath;
            }
        }
//            else if (self.markNum.integerValue == 3) {
//            if ([model.courseprocessdesc containsString:[AcountManager manager].subjecttwo.progress]) {
//                self.scrollIndexPath = indexPath;
//            }
//        }
        
    } else if ([AcountManager manager].subjectthree.progress)
    {
        
        if (self.markNum.integerValue == 3) {
            if ([model.courseprocessdesc containsString:[AcountManager manager].subjectthree.progress]) {
                self.scrollIndexPath = indexPath;
            }
        }
    }
    
    
    
    [cell receiveDataModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyAppointmentModel *model = self.dataArray[indexPath.row];
    
    AppointmentState state = model.reservationstate.integerValue;
   
    if (state == AppointmentStateWait) {
        AppointmentDetailViewController *detail = [[AppointmentDetailViewController alloc] init];
        detail.model = model;
        detail.state = AppointmentStateWait;
        detail.isPushInformation = NO;
        DYNSLog(@"address = %@",model.shuttleaddress);
        detail.markNum =  self.markNum;
        [self.navigationController pushViewController:detail animated:YES];
    }else if (state == AppointmentStateSelfCancel) {
        AppointmentDetailViewController *detail = [[AppointmentDetailViewController alloc] init];
        detail.model = model;
        detail.isPushInformation = NO;
        detail.state = AppointmentStateSelfCancel;
        detail.markNum =  self.markNum;
        [self.navigationController pushViewController:detail animated:YES];
    }else if (state == AppointmentStateCoachConfirm) {         //已提交
        AppointmentDetailViewController *detail = [[AppointmentDetailViewController alloc] init];
        detail.model = model;
        detail.isPushInformation = NO;

        detail.state = AppointmentStateCoachConfirm;
        detail.markNum =  self.markNum;
        [self.navigationController pushViewController:detail animated:YES];
        
    }else if (state == AppointmentStateCoachCancel) {
        AppointmentDetailViewController *detail = [[AppointmentDetailViewController alloc] init];
        detail.model = model;
        detail.isPushInformation = NO;

        detail.state = AppointmentStateCoachCancel;
        detail.markNum =  self.markNum;
        [self.navigationController pushViewController:detail animated:YES];
        
    }else if (state == AppointmentStateConfirmEnd) {         //待确认
        APWaitConfirmViewController *wait = [[APWaitConfirmViewController alloc] init];
        wait.model = model;
        wait.markNum =  self.markNum;
        [self.navigationController pushViewController:wait animated:YES];
    }else if (state == AppointmentStateSignin) {         //已签到
        APWaitConfirmViewController *wait = [[APWaitConfirmViewController alloc] init];
        wait.model = model;
        wait.markNum =  self.markNum;
        [self.navigationController pushViewController:wait animated:YES];
    }else if (state == AppointmentStateNoSignIn) {         //已漏课
    }else if (state == AppointmentStateWaitComment) {
        APWaitEvaluationViewController *waitEvaluation = [[APWaitEvaluationViewController alloc] init];
        waitEvaluation.model = model;
        waitEvaluation.markNum =  self.markNum;
        [self.navigationController pushViewController:waitEvaluation animated:YES];
    }else if (state == AppointmentStateFinish) {              //已完成
        AppointmentDetailViewController *detail = [[AppointmentDetailViewController alloc] init];
        detail.model = model;
        detail.isPushInformation = NO;

        detail.state = AppointmentStateFinish;
        detail.markNum =  self.markNum;
        [self.navigationController pushViewController:detail animated:YES];
    }else if (state == AppointmentStateSystemCancel) {
        AppointmentDetailViewController *detail = [[AppointmentDetailViewController alloc] init];
        detail.model = model;
        detail.isPushInformation = NO;

        detail.state = AppointmentStateSystemCancel;
        detail.markNum =  self.markNum;
        [self.navigationController pushViewController:detail animated:YES];
    }
    

    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startDownLoad];

}
@end
