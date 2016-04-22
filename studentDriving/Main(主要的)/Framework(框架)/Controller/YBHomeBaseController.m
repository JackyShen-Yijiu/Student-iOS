//
//  YBHomeBaseController.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBHomeBaseController.h"
#import "UIImage+WM.h"
#import "WMCommon.h"
#import "NSUserStoreTool.h"

@interface YBHomeBaseController ()

@end

@implementation YBHomeBaseController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBColor(236, 236, 236);

    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(0, 0, 33, 33);
    [self.leftBtn addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setImage:[[UIImage imageNamed:@"me"] getRoundImage] forState:UIControlStateNormal];
    UIBarButtonItem *barLeftBtn = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    [self.navigationItem setLeftBarButtonItem:barLeftBtn];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"YBSliderLeftBarImg"] style:UIBarButtonItemStyleDone target:self action:@selector(clicked)];
    
    // 获取进度
    [self loadSubjectProress];
    
}

- (void)clicked {
    
    // 更新侧边栏用户信息
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kuserLogin" object:self];
    
    if ([self.delegate respondsToSelector:@selector(leftBtnClicked)]) {
        [self.delegate leftBtnClicked];
    }
    
}

- (void)loadSubjectProress
{
    
    if (![AcountManager isLogin]) {
        return;
    }
    
    // 申请状态保存
    NSString *applyUrlString = [NSString stringWithFormat:BASEURL,kinfomationCheck];
    NSDictionary *param = @{@"userid":[AcountManager manager].userid};
    [JENetwoking startDownLoadWithUrl:applyUrlString postParam:param WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"申请状态保存 data:%@",data);
       
        if (!data) {
            return ;
        }
        NSDictionary *param = data;
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        
        if ([type isEqualToString:@"1"]) {
            
            NSDictionary *dataDic = [param objectForKey:@"data"];
            if (!dataDic || ![dataDic isKindOfClass:[NSDictionary class]]) {
                return;
            }
            
            if ([[dataDic objectForKey:@"applystate"] integerValue] == 0) {// 尚未报名
                
                [AcountManager saveUserApplyState:@"0"];
                
            }else if ([[dataDic objectForKey:@"applystate"] integerValue] == 1) {// 已报名,尚未交钱
                
                [AcountManager saveUserApplyState:@"1"];
                
            }else if ([[dataDic objectForKey:@"applystate"] integerValue] == 2) {// 正常学习,
                
                [AcountManager saveUserApplyState:@"2"];
                
            }
            
            [AcountManager saveUserApplyCount:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"applycount"]]];
            
        }else {
            
        }
        
    } withFailure:^(id data) {

    }];
    
    // 获取首页状态
    NSString *getMyProgress = [NSString stringWithFormat:BASEURL,kgetMyProgress];
    [JENetwoking startDownLoadWithUrl:getMyProgress postParam:param WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"获取首页状态 data:%@",data);
       
        if (!data) {
            return ;
        }
        NSDictionary *param = data;
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        
        if ([type isEqualToString:@"1"]) {
            
            NSDictionary *dataDic = [param objectForKey:@"data"];
            if (!dataDic || ![dataDic isKindOfClass:[NSDictionary class]]) {
                return;
            }
            
            /*
             
             2016-04-16 17:53:28.467 studentDriving[18875:1682497] 获取首页状态 data:{
             data =     {
             "_id" = 56e6341394aaa86c3244d9a1;
             subject =         {
             name = "\U79d1\U76ee\U4e8c";
             subjectid = 2;
             };
             subjectfour =         {
             finishcourse = 1;
             missingcourse = 0;
             officialfinishhours = 0;
             officialhours = 960;
             progress = "\U672a\U5f00\U59cb";
             reservation = 0;
             totalcourse = 3;
             };
             subjectone =         {
             finishcourse = 2;
             missingcourse = 0;
             officialfinishhours = 779;
             officialhours = 779;
             progress = "\U672a\U5f00\U59cb";
             reservation = 0;
             totalcourse = 3;
             };
             subjectthree =         {
             buycoursecount = 0;
             finishcourse = 0;
             missingcourse = 0;
             officialfinishhours = 1569;
             officialhours = 2400;
             progress = "\U672a\U5f00\U59cb";
             reservation = 0;
             totalcourse = 16;
             };
             subjecttwo =         {
             buycoursecount = 0;
             finishcourse = 10;
             missingcourse = 10;
             officialfinishhours = 1773;
             officialhours = 1773;
             progress = "\U79d1\U76ee\U4e8c\U7b2c10\U8bfe\U65f6";
             reservation = 0;
             reservationid = 570daca86063b4f446d35502;
             totalcourse = 24;
             };
             };
             msg = "";
             type = 1;
             }

             
             */
            
            
            
            
            
            // 当前为科目几
            NSDictionary *subject = [dataDic objectForKey:@"subject"];
            if (subject) {
                [NSUserStoreTool storeWithId:subject WithKey:ksubject];
            }
            
            if ([dataDic objectForKey:@"subjectone"]) {
                [NSUserStoreTool storeWithId:[dataDic objectForKey:@"subjectone"] WithKey:ksubjectOne];
            }
            if ([dataDic objectForKey:@"subjecttwo"]) {
                [NSUserStoreTool storeWithId:[dataDic objectForKey:@"subjecttwo"] WithKey:ksubjectTwo];
            }
            if ([dataDic objectForKey:@"subjectthree"]) {
                [NSUserStoreTool storeWithId:[dataDic objectForKey:@"subjectthree"] WithKey:ksubjectThree];
            }
            if ([dataDic objectForKey:@"subjectfour"]) {
                [NSUserStoreTool storeWithId:[dataDic objectForKey:@"subjectfour"] WithKey:ksubjectFour];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:kupdateSignUpListHeaderData object:nil];
        }else {
            
        }
        
    } withFailure:^(id data) {

    }];
    
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
