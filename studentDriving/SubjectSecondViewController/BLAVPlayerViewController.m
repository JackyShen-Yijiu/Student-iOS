//
//  BLAVPlayerViewController.m
//  studentDriving
//
//  Created by bestseller on 15/11/4.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "BLAVPlayerViewController.h"
#import "UIDevice+JEsystemVersion.h"
#import "BLAVplayerCell.h"
#import <SVProgressHUD.h>
#import "AVPlayModel.h"
#import "BLAVDetailViewController.h"
#import "BLImageViewController.h"
static NSString *const kavPlayUrl = @"getcourseware?subjectid=%@&seqindex=%@&count=10";

@interface BLAVPlayerViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;
@end

@implementation BLAVPlayerViewController
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([UIDevice jeSystemVersion] >= 7.0f) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self.view addSubview:self.tableView];
    
    [self startDownLoad];
    
}
- (void)startDownLoad {

    NSString *url = [NSString stringWithFormat:kavPlayUrl,self.markNum,[NSNumber numberWithInteger:0]];
    
    NSString *urlString = [NSString stringWithFormat:BASEURL,url];
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        DYNSLog(@"data = %@",data);
        NSDictionary *param = data;
        NSNumber *type = param[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@",param[@"msg"]];
        if (type.integerValue == 1) {
            self.dataArray = [MTLJSONAdapter modelsOfClass:AVPlayModel.class fromJSONArray:param[@"data"] error:nil];
            [self.tableView reloadData];
        }else {
            [SVProgressHUD showErrorWithStatus:msg];
        }
    }];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 230;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    BLAVplayerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[BLAVplayerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    AVPlayModel *model = self.dataArray[indexPath.row];
    cell.backgroundColor = MAINCOLOR;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.backGroundImage sd_setImageWithURL:[NSURL URLWithString:model.pictures]];
    cell.AVdescribe.text = model.name;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AVPlayModel *model = self.dataArray[indexPath.row];
    if ([model.videourl containsString:@"7xnjg0"]) {
        BLImageViewController *blimage = [[BLImageViewController alloc] init];
        blimage.videourl = model.videourl;
        [self.navigationController pushViewController:blimage animated:YES];
        return;
    }
    BLAVDetailViewController *detail = [[BLAVDetailViewController alloc] init];
    detail.avPlayerString = model.videourl;
    [self.navigationController pushViewController:detail animated:YES];

}
@end
