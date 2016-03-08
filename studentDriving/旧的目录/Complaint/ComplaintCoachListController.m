//
//  ComplaintCoachListController.m
//  studentDriving
//
//  Created by 大威 on 16/1/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "ComplaintCoachListController.h"

@interface ComplaintCoachListController ()

@end

@implementation ComplaintCoachListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"教练列表";
    self.view.backgroundColor = [UIColor whiteColor];
    _coachNameLabel.text = @"fjkldsjf";
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
