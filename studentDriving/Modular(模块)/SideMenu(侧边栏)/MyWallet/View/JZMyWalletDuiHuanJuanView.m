//
//  JZMyWalletDuiHuanJuanView.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZMyWalletDuiHuanJuanView.h"
#import "JZMyWalletDuiHuanJuanHeaderView.h"
#import "JZMyWalletDuiHuanJuanCell.h"
#define kLKSize [UIScreen mainScreen].bounds.size
static NSString *duiHuanJuanHeaderViewID = @"duiHuanJuanHeaderViewID";
static NSString *duiHuanJuanDetailCellID = @"duiHuanJuanDetailCellID";
@interface JZMyWalletDuiHuanJuanView ()<UITableViewDelegate,UITableViewDataSource>

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
        
        
    }
    return self;
    
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JZMyWalletDuiHuanJuanCell *duiHuanJuanCell = [tableView dequeueReusableCellWithIdentifier:duiHuanJuanDetailCellID];
    
    if (!duiHuanJuanCell) {
        
        duiHuanJuanCell = [[JZMyWalletDuiHuanJuanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:duiHuanJuanDetailCellID];
    }
    
    return duiHuanJuanCell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return 2;
    
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
    
    // 3.返回haderView
    return duiHuanJuanHeaerView;
    
    
}


///  点击兑换劵下拉视图方法
-(void)duiHuanJuanHeaerViewDidClick:(UITapGestureRecognizer *)tap {
    
}




@end
