//
//  JZMyWalletXianJinView.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZMyWalletXianJinView.h"
#import "JZMyWalletXianJinCell.h"
#import "JZMyWalletXianJinMoneylist.h"
#import <YYModel.h>
#define kLKSize [UIScreen mainScreen].bounds.size

static NSString *xianJinCellID = @"xianJinCellID";

@interface JZMyWalletXianJinView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *xianJinListArr;

@property (nonatomic, strong) JZMyWalletXianJinMoneylist *listData;


@end

@implementation JZMyWalletXianJinView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.frame = frame;
        
        self.dataSource = self;
        
        self.delegate = self;
        
        self.rowHeight = 72;
        [self loadData];
        
    }
    return self;
    
}


#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.xianJinListArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    JZMyWalletXianJinCell *xianJinCell = [tableView dequeueReusableCellWithIdentifier:xianJinCellID];
    
    if (!xianJinCell) {
        
        xianJinCell = [[JZMyWalletXianJinCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:xianJinCellID];
        
        self.listData = self.xianJinListArr[indexPath.row];
        
        xianJinCell.xianJinNumLabel.text = [NSString stringWithFormat:@"￥%@",self.listData.income];

        
        NSString *dateStr = [self getLocalDateFormateUTCDate:self.listData.createtime];

        xianJinCell.xianJinDateLabel.text = dateStr;
        
        if ([self.listData.type isEqualToString:@"0"] ) {
            xianJinCell.xianJinSourceLabel.text = @"支出";
        }else if ([self.listData.type isEqualToString:@"1"]){
            
            xianJinCell.xianJinSourceLabel.text = @"报名奖励";
        }else if ([self.listData.type isEqualToString:@"2"]){
            xianJinCell.xianJinSourceLabel.text = @"邀请奖励";
        }else if([self.listData.type isEqualToString:@"3"]){
            
            xianJinCell.xianJinSourceLabel.text = @"线下分红";

        }
        
        
        
    }
    
    xianJinCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return xianJinCell;
    
}

-(void)loadData {
    
    NSString *urlString = [NSString stringWithFormat:BASEURL, @"userinfo/getmymoneylist"];
    NSDictionary *paramsDict = @{@"userid": [AcountManager manager].userid,@"usertype":@"1",@"index":@"1",@"count":@"10"};
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:paramsDict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSDictionary *resultData = data[@"data"];
        NSLog(@"获取现金:%@",data);
        
        /*
         
         {
         data =     {
         fcode = YBG251;
         money = 150;
         moneylist =         (
         {
         createtime = "2016-01-07T09:25:40.470Z";
         income = 150;
         type = 2;
         }
         );
         userid = 56e6341394aaa86c3244d9a1;
         };
         msg = "";
         type = 1;
         }
         

         
         */
        
        if ([[data objectForKey:@"type"] integerValue]) {
            
            NSArray *array = resultData[@"moneylist"];
            for (NSDictionary *dic in array) {
                JZMyWalletXianJinMoneylist *listModel = [JZMyWalletXianJinMoneylist yy_modelWithJSON:dic];
                
                
                [self.xianJinListArr addObject:listModel];
            }
            [self reloadData];
        }
        
    } withFailure:^(id data) {
        
        [self obj_showTotasViewWithMes:@"网络错误"];
        
    }];
    
    
}

-(NSMutableArray *)xianJinListArr {
    
    if (!_xianJinListArr) {
        
        NSMutableArray *arrM = [[NSMutableArray alloc]init];
        
        self.xianJinListArr = arrM;
    }
    
    
    
    return _xianJinListArr;
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


@end
