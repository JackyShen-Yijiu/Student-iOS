//
//  HowAddJiFenViewController.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "HowAddJiFenViewController.h"
#import "HowAddJiFenView.h"
#define kLKSize [UIScreen mainScreen].bounds.size

@interface HowAddJiFenViewController ()

@end

@implementation HowAddJiFenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"赚积分";
    
    HowAddJiFenView *jiFenView = [[HowAddJiFenView alloc]initWithFrame:CGRectMake(0, 0, kLKSize.width, kLKSize.height)];
    
    self.view = jiFenView;

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
