//
//  YBStudyTableView.m
//  HeiMao_B
//
//  Created by 大威 on 16/2/3.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBStudyTableView.h"
#import "YBStudyViewCell.h"
#import "DVVToast.h"
#import "QuestionTestViewController.h"
#import "QuestionBankViewController.h"
#import "WrongQuestionViewController.h"
#import "BLAVPlayerViewController.h"
#import "WMCommon.h"
#import "YBAppointTestViewController.h"
#import "YBCheatslistViewController.h"
#import "YBCheatsViewController.h"
#import "MyConsultationListController.h"

#import "YBSubjectQuestionsListController.h"

#import "JZAppointTestFirstController.h"
#import "JZAppointTestApplyController.h"
#import "JZAppointTestSuccessController.h"
#import "YBSubjectExamViewController.h"
#import "YBSubjectWrongQuestionController.h"

#import "YBSubjectTool.h"

#define kCellIdentifier @"YBStudyViewCell"

#import "YBSubjectQuestionsViewController.h"

static NSString *kapplyStare = @"userinfo/getmyexaminfo";

@interface YBStudyTableView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *dataTabelView;

@end

@implementation YBStudyTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.dataTabelView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _dataTabelView.frame = self.bounds;
}

- (void)reloadData
{
    
    NSLog(@"reloadData dataArray:%@",_dataArray);
    
    [self.dataTabelView reloadData];
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YBStudyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[YBStudyViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }

    cell.dictModel = _dataArray[indexPath.row];
    
    return cell;
}

