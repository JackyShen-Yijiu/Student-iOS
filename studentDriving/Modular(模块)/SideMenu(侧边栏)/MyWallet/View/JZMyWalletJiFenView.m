//
//  JZMyWalletJiFenView.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZMyWalletJiFenView.h"
#import "JZMyWalletJiFenCell.h"
#import "JZMyWalletJiFenList.h"
#import <YYModel.h>
#define kLKSize [UIScreen mainScreen].bounds.size
static NSString *jiFenCellID = @"jiFenCellID";

@interface JZMyWalletJiFenView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *jiFenListArr;

@property (nonatomic, strong) JZMyWalletJiFenList *listData;
@end

@implementation JZMyWalletJiFenView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        
        self.dataSource = self;
        
        self.delegate = self;
        
        self.rowHeight = 72.5;
        self.separatorStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;


        [self loadData];
        
    }
    return self;

}


#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.jiFenListArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JZMyWalletJiFenCell *jiFenCell = [tableView dequeueReusableCellWithIdentifier:jiFenCellID];
    
    if (!jiFenCell) {
        
        jiFenCell = [[JZMyWalletJiFenCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:jiFenCellID];
        
        jiFenCell.jiFenNumLabel.text = @"+10";
        jiFenCell.jiFenDateLabel.text = @"2018/18/18";
        jiFenCell.jiFenSourceLabel.text = @"测试测试测试";
  
    }
    
    jiFenCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    self.listData = self.jiFenListArr[indexPath.row];
    
    jiFenCell.jiFenNumLabel.text = [NSString stringWithFormat:@"+%zd",self.listData.amount];
    
    
    NSString *dateStr = [self getLocalDateFormateUTCDate:self.listData.createtime];
    
    jiFenCell.jiFenDateLabel.text = dateStr;
    
    if (self.listData.type == 1 ) {
        jiFenCell.jiFenSourceLabel.text = @"注册发放";
    }else if (self.listData.type == 2){
        
        jiFenCell.jiFenSourceLabel.text = @"邀请好友发放";
    }else if (self.listData.type == 3){
        jiFenCell.jiFenSourceLabel.text = @"购买商品";
    }
    jiFenCell.selectionStyle = UITableViewCellSelectionStyleNone;

    return jiFenCell;

}



-(void)loadData {
    
    NSString *urlString = [NSString stringWithFormat:BASEURL, @"userinfo/getmywallet"];
    NSDictionary *paramsDict = @{@"userid": [AcountManager manager].userid,@"usertype":@"1",@"seqindex":@"0",@"count":@"10"};
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:paramsDict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSDictionary *resultData = data[@"data"];
        NSLog(@"获取积分:%@",data);
        
        
        if ([[data objectForKey:@"type"] integerValue]) {
            
            NSArray *array = resultData[@"list"];
            for (NSDictionary *dic in array) {
                JZMyWalletJiFenList *listModel = [JZMyWalletJiFenList yy_modelWithJSON:dic];
                
                
                [self.jiFenListArr addObject:listModel];
            }
            [self reloadData];
        }
        
    } withFailure:^(id data) {
        
        [self obj_showTotasViewWithMes:@"网络错误"];
        
    }];
    
    
}

-(NSMutableArray *)jiFenListArr {
    
    if (!_jiFenListArr) {
        
        NSMutableArray *arrM = [[NSMutableArray alloc]init];
        
        self.jiFenListArr = arrM;
    }
    
    
    
    return _jiFenListArr;
}

//将UTC日期字符串转为本地时间字符串
//输入的UTC日期格式2013-08-03T04:53:51+0000
- (NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate {
    //    NSLog(@"utc = %@",utcDate);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}
-(void)viewDidLayoutSubviews
{
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


@end
