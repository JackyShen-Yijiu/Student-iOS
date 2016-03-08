//
//  DiscountShopController.m
//  studentDriving
//
//  Created by ytzhang on 15/12/31.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "DiscountShopController.h"

#import "DiscountShopCell.h"
#import "AcountManager.h"
#import "DiscountShopModel.h"
#import "DiscountShopDatailController.h"

static NSString *const kDiscountListUrl = @"getmailproduct?index=1&count=10&producttype=1";
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
    self.disCountListArray = [NSMutableArray array];
    
    
    [self startDownLoad];
    
}

- (void)startDownLoad {
    NSString *url = [NSString stringWithFormat:kDiscountListUrl];
    NSString *urlString = [NSString stringWithFormat:BASEURL,url];
    
    NSDictionary *parm = @{@"cityname":[AcountManager manager].userCity};
    [JENetwoking startDownLoadWithUrl:urlString postParam:parm WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data)  {
        DYNSLog(@"我的钱包start data = %@",data);
        
        DYNSLog(@"data = %@",data);
        if (data == nil) {
            return ;
        }
        NSDictionary *dataDic = [data objectForKey:@"data"];
        
        {
            NSArray *array = [dataDic objectForKey:@"mainlist"];
            if (array.count == 0) {
                [self obj_showTotasViewWithMes:@"还没有商品哦!"];
                return;
            }
            for (NSDictionary *dic in array)
            {
                DiscountShopModel *mainDodel = [[DiscountShopModel alloc] init];
                [mainDodel setValuesForKeysWithDictionary:dic];
                [self.disCountListArray addObject:mainDodel];
            }
        }
        
        [self.discountView reloadData];
        
        
    } withFailure:^(id data) {
        
        
    }];
    
    
    }


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.disCountListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"discountID";
    DiscountShopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[DiscountShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.discountModel = self.disCountListArray[indexPath.row];
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
        _discountView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, self.view.frame.size.height - 10) style:UITableViewStylePlain];
        _discountView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    return _discountView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DiscountShopDatailController *discountDatailVC = [[DiscountShopDatailController alloc] init];
    discountDatailVC.discountShopModel = self.disCountListArray[indexPath.row];
    [self.navigationController pushViewController:discountDatailVC animated:YES];
    
}
@end
