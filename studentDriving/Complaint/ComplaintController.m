//
//  ComplaintController.m
//  studentDriving
//
//  Created by 大威 on 16/1/26.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "ComplaintController.h"
#import "ComplaintCoachView.h"
#import "ComplaintDrivingView.h"

@interface ComplaintController ()

@property (weak, nonatomic) IBOutlet UIButton *coachButton;
@property (weak, nonatomic) IBOutlet UIButton *DrivingButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) ComplaintCoachView *coachView;
@property (nonatomic, strong) ComplaintDrivingView *drivingView;

@end

@implementation ComplaintController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.scrollView addSubview:self.coachView];
    [self.scrollView addSubview:self.drivingView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGSize size = self.view.bounds.size;
    _coachView.frame = CGRectMake(0, 0, size.width, size.height);
    _drivingView.frame = CGRectMake(size.width, 0, size.width, size.height);
}

#pragma mark - lazy load
- (ComplaintCoachView *)coachView {
    if (!_coachView) {
        _coachView = [ComplaintCoachView new];
    }
    return _coachView;
}
- (ComplaintDrivingView *)drivingView {
    if (!_drivingView) {
        _drivingView = [ComplaintDrivingView new];
    }
    return _drivingView;
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
