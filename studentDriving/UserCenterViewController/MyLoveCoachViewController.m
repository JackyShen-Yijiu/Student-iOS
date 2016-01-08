//
//  MyLoveCoachViewController.m
//  BlackCat
//
//  Created by bestseller on 15/9/18.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "MyLoveCoachViewController.h"
#import "UIDevice+JEsystemVersion.h"
#import "UIView+CalculateUIView.h"
#import "CoachTableViewCell.h"
#import "CoachModel.h"

static NSString *const kGetMyCoachListUrl = @"userinfo/getmycoachlist";

@interface MyLoveCoachViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation MyLoveCoachViewController

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kSystemWide, kSystemHeight-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的教练";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    if ([UIDevice jeSystemVersion] >= 7.0f) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//      }
    
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    [self startDownLoad];
    
}
- (void)startDownLoad {
    NSString *urlString = [NSString stringWithFormat:BASEURL,kGetMyCoachListUrl];
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        DYNSLog(@"data = %@",data);
        
        NSDictionary *param = data;
        NSArray * array = param[@"data"];
        if (array && [array isKindOfClass:[NSArray class]] && array.count) {
            NSError *error = nil;
            self.dataArray = [MTLJSONAdapter modelsOfClass:CoachModel.class fromJSONArray:param[@"data"] error:&error];
            [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.tableView animated:YES];
        }else{
            [self showTotasViewWithMes:@"列表为空"];
            [MBProgressHUD hideHUDForView:self.tableView animated:YES];
        }
    }];
}
#pragma mark - bntAciton


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
        static NSString *cellId = @"Coach";
        CoachTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[CoachTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    CoachModel *model = self.dataArray[indexPath.row];
    
    [cell receivedCellModelWith:model];
        return cell;
    
}


@end
