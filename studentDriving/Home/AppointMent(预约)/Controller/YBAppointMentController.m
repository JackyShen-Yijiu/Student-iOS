//
//  YBAppointMentController.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBAppointMentController.h"
#import "YBAppointMentNoCountentView.h"
#import "YBAppointMentChangeCoachController.h"

@interface YBAppointMentController ()

@property (nonatomic,strong) YBAppointMentNoCountentView *noCountmentView;

@end

@implementation YBAppointMentController

- (YBAppointMentNoCountentView *)noCountmentView
{
    if (_noCountmentView==nil) {
        _noCountmentView = [[YBAppointMentNoCountentView alloc] init];
        _noCountmentView.frame = self.view.bounds;
    }
    return _noCountmentView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.view addSubview:self.noCountmentView];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.title = @"预约";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"换教练" style:UIBarButtonItemStyleDone target:self action:@selector(changeCoach)];
    
    
}

- (void)changeCoach
{
    YBAppointMentChangeCoachController *vc = [[YBAppointMentChangeCoachController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
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
