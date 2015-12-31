//
//  DiscountShopController.m
//  studentDriving
//
//  Created by ytzhang on 15/12/31.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "DiscountShopController.h"

#import "DiscountShopCell.h"

@interface DiscountShopController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *discountView;

@property (nonatomic, strong) UIView *muddleView;

@end

@implementation DiscountShopController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"兑换商城";
    self.view.backgroundColor = [UIColor whiteColor];
    self.discountView.delegate = self;
    self.discountView.dataSource = self;
    [self.view addSubview:self.discountView];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"discountID";
    DiscountShopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[DiscountShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (UITableView *)discountView
{
    if (_discountView == nil) {
        _discountView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height -64) style:UITableViewStylePlain];
        
    }
    
    return _discountView;
}

@end
