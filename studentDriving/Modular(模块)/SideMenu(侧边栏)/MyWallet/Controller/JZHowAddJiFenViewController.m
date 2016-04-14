//
//  JZHowAddJiFenViewController.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZHowAddJiFenViewController.h"
#import "HowAddJiFenView.h"
#define kLKSize [UIScreen mainScreen].bounds.size

@interface JZHowAddJiFenViewController ()
@property (nonatomic, weak) HowAddJiFenView *howAddView;
@end

@implementation JZHowAddJiFenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    self.title = @"赚积分";
    
    HowAddJiFenView *howAddView = [[HowAddJiFenView alloc]initWithFrame:CGRectMake(0, 0, kLKSize.width, kLKSize.height)];
    
    self.howAddView = howAddView;
    
    self.howAddView.myJiFenLabel.text = self.myJiFenCount;
    
    [self.view addSubview:howAddView];
    
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
