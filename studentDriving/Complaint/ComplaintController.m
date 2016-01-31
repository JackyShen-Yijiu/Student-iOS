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
#import "ComplaintCoachListController.h"

@interface ComplaintController ()

@property (weak, nonatomic) IBOutlet UIButton *coachButton;
@property (weak, nonatomic) IBOutlet UIButton *DrivingButton;
@property (weak, nonatomic) IBOutlet UIView *contentView;


@property (nonatomic, strong) ComplaintCoachView *coachView;
@property (nonatomic, strong) ComplaintDrivingView *drivingView;

@property (nonatomic, strong) ComplaintCoachListController *coachListVC;

@property (nonatomic, assign) BOOL alreadyLayout;

@end

@implementation ComplaintController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"投诉";

    [_contentView addSubview:self.coachView];
    [_contentView addSubview:self.drivingView];
    _drivingView.alpha = 0;
    
    [_coachButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [_DrivingButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    _coachButton.selected = YES;
    
    _coachView.superController = self;
    _drivingView.superController = self;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!_alreadyLayout) {
        CGSize size = _contentView.bounds.size;
        _coachView.frame = CGRectMake(0, 0, size.width, size.height);
        _drivingView.frame = CGRectMake(size.width, 0, size.width, size.height);
        _alreadyLayout = YES;
    }
}

- (IBAction)coachButtonAction:(UIButton *)sender {
    
    [self scrollToCoach];
}
- (IBAction)drivingButtonAction:(UIButton *)sender {
    
    [self scrollToDriving];
}

- (void)scrollToCoach {
    _coachButton.selected = YES;
    _DrivingButton.selected = NO;
    
    CGRect rect = _coachView.frame;
    rect.origin.x = 0;
    
    CGRect rectDriving = _drivingView.frame;
    rectDriving.origin.x = rectDriving.size.width;
    
    [UIView animateWithDuration:0.3 animations:^{
        _coachView.frame = rect;
        _drivingView.frame = rectDriving;
    }];
}
- (void)scrollToDriving {
    _drivingView.alpha = 1;
    _coachButton.selected = NO;
    _DrivingButton.selected = YES;
    
    CGRect rect = _coachView.frame;
    rect.origin.x = - rect.size.width;
    
    CGRect rectDriving = _drivingView.frame;
    rectDriving.origin.x = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _coachView.frame = rect;
        _drivingView.frame = rectDriving;
    }];
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
