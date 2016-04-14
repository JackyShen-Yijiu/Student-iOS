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

#define kCellIdentifier @"YBStudyViewCell"

static NSString *kapplyStare = @"userinfo/getmyexaminfo";

@interface YBStudyTableView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *dataTabelView;

@end

@implementation YBStudyTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
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
        _dataTabelView.rowHeight = 75;
        _dataTabelView.tableFooterView = [UIView new];
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
                vc.title = @"科目一章节";
                [self.parentViewController.navigationController pushViewController:vc animated:YES];
                
//                QuestionTestViewController *questionVC = [[QuestionTestViewController alloc] init];
//                questionVC.hidesBottomBarWhenPushed = YES;
//                questionVC.questiontesturl = self.questiontesturl;
//                [self.parentViewController.navigationController pushViewController:questionVC animated:YES];

            }else if (indexPath.row==1){
                
                QuestionBankViewController *questBankVC = [[QuestionBankViewController alloc] init];
                questBankVC.hidesBottomBarWhenPushed = YES;
                questBankVC.questionlisturl = self.questionlisturl;
                [self.parentViewController.navigationController pushViewController:questBankVC animated:YES];

            }else if (indexPath.row==2){
                
                WrongQuestionViewController *wrongQuestVC = [[WrongQuestionViewController alloc] init];
                wrongQuestVC.hidesBottomBarWhenPushed = YES;
                wrongQuestVC.questionerrorurl = self.questionerrorurl;
                [self.parentViewController.navigationController pushViewController:wrongQuestVC animated:YES];

            }else if (indexPath.row==3){
                // 判断申请状态
                
                [self applyinitWith:@"1"];
                
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
                 [self applyinitWith:@"3"];
                
            }else if (indexPath.row==3){
                
            }
            
            break;
            
        case YBStudyProgress4:
            
            if (indexPath.row==0) {
                
                YBSubjectQuestionsListController *vc = [[YBSubjectQuestionsListController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.kemu = subjectFour;
                vc.title = @"科目四章节";
                [self.parentViewController.navigationController pushViewController:vc animated:YES];
//                
//                QuestionBankViewController *questionBank = [[QuestionBankViewController alloc] init];
//                questionBank.hidesBottomBarWhenPushed = YES;
//                questionBank.questionlisturl = self.questionFourlisturl;
//                if ([AcountManager isLogin]) {
//                    NSString *appendString = [NSString stringWithFormat:@"?userid=%@",[AcountManager manager].userid];
//                    NSString *finalString = [self.questionFourlisturl stringByAppendingString:appendString];
//                    questionBank.questionlisturl = finalString;
//                }
//                questionBank.title = @"科四题库";
//                questionBank.isModal = YES;
                //                [mainVC.navigationController pushViewController:questionBank animated:YES];
//                [self.parentViewController.navigationController presentViewController:questionBank animated:NO completion:nil];
//                [self.parentViewController.navigationController pushViewController:questionBank animated:YES];

            }else if (indexPath.row==1){
                
                QuestionTestViewController *questionTest = [[QuestionTestViewController alloc] init];
                questionTest.hidesBottomBarWhenPushed = YES;
                if ([AcountManager isLogin]) {
                    NSString *appendString = [NSString stringWithFormat:@"?userid=%@",[AcountManager manager].userid];
                    NSString *finalString = [self.questionFourtesturl stringByAppendingString:appendString];
                    questionTest.questiontesturl = finalString;
                }
//                questionTest.title = @"科四模拟考试";
                //                [mainVC.navigationController pushViewController:questionTest animated:YES];
//                questionTest.isModal = YES;
//                [self.parentViewController.navigationController presentViewController:questionTest animated:NO completion:nil];
                [self.parentViewController.navigationController pushViewController:questionTest animated:YES];

            }else if (indexPath.row==2){
                
                WrongQuestionViewController *wrongQuestion = [[WrongQuestionViewController alloc] init];
                wrongQuestion.hidesBottomBarWhenPushed = YES;
                if (![AcountManager isLogin]) {
                    DYNSLog(@"islogin = %d",[AcountManager isLogin]);
                    [DVVUserManager userNeedLogin];
                    return;
                }else {
                    NSString *appendString = [NSString stringWithFormat:@"?userid=%@",[AcountManager manager].userid];
                    NSString *finalString = [self.questionFourerrorurl stringByAppendingString:appendString];
                    wrongQuestion.questionerrorurl = finalString;
                }
//                wrongQuestion.title = @"错题";
//                wrongQuestion.isModal = YES;
                //                [mainVC.navigationController pushViewController:wrongQuestion animated:YES];
//                [self.parentViewController.navigationController presentViewController:wrongQuestion animated:NO completion:nil];
                [self.parentViewController.navigationController pushViewController:wrongQuestion animated:YES];

                
            }else if (indexPath.row==3){
                // 我要约考
                 [self applyinitWith:@"4"];
                
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
