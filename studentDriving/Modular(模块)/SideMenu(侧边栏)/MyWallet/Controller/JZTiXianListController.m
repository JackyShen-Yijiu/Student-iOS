//
//  JZTiXianListController.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZTiXianListController.h"
#import "JZNoDataView.h"

@interface JZTiXianListController ()
@property (nonatomic, weak)  JZNoDataView *noDataView;

@end

@implementation JZTiXianListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"提现记录";
    self.view.backgroundColor = RGBColor(232, 232, 237);
    
    JZNoDataView *noDataView = [[JZNoDataView alloc]initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight-64)];

    noDataView.noDataImageView.image = [UIImage imageNamed:@"YBNocountentimage_wallet_cash"];
    
    noDataView.noDataLabel.text = @"暂无提现记录";
    
    [self.view addSubview:noDataView];
    
    self.noDataView = noDataView;
    
    
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
