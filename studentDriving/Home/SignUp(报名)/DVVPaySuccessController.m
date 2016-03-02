//
//  DVVPaySuccessController.m
//  studentDriving
//
//  Created by 大威 on 16/3/2.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVPaySuccessController.h"
#import "DVVPaySuccessView.h"

@interface DVVPaySuccessController ()

@property (nonatomic, strong) DVVPaySuccessView *successView;

@end

@implementation DVVPaySuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"报名信息";
    
    [self.view addSubview:self.successView];
    
}

- (DVVPaySuccessView *)successView {
    if (!_successView) {
        _successView = [DVVPaySuccessView new];
        _successView.frame = self.view.bounds;
    }
    return _successView;
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
