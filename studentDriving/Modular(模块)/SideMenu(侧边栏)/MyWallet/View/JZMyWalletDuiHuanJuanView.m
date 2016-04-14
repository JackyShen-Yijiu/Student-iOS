//
//  JZMyWalletDuiHuanJuanView.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZMyWalletDuiHuanJuanView.h"
#import <YYModel.h>
#define kLKSize [UIScreen mainScreen].bounds.size
static NSString *duiHuanJuanHeaderViewID = @"duiHuanJuanHeaderViewID";
static NSString *duiHuanJuanDetailCellID = @"duiHuanJuanDetailCellID";
@interface JZMyWalletDuiHuanJuanView ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,assign) NSInteger selectHeaderViewTag;

@end

@implementation JZMyWalletDuiHuanJuanView
-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBColor(232, 232, 237);
        self.frame = frame;
        
        self.dataSource = self;
        
        self.delegate = self;
        
        self.rowHeight = 99;
        self.sectionHeaderHeight = 130;
        
        [self loadData];
        
    }
    return self;
    
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    JZMyWalletDuiHuanJuanData *dataModel = self.duiHuanJuanDataArrM[section];
    
    if (dataModel.openGroup && self.selectHeaderViewTag == section)
        return self.duiHuanJuanDataArrM.count;
    
    return 0;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JZMyWalletDuiHuanJuanCell *duiHuanJuanCell = [tableView dequeueReusableCellWithIdentifier:duiHuanJuanDetailCellID];
    
    if (!duiHuanJuanCell) {
        
        duiHuanJuanCell = [[JZMyWalletDuiHuanJuanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:duiHuanJuanDetailCellID];
        
    }
    
    JZMyWalletDuiHuanJuanUseproductidlist *list = self.duihuanJuanListArrM[indexPath.row];
    
    
    duiHuanJuanCell.duiHuanJuanDetailLabel.text = list.productname;
    
    return duiHuanJuanCell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    

    
    return self.duiHuanJuanDataArrM.count;
    
}

// 用来返回每一组的头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // 1.创建headerView
    JZMyWalletDuiHuanJuanHeaderView *duiHuanJuanHeaerView = [JZMyWalletDuiHuanJuanHeaderView duiHuanJuanHeaderViewWithTableView:tableView withTag:section];
    
    
    // 2.给headerView传递模型
    duiHuanJuanHeaerView.duiHuanJuanDetailView.tag = section;
    duiHuanJuanHeaerView.duiHuanJuanDetailView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(duiHuanJuanHeaerViewDidClick:)];
    [duiHuanJuanHeaerView.duiHuanJuanDetailView addGestureRecognizer:tap];
    
    self.duiHuanJuanHeaerView = duiHuanJuanHeaerView;
    
    JZMyWalletDuiHuanJuanData *data = self.duiHuanJuanDataArrM[section];
    
    duiHuanJuanHeaerView.spendDateLabel.text = [NSString stringWithFormat:@"有效期至：%@",[self getLocalDateFormateUTCDate:data.createtime]];
    
    
    if (data.couponcomefrom == 1) {
        
        duiHuanJuanHeaerView.duiHuanJuanName.text = @"报名奖励兑换券";
    }else if(data.couponcomefrom == 2) {
        
        duiHuanJuanHeaerView.duiHuanJuanName.text = @"活动奖励兑换券";

    }
    
    
    
    
    
    // 3.返回haderView
    return duiHuanJuanHeaerView;
    
    
}
-(void)setDataModel:(JZMyWalletDuiHuanJuanData *)dataModel {
    
    
    _dataModel = dataModel;
    
    // 判断当前组是否打开或关闭,对头上的图片是否旋转做判断
    // 如果是打开了,让按钮图片旋转
    if (self.dataModel.openGroup == YES) {
        
        // 让按钮中的小图片旋转正的90度
        self.duiHuanJuanHeaerView.seeDetailImg.transform = CGAffineTransformMakeRotation(M_PI);
        
    } else {
        // 关闭让图片再还原
        self.duiHuanJuanHeaerView.seeDetailImg.transform = CGAffineTransformMakeRotation(0);
        
    }

}

