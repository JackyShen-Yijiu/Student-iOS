//
//  YBMallViewController.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBMallViewController.h"
#import "YBIntegralMallCell.h"
#import "YBIntegralMallModel.h"
#import "MagicDetailViewController.h"

@interface YBMallViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tabelView;

@property (nonatomic,retain) NSMutableArray *shopMainListArray; // 存放展示图片

@end

static NSString *kMagicShop = @"getmailproduct?index=1&count=10&producttype=1";
@implementation YBMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shopMainListArray = [[NSMutableArray alloc] init];
    self.title = @"商城";
    self.tabelView.delegate = self;
    self.tabelView.dataSource  = self;
    [self.view addSubview:self.tabelView];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [self startDownLoad];
}
#pragma mark --------加载数据
- (void)startDownLoad {
        
        NSString *urlString = [NSString stringWithFormat:BASEURL,kMagicShop];
        NSLog(@"%@",urlString);
        NSDictionary *parm = @{@"cityname":@"北京"};
        //    NSLog(@"%@",[AcountManager manager].userCity);
        [JENetwoking startDownLoadWithUrl:urlString postParam:parm WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
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
                    YBIntegralMallModel *mainDodel = [[YBIntegralMallModel alloc] init];
                    [mainDodel setValuesForKeysWithDictionary:dic];
                    [self.shopMainListArray addObject:mainDodel];
                }
            }
            
            [self.tabelView reloadData];
            
            
        } ];
        
    }


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.shopMainListArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 165;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID =@"MallCellID";
    YBIntegralMallCell *mallCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!mallCell) {
        mallCell = [[YBIntegralMallCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        mallCell.backgroundColor = [UIColor clearColor];
    }
    mallCell.integralMallModel = self.shopMainListArray[indexPath.row];
    return mallCell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tabelView deselectRowAtIndexPath:indexPath animated:YES];
    MagicDetailViewController *detailVC = [[MagicDetailViewController alloc] init];
    detailVC.mainModel = _shopMainListArray[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark ---- Lazy 加载
- (UITableView *)tabelView{
    if (_tabelView == nil) {
        _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 65) style:UITableViewStylePlain];
        _tabelView.backgroundColor = [UIColor clearColor];
        _tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tabelView;

}
@end
