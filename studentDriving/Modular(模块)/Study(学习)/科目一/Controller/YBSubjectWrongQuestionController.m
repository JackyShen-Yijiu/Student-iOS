//
//  YBSubjectWrongQuestionController.m
//  studentDriving
//
//  Created by JiangangYang on 16/4/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBSubjectWrongQuestionController.h"
#import "ScrollViewPage.h"
#import "YBSubjectTool.h"
#import "YBSubjectQuestionRightBarView.h"

@interface YBSubjectWrongQuestionController ()
@property (nonatomic,strong) YBSubjectQuestionRightBarView *rightBarView;
@end

@implementation YBSubjectWrongQuestionController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    NSLog(@"YBSubjectQuestionsViewController kemu:%ld",(long)_kemu);
    
    NSArray *titleArray;
    NSArray *imgArray;
    titleArray = [NSArray arrayWithObjects:@"比例",@"正确",@"错误",@"正确率", nil];
    imgArray = [NSArray arrayWithObjects:@"YBStudySubjectsubject",@"YBStudySubjectright",@"YBStudySubjectwrong",@"YBStudySubjectpercentage",nil];
    
    self.view.backgroundColor = YBMainViewControlerBackgroundColor;
    
    _rightBarView = [[YBSubjectQuestionRightBarView alloc] initWithFrame:CGRectMake(0, 0, titleArray.count * 45, 40) withTitleArray:titleArray withImgArray:imgArray];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBarView];
    
    NSString *userid = @"null";
    NSLog(@"[AcountManager manager].userid:%@",[AcountManager manager].userid);
//    if ([AcountManager manager].userid && [[AcountManager manager].userid length]!=0) {
//        userid = [AcountManager manager].userid;
//    }
    
    // 数组中保存的是YBSubjectData对象
    NSArray *dataArray = [YBSubjectTool getAllWrongQuestionwithtype:_kemu userid:userid];
    
    ScrollViewPage *scrollView = [[ScrollViewPage alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-64) withArray:dataArray rightBarView:_rightBarView subjectType:_kemu chapter:@""];
    scrollView.parentViewController = self;
    [self.view addSubview:scrollView];
    
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
