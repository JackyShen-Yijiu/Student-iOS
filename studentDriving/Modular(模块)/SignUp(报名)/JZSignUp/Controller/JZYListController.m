//
//  JZYListController.m
//  studentDriving
//
//  Created by ytzhang on 16/3/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZYListController.h"
#import "JZYListCell.h"

#import "YYModel.h"


//http://jzapi.yibuxueche.com/api/v1/userinfo/getUserAvailableFcode?userid=56e11a60f65080c096dffcac

static NSString *YgetMyList = @"userinfo/getUserAvailableFcode";

@interface JZYListController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *yListArray;

@end

@implementation JZYListController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Y码券";
    self.view.backgroundColor = RGBColor(226, 226, 233);
    [self.view addSubview:self.tableView];
    [self initData];
    
}
- (void)initData{
    
    NSString *url = [NSString stringWithFormat:BASEURL,YgetMyList];
    NSDictionary *parm = @{@"userid":[[AcountManager manager] userid]};
    
    [JENetwoking startDownLoadWithUrl:url postParam:parm WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        /*
         {
         "type": 1,
         "msg": "",
         "data": [
         {
         "Ycode": "YB34EP",
         "name": "王小二",
         "date": "2015/12/31"
         }
         ]
         }
         */
          NSLog(@"data = %@",data);
        NSDictionary *parm = data;
        if ([parm[@"type"] integerValue] == 1) {
            NSArray *array = data[@"data"];
            if (array.count == 0) {
                [self obj_showTotasViewWithMes:@"您暂无Y码"];
                return ;
            }
            for (NSDictionary *dic in array) {
                JZYListModel *ylistModel = [JZYListModel yy_modelWithDictionary:dic];
                [self.yListArray addObject:ylistModel];
                
            }
        }
        
      
    } withFailure:^(id data) {
        
    }];
    
    
    
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.yListArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120 + 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *YListCellID = @"listCellID";
    JZYListCell *listCell = [tableView dequeueReusableCellWithIdentifier:YListCellID];
    if (!listCell) {
        listCell = [[JZYListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YListCellID];
    }
    return listCell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
#pragma mark ---- Lazy 加载

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight - 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource  = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
- (NSMutableArray *)yListArray{
    if (_yListArray == nil) {
        _yListArray = [NSMutableArray array];
    }
    return _yListArray;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    JZYListModel *model = self.yListArray[indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(initWithYlistModel:)]) {
        [self.delegate initWithYlistModel:model];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