#pragma mark - lazy load
- (UITableView *)dataTabelView {
    if (!_dataTabelView) {
        _dataTabelView = [UITableView new];
        _dataTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _dataTabelView.dataSource = self;
        _dataTabelView.delegate = self;
        // 如果是固定高度的话在这里设置比较好
        _dataTabelView.rowHeight = 68;
//        _dataTabelView.tableFooterView = [UIView new];
        _dataTabelView.backgroundColor =[UIColor clearColor];
    }
    return _dataTabelView;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"self.studyProgress:%ld",(long)self.studyProgress);
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ([WMCommon getInstance].homeState==kStateMenu) {
        [[NSNotificationCenter defaultCenter] postNotificationName:KhiddenSlide object:self];
        return;
    }
    
    NSDictionary *dict = _dataArray[indexPath.row];

    switch (self.studyProgress) {
        case YBStudyProgress1:
            
            if (indexPath.row==0) {
    
                NSLog(@"self.questiontesturl:%@",self.questiontesturl);
                YBSubjectQuestionsListController *vc = [[YBSubjectQuestionsListController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.kemu = subjectOne;
                [self.parentViewController.navigationController pushViewController:vc animated:YES];

            }else if (indexPath.row==1){
                
                if ([AcountManager manager].userid && [[AcountManager manager].userid length]!=0) {
                   
                    YBSubjectExamViewController *vc = [[YBSubjectExamViewController alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.kemu = subjectOne;
                    [self.parentViewController.navigationController pushViewController:vc animated:YES];
 
                }else{
                    
                    [DVVUserManager userNeedLogin];
                    
                }
                
            }else if (indexPath.row==2){
                
                NSString *userid = @"null";
                NSLog(@"[AcountManager manager].userid:%@",[AcountManager manager].userid);
//                if ([AcountManager manager].userid && [[AcountManager manager].userid length]!=0) {
//                    userid = [AcountManager manager].userid;
//                }
                
                // 数组中保存的是YBSubjectData对象
                NSArray *dataArray = [YBSubjectTool getAllWrongQuestionwithtype:subjectOne userid:userid];
                NSLog(@"科目一错题dataArray:%@",dataArray);
                
                if (dataArray && dataArray.count!=0) {
                    
                    YBSubjectWrongQuestionController *vc = [[YBSubjectWrongQuestionController alloc] init];
                    vc.kemu = subjectOne;
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.parentViewController.navigationController pushViewController:vc animated:YES];

                }else{
                    
                    [self obj_showTotasViewWithMes:@"暂无错题"];
                    
                }
                
            }else if (indexPath.row==3){
                
                if ([AcountManager manager].userid && [[AcountManager manager].userid length]!=0) {
                    
                    // 判断申请状态
                    if ([[AcountManager manager].userApplystate isEqualToString:@"0"]) {
                        [self obj_showTotasViewWithMes:@"您还未报名"];
                        return;
                    }
                    if ([[AcountManager manager].userApplystate isEqualToString:@"1"]) {
                        [self obj_showTotasViewWithMes:@"报名正在申请中"];
                        return;
                    }
                    
                    
                    [self applyinitWith:@"1"];
                    
                }else{
                    
                    [DVVUserManager userNeedLogin];
                    
                }
                
            }else if (indexPath.row==4){
                
                YBCheatsViewController *vc = [[YBCheatsViewController alloc] init];
//                vc.title = @"科目一成绩单";
                vc.hidesBottomBarWhenPushed = YES;
                vc.weburl = self.kemuyichengjidanurl;
                [self.parentViewController.navigationController pushViewController:vc animated:YES];
                
            }
            
            break;
        
        case YBStudyProgress2:
            
            if (indexPath.row==0) {
                
                BLAVPlayerViewController *bLAVPlayweVC = [[BLAVPlayerViewController alloc] init];
                bLAVPlayweVC.hidesBottomBarWhenPushed = YES;
                bLAVPlayweVC.title = @"科二课件";
                bLAVPlayweVC.markNum = [NSNumber numberWithInteger:2];
                [self.parentViewController.navigationController pushViewController:bLAVPlayweVC animated:YES];
                //                [mainVC presentViewController:bLAVPlayweVC animated:NO completion:nil];
                
            }else if (indexPath.row==1){
                
                
                
                YBCheatslistViewController *vc = [[YBCheatslistViewController alloc] init];
                vc.isSubjectTwo = YES;
                vc.hidesBottomBarWhenPushed = YES;
                [self.parentViewController.navigationController pushViewController:vc animated:YES];
                
            }else if (indexPath.row==2){
                
                // 我要约考
                
                // 判断申请状态
                if ([[AcountManager manager].userApplystate isEqualToString:@"0"]) {
                    [self obj_showTotasViewWithMes:@"您还未报名"];
                    return;
                }
                if ([[AcountManager manager].userApplystate isEqualToString:@"1"]) {
                    [self obj_showTotasViewWithMes:@"报名正在申请中"];
                    return;
                }

                [self applyinitWith:@"2"];
                
            }else if (indexPath.row==3){
                
            }
            
            break;
            
        case YBStudyProgress3:
            
            if (indexPath.row==0) {
                
                BLAVPlayerViewController *bLAVPlayweVC = [[BLAVPlayerViewController alloc] init];
                bLAVPlayweVC.hidesBottomBarWhenPushed = YES;
                bLAVPlayweVC.title = @"科三课件";
                bLAVPlayweVC.markNum = [NSNumber numberWithInteger:3];
                [self.parentViewController.navigationController pushViewController:bLAVPlayweVC animated:YES];
                
            }else if (indexPath.row==1){
                
                YBCheatslistViewController *vc = [[YBCheatslistViewController alloc] init];
                vc.isSubjectTwo = NO;
                vc.hidesBottomBarWhenPushed = YES;
                [self.parentViewController.navigationController pushViewController:vc animated:YES];
                
            }else if (indexPath.row==2){
                // 我要约考
                
                
                // 判断申请状态
                if ([[AcountManager manager].userApplystate isEqualToString:@"0"]) {
                    [self obj_showTotasViewWithMes:@"您还未报名"];
                    return;
                }
                if ([[AcountManager manager].userApplystate isEqualToString:@"1"]) {
                    [self obj_showTotasViewWithMes:@"报名正在申请中"];
                    return;
                }

                 [self applyinitWith:@"3"];
                
            }else if (indexPath.row==3){
                
            }
            
            break;
            
        case YBStudyProgress4:
            
            if (indexPath.row==0) {
                
                YBSubjectQuestionsListController *vc = [[YBSubjectQuestionsListController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.kemu = subjectFour;
                [self.parentViewController.navigationController pushViewController:vc animated:YES];

            }else if (indexPath.row==1){
                
                if ([AcountManager manager].userid && [[AcountManager manager].userid length]!=0) {
                    
                    YBSubjectExamViewController *vc = [[YBSubjectExamViewController alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.kemu = subjectFour;
                    [self.parentViewController.navigationController pushViewController:vc animated:YES];

                }else{
                    
                    [DVVUserManager userNeedLogin];
                    
                }
                
            }else if (indexPath.row==2){
                
                NSString *userid = @"null";
                NSLog(@"[AcountManager manager].userid:%@",[AcountManager manager].userid);
//                if ([AcountManager manager].userid && [[AcountManager manager].userid length]!=0) {
//                    userid = [AcountManager manager].userid;
//                }
                
                // 数组中保存的是YBSubjectData对象
                NSArray *dataArray = [YBSubjectTool getAllWrongQuestionwithtype:subjectFour userid:userid];
                NSLog(@"科目四错题dataArray:%@",dataArray);
                
                if (dataArray && dataArray.count!=0) {
                    
                    YBSubjectWrongQuestionController *vc = [[YBSubjectWrongQuestionController alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.kemu = subjectFour;
                    [self.parentViewController.navigationController pushViewController:vc animated:YES];
                    
                }else{
                    
                    [self obj_showTotasViewWithMes:@"暂无错题"];
                    
                }
                
            }else if (indexPath.row==3){
                // 我要约考
                if ([AcountManager manager].userid && [[AcountManager manager].userid length]!=0) {
                    
                    // 判断申请状态
                    if ([[AcountManager manager].userApplystate isEqualToString:@"0"]) {
                        [self obj_showTotasViewWithMes:@"您还未报名"];
                        return;
                    }
                    if ([[AcountManager manager].userApplystate isEqualToString:@"1"]) {
                        [self obj_showTotasViewWithMes:@"报名正在申请中"];
                        return;
                    }
                    
                    [self applyinitWith:@"4"];
                    
                }else{
                    
                    [DVVUserManager userNeedLogin];
                    
                }
                
                
            }else if (indexPath.row==4){
                
                YBCheatsViewController *vc = [[YBCheatsViewController alloc] init];
//                vc.title = @"科目四成绩单";
                vc.hidesBottomBarWhenPushed = YES;
                vc.weburl = self.kemusichengjidanurl;
                [self.parentViewController.navigationController pushViewController:vc animated:YES];
                
            }
            
            break;
            
        default:
            break;
    }
}

- (void)applyinitWith:(NSString *)subjectID{
    NSString *url = [NSString stringWithFormat:BASEURL,kapplyStare];
    NSDictionary *param = @{@"subjectid":subjectID};
    [JENetwoking startDownLoadWithUrl:url postParam:param WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSDictionary *param = data;
        if (1 == [param[@"type"] integerValue]) {
            NSDictionary *resultDic  = param[@"data"];
            if (0 == [resultDic[@"examinationstate"] integerValue]) {
                // 未申请
                JZAppointTestFirstController *appointVc = [[JZAppointTestFirstController alloc] init];
                appointVc.hidesBottomBarWhenPushed = YES;
                [self.parentViewController.navigationController pushViewController:appointVc animated:YES];
            }
            if (1 == [resultDic[@"examinationstate"] integerValue]) {
                // 申请中
                JZAppointTestApplyController *appointVc = [[JZAppointTestApplyController alloc] init];
                appointVc.hidesBottomBarWhenPushed = YES;
                [self.parentViewController.navigationController pushViewController:appointVc animated:YES];
            }
            if (2 == [resultDic[@"examinationstate"] integerValue]) {
                // 申请拒绝
            }
            if (3 == [resultDic[@"examinationstate"] integerValue]) {
                // 已安排
                JZAppointTestSuccessController *appointVc = [[JZAppointTestSuccessController alloc] init];
                appointVc.hidesBottomBarWhenPushed = YES;
                [self.parentViewController.navigationController pushViewController:appointVc animated:YES];
                
            }
            
        }
    } withFailure:^(id data) {
        
    }];

}
@end