///  点击兑换劵下拉视图方法
-(void)duiHuanJuanHeaerViewDidClick:(UITapGestureRecognizer *)tap {
    
    JZMyWalletDuiHuanJuanData *dataModel = self.duiHuanJuanDataArrM[self.selectHeaderViewTag];
    
    dataModel.openGroup = !dataModel.openGroup;
    
    [self.duiHuanJuanDataArrM replaceObjectAtIndex:self.selectHeaderViewTag withObject:dataModel];
    
    // 打开本分组
    NSInteger selectHeaderViewTag = tap.view.tag;
    NSLog(@"selectHeaderViewTag:%ld",(long)selectHeaderViewTag);
    self.selectHeaderViewTag = selectHeaderViewTag;
    
    [self getDuiHuanJuanDetail:dataModel.openGroup];


    

}


-(void)loadData {
    
    NSString *urlString = [NSString stringWithFormat:BASEURL, @"userinfo/getmycupon"];
    NSDictionary *paramsDict = @{@"userid": [AcountManager manager].userid};
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:paramsDict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        if ([[data objectForKey:@"type"] integerValue]) {
            
            NSArray *array = data[@"data"];
            
            NSLog(@"%@",array);
            if (array.count) {
                NSArray *duiHuanJuanDataArr = data[@"data"];
                for (NSDictionary *dict in duiHuanJuanDataArr) {
                    
                    JZMyWalletDuiHuanJuanData *data = [JZMyWalletDuiHuanJuanData yy_modelWithDictionary:dict];
                    
                    if(data.state == 0 || data.state == 1){
                    
                    [self.duiHuanJuanDataArrM addObject:data];
                    }
                }
                
                [self reloadData];
                
            }
            
  
        }
        
    } withFailure:^(id data) {
        
        [self obj_showTotasViewWithMes:@"网络错误"];
        
    }];

}

-(void)getDuiHuanJuanDetail:(BOOL)openGroup {
    
    
    if (openGroup==NO) {
    
        [self reloadData];
        
        return;
    }
    
    JZMyWalletDuiHuanJuanData *dataModel = self.duiHuanJuanDataArrM[self.selectHeaderViewTag];
    

    NSString *urlString = [NSString stringWithFormat:BASEURL, @"userinfo/getmycupon"];
    NSDictionary *paramsDict = @{@"userid": [AcountManager manager].userid};
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:paramsDict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        if ([[data objectForKey:@"type"] integerValue]) {
            
            NSArray *array = data[@"data"];
            
            NSLog(@"%@",array);
            if (array.count) {
                 dataModel.openGroup = YES;
                [self.duiHuanJuanDataArrM replaceObjectAtIndex:self.selectHeaderViewTag withObject:dataModel];
                
                [self.duihuanJuanListArrM removeAllObjects];
                
                NSArray *duiHuanJuanDataArr = data[@"data"];
                
                for (NSDictionary *dict in duiHuanJuanDataArr) {
                    
                    JZMyWalletDuiHuanJuanData *data = [JZMyWalletDuiHuanJuanData yy_modelWithDictionary:dict];
                    
                    NSArray *listArr = data.useproductidlist;
                    
                    
                    for (NSDictionary *dict in listArr) {
                        
                        
                        JZMyWalletDuiHuanJuanUseproductidlist *list = [JZMyWalletDuiHuanJuanUseproductidlist yy_modelWithDictionary:dict];
                        
                        [self.duihuanJuanListArrM addObject:list];
  
                    }
                    
                    //[self reloadData];
                }
                
                [self reloadData];
                
            }
            
            
        }
        
    } withFailure:^(id data) {
        
        [self obj_showTotasViewWithMes:@"网络错误"];
        
    }];
    

    
}



-(NSMutableArray *)duiHuanJuanDataArrM {
    
    if (_duiHuanJuanDataArrM ==  nil) {
        
        _duiHuanJuanDataArrM = [[NSMutableArray alloc]init];
    }
    return _duiHuanJuanDataArrM;
}
-(NSMutableArray *)duihuanJuanListArrM {
    
    if (_duihuanJuanListArrM==  nil) {
        
        _duihuanJuanListArrM = [[NSMutableArray alloc]init];
    }
    return _duihuanJuanListArrM;
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
