//
//  JZMyComplaintListView.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZMyComplaintListView.h"
#import "JZMyComplaintData.h"
//#import "JZMyComplaintListCell.h"
#import <YYModel.h>
#import "JZMyComplaintCell.h"

static NSString *JZMyComplaintCellID = @"JZMyComplaintCell";
@interface JZMyComplaintListView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *listArr;




@end
@implementation JZMyComplaintListView


-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        
        self.dataSource = self;
        
        self.delegate = self;
        
//        self.rowHeight = 200;
        self.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
//        self.rowHeight = UITableViewAutomaticDimension;
//        self.estimatedRowHeight = 200;
        
        [self loadData];
        
    }
    return self;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.listArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JZMyComplaintCell *listCell = [tableView dequeueReusableCellWithIdentifier:JZMyComplaintCellID];
    
    if (!listCell) {
        
        listCell = [[JZMyComplaintCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JZMyComplaintCellID];
    }

    listCell.selectionStyle = UITableViewCellSelectionStyleNone;
    JZMyComplaintData *dataModel = self.listArr[self.listArr.count - indexPath.row -1];
    
    listCell.complaintDetail.text = dataModel.feedbackmessage;
    
    if (dataModel.feedbacktype == 1) {
        
        listCell.complaintName.text = [NSString stringWithFormat:@"投诉教练：%@",dataModel.becomplainedname];
    }else if (dataModel.feedbacktype == 2){
        
        listCell.complaintName.text = [NSString stringWithFormat:@"投诉驾校：%@",[AcountManager manager].applyschool.name];

        
    }
    
    NSString *showTime = [self getLocalDateFormateUTCDate:dataModel.createtime]
    ;
    
    NSString *dayStr = [showTime substringWithRange:NSMakeRange(0,5)];;
    
    
    if ([dayStr isEqualToString:[self getNowTimes]]) {
        NSString *todayStr = [self getLocalDateFormateUTCDate:dataModel.createtime];
        NSString *todaytTimeStr = [todayStr substringWithRange:NSMakeRange(6, 5)];
        
        listCell.complaintTime.text = [NSString stringWithFormat:@"今天 %@",todaytTimeStr];
    }else{
        
         listCell.complaintTime.text = [self getLocalDateFormateUTCDate:dataModel.createtime];
        
    }
    
   
    listCell.complaintDetail.numberOfLines = 0;
    
    
//    NSNumber *datailTextHight = [NSNumber numberWithFloat:[self getLabelWidthWithString:dataModel.feedbackmessage ]];
    
//    [listCell.complaintDetail sizeToFit];
    
    
    ///  没有照片
    if (dataModel.piclist.count == 0) {
        
        [listCell.complaintDetail mas_remakeConstraints:^(MASConstraintMaker *make) {
           
            make.height.equalTo([NSNumber numberWithFloat:dataModel.datailLabelH]);

            
        }];
        
        
        listCell.complaintFirstImg.hidden = YES;
        listCell.complaintSecondImg.hidden = YES;

        
        
        [self layoutIfNeeded];
        
    }
    
    if (dataModel.piclist.count == 1) {
        
        [listCell.complaintFirstImg sd_setImageWithURL:[NSURL URLWithString:dataModel.piclist[0]]];
        
        
        [listCell.complaintFirstImg mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(@72);
            make.height.equalTo(@72);
            make.top.equalTo(listCell.complaintDetail.mas_bottom).offset(10);
            make.bottom.equalTo(listCell.contentView.mas_bottom).offset(-16);
            make.left.equalTo(listCell.contentView.mas_left).offset(16);
            
            
        }];
        
        [self layoutIfNeeded];

        
    }
    ///  两张照片
    if (dataModel.piclist.count == 2) {
        [listCell.complaintFirstImg sd_setImageWithURL:[NSURL URLWithString:dataModel.piclist[0]]];

        [listCell.complaintSecondImg sd_setImageWithURL:[NSURL URLWithString:dataModel.piclist[1]]];
        
        [listCell.complaintFirstImg mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            
            make.top.equalTo(listCell.complaintDetail.mas_bottom).offset(10);
            make.width.equalTo(@72);
            make.height.equalTo(@72);
            make.bottom.equalTo(listCell.contentView.mas_bottom).offset(-16);
            make.left.equalTo(listCell.contentView.mas_left).offset(16);
            
            
        }];

        
        [listCell.complaintSecondImg mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            
            make.top.equalTo(listCell.complaintDetail.mas_bottom).offset(10);
            make.width.equalTo(@72);
            make.height.equalTo(@72);
            make.bottom.equalTo(listCell.contentView.mas_bottom).offset(-16);
            make.left.equalTo(listCell.complaintFirstImg.mas_right).offset(10);
            
            
        }];
        
        [self layoutIfNeeded];
        
        
        
    }
    
    return listCell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    

    JZMyComplaintData *dataModel = self.listArr[self.listArr.count - indexPath.row -1];
    
    if (!dataModel.piclist.count) {
        
        dataModel.imageViewH = 0;
    }else {
        
        dataModel.imageViewH = 72 +10;
    };
    

    dataModel.datailLabelH = [self getLabelWidthWithString:dataModel.feedbackmessage ];
    
    return 16 + 14 +10 +  dataModel.datailLabelH + dataModel.imageViewH + 16;
    
}

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

#pragma mark - 分割线两侧置顶
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
#pragma mark - 获取当前时间
-(NSString *)getNowTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"MM/dd"];
    
    NSString *dateTime =[formatter stringFromDate:[NSDate date]];
    
    return dateTime;
    
}

- (CGFloat )getLabelWidthWithString:(NSString *)string {
    CGRect bounds = [string boundingRectWithSize:
                     CGSizeMake([[UIScreen mainScreen] bounds].size.width - 32, 10000) options:
                     NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]} context:nil];
    return bounds.size.height;
}





@end
