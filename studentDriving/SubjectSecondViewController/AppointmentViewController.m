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

static NSString *const kappointmentUrl = @"courseinfo/getmyreservation?userid=%@&subjectid=%@";
@interface AppointmentViewController ()<UITableViewDataSource,UITableViewDelegate>
//废弃
@property (strong, nonatomic) UIButton *headViewTitleButton;
@property (strong, nonatomic) UILabel *headViewTitleLabel;
@property (strong, nonatomic) UIImageView *headViewImageView;
@property (strong, nonatomic) UILabel *headViewCoachName;
@property (strong, nonatomic) UILabel *headViewCoachAddress;

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *signUpButton;
@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) NSIndexPath *scrollIndexPath;
@end

@implementation AppointmentViewController



- (UILabel *)headViewCoachAddress {
    if (_headViewCoachAddress == nil) {
        _headViewCoachAddress = [WMUITool initWithTextColor:TEXTGRAYCOLOR withFont:[UIFont systemFontOfSize:14]];
        _headViewCoachAddress.text = @"北京市海淀区中关村驾校";
    }
    return _headViewCoachAddress;
}

- (UILabel *)headViewCoachName {
    if (_headViewCoachName == nil) {
        _headViewCoachName = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:16]];
        _headViewCoachName.text = @"李教练";
    }
    return _headViewCoachName;
}

- (UIImageView *)headViewImageView {
    if (_headViewImageView == nil) {
        _headViewImageView = [[UIImageView alloc] init];
        _headViewImageView.backgroundColor = MAINCOLOR;
    }
    return _headViewImageView;
}
- (UILabel *)headViewTitleLabel {
    if (_headViewTitleLabel == nil) {
        _headViewTitleLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
        if ([AcountManager manager].subjecttwo.progress == nil || [AcountManager manager].subjecttwo.progress.length == 0) {
            _headViewTitleLabel.text = @"您还没有学车记录";
        }else {
            if (self.markNum.integerValue == 2) {
                _headViewTitleLabel.text = [AcountManager manager].subjecttwo.progress;

            }else if (self.markNum.integerValue == 3) {
                _headViewTitleLabel.text = [AcountManager manager].subjectthree.progress;

            }

        }
    }
    return _headViewTitleLabel;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+44, kSystemWide, kSystemHeight-64-49-44) style:UITableViewStylePlain];
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
//    NSLog("%",[self.markNum integerValue]);
    NSString *downLoadUrl = [NSString stringWithFormat:BASEURL,appointmentUrl];
    DYNSLog(@"url = %@ %@",[AcountManager manager].userid,[AcountManager manager].userToken);
    
    __weak AppointmentViewController *weakSelf = self;
    [JENetwoking startDownLoadWithUrl:downLoadUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSDictionary *param = data;
        NSNumber *type = param[@"type"];
        NSArray *array = param[@"data"];
        NSError *error = nil;
        
        [weakSelf.dataArray removeAllObjects];
        
        NSString *msg = [NSString stringWithFormat:@"%@", param[@"msg"]];
        if (type.integerValue == 1) {
            [weakSelf.dataArray addObjectsFromArray:[MTLJSONAdapter modelsOfClass:MyAppointmentModel.class fromJSONArray:array error:&error]];
            
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_header endRefreshing];
            
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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64,kSystemWide,44)];
    view.backgroundColor = [UIColor whiteColor];
    
    [view addSubview:self.headViewTitleButton];   //黄色的小圆圈
    
    [view addSubview:self.headViewTitleLabel];
    
    [view addSubview:self.headViewImageView];
    
    [view addSubview:self.headViewCoachName];
    [view addSubview:self.headViewCoachAddress];
    
    [self.headViewTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view.mas_top).offset(13);
        make.left.mas_equalTo(self.headViewTitleButton.mas_right).offset(5);
        make.right.mas_equalTo(view.mas_right).offset(-15);
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
    
    AppointmentState state = model.reservationstate.integerValue - 1;
   
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
