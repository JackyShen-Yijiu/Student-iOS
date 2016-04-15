//
//  JZMyComplaintListView.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZMyComplaintListView.h"
#import "JZMyComplaintData.h"
#import "JZMyComplaintListCell.h"
#import <YYModel.h>
static NSString *JZMyComplaintListCellID = @"JZMyComplaintListCell";
@interface JZMyComplaintListView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) JZMyComplaintData *dataModel;
@property (nonatomic, strong) NSMutableArray *listArr;


@end
@implementation JZMyComplaintListView


-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        
        self.dataSource = self;
        
        self.delegate = self;
        
        self.rowHeight = 150;
        self.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        [self loadData];
        
    }
    return self;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.listArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JZMyComplaintListCell *listCell = [tableView dequeueReusableCellWithIdentifier:JZMyComplaintListCellID];
    
    if (!listCell) {
        
        listCell = [[JZMyComplaintListCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JZMyComplaintListCellID];
    }

    self.dataModel = self.listArr[self.listArr.count - indexPath.row -1];
    
    listCell.complaintDetail.text = self.dataModel.feedbackmessage;
    
    if (self.dataModel.feedbacktype == 1) {
        
        listCell.complaintName.text = [NSString stringWithFormat:@"投诉教练：%@",self.dataModel.becomplainedname];
    }else if (self.dataModel.feedbacktype == 2){
        
        listCell.complaintName.text = [NSString stringWithFormat:@"投诉驾校：%@",[AcountManager manager].applyschool.name];

        
        
    }
    
    NSString *showTime = [self getLocalDateFormateUTCDate:self.dataModel.createtime]
    ;
    
    NSString *dayStr = [showTime substringWithRange:NSMakeRange(0,5)];;
    
    
    if ([dayStr isEqualToString:[self getNowTimes]]) {
        NSString *todayStr = [self getLocalDateFormateUTCDate:self.dataModel.createtime];
        NSString *todaytTimeStr = [todayStr substringWithRange:NSMakeRange(6, 5)];
        
        listCell.complaintTime.text = [NSString stringWithFormat:@"今天 %@",todaytTimeStr];
    }else{
        
         listCell.complaintTime.text = [self getLocalDateFormateUTCDate:self.dataModel.createtime];
        
    }
    
   
    
    
    
//    if (self.dataModel.piclist[0]) {
//        
//        [listCell.complaintFirstImg sd_setImageWithURL:[NSURL URLWithString:self.dataModel.piclist[0]] placeholderImage:[UIImage imageNamed:@"addpic"]];
//    }
//    
//    if (self.dataModel.piclist[1]) {
//        
//        [listCell.complaintSecondImg sd_setImageWithURL:[NSURL URLWithString:self.dataModel.piclist[1]] placeholderImage:[UIImage imageNamed:@"addpic"]];
//    }
    
    
    
    return listCell;
    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    
//    
//        if (self.dataModel.piclist[0]) {
//    
//            [listCell.complaintFirstImg sd_setImageWithURL:[NSURL URLWithString:self.dataModel.piclist[0]] placeholderImage:[UIImage imageNamed:@"addpic"]];
//        }
//    
//        if (self.dataModel.piclist[1]) {
//    
//            [listCell.complaintSecondImg sd_setImageWithURL:[NSURL URLWithString:self.dataModel.piclist[1]] placeholderImage:[UIImage imageNamed:@"addpic"]];
//        }

    
//}



-(void)loadData {
    

    NSString *urlString = [NSString stringWithFormat:BASEURL, @"courseinfo/getmycomplaintv2"];
    NSDictionary *paramsDict = @{@"userid": [AcountManager manager].userid};
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:paramsDict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSArray *resultData = data[@"data"];
        NSLog(@"data==%@",data);
        
        
        if ([[data objectForKey:@"type"] integerValue]) {
            
            NSArray *array = resultData;
            for (NSDictionary *dic in array) {
                JZMyComplaintData *listModel = [JZMyComplaintData yy_modelWithJSON:dic];

                
                [self.listArr addObject:listModel];
            }

            [self reloadData];
        }
        
    } withFailure:^(id data) {
        
        [self obj_showTotasViewWithMes:@"网络错误"];
        
    }];

    
}

-(NSMutableArray *)listArr {
    
    if (!_listArr) {
        
        NSMutableArray *arrM = [[NSMutableArray alloc]init];
        
        self.listArr = arrM;
    }
    
    
    
    return _listArr;
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
    [dateFormatter setDateFormat:@"MM/dd HH:mm"];
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

-(NSString *)getNowTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"MM/dd"];
    
    NSString *dateTime =[formatter stringFromDate:[NSDate date]];
    
    return dateTime;
    
}





@end
