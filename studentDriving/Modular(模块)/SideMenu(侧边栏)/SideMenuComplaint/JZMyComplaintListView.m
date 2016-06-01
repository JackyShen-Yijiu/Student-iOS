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

static NSString *JZMyComplaintCellID = @"JZMyComplaintCellID";

@interface JZMyComplaintListView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *listDataArray;

@end

@implementation JZMyComplaintListView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        
        self.dataSource = self;
        
        self.delegate = self;

        self.backgroundColor = [UIColor whiteColor];
//        self.showsVerticalScrollIndicator = NO;
//        self.showsHorizontalScrollIndicator = NO;
        
        self.separatorStyle = NO;


        [self loadData];
        
    }
    return self;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listDataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JZMyComplaintCell *listCell = [tableView dequeueReusableCellWithIdentifier:JZMyComplaintCellID];
    
    if (!listCell) {
        
        listCell = [[JZMyComplaintCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JZMyComplaintCellID];
    }

    listCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    JZMyComplaintData *dataModel = self.listDataArray[self.listDataArray.count - indexPath.row -1];
    
    NSLog(@"dataModel.piclist:%@",dataModel.piclist);
    
    listCell.data = dataModel;
    
    return listCell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JZMyComplaintData *dataModel = self.listDataArray[self.listDataArray.count - indexPath.row -1];

    return [JZMyComplaintCell cellHeightDmData:dataModel];
    
}

-(void)loadData {
    

    NSString *urlString = [NSString stringWithFormat:BASEURL, @"courseinfo/getmycomplaintv2"];
    NSDictionary *paramsDict = @{@"userid": [AcountManager manager].userid};
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:paramsDict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
       
        NSArray *resultData = data[@"data"];
       
        NSLog(@"投诉data==%@",data);
        
        if ([[data objectForKey:@"type"] integerValue]) {
            
            NSArray *array = resultData;
            for (NSDictionary *dic in array) {
                
                JZMyComplaintData *listModel = [JZMyComplaintData yy_modelWithJSON:dic];

                [self.listDataArray addObject:listModel];
            }

            [self reloadData];
        }
        
    } withFailure:^(id data) {
        
        [self obj_showTotasViewWithMes:@"网络错误"];
        
    }];

    
}

-(NSMutableArray *)listDataArray {
    
    if (!_listDataArray) {
        
        _listDataArray = [[NSMutableArray alloc]init];
    }
    
    return _listDataArray;
}

@end
