//
//  SchoolClassDetailController.m
//  studentDriving
//
//  Created by ytzhang on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "SchoolClassDetailController.h"
#import "SchoolClassDetailMessageCell.h"
#import "SchoolClassDetailDisCell.h"

@interface SchoolClassDetailController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tabelView;
//@property (nonatomic, strong) 

@end

@implementation SchoolClassDetailController
- (void)viewDidLoad{
    self.title = @"班型详情";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    self.tabelView.dataSource = self;
    self.tabelView.delegate = self;
    [self.view addSubview:self.tabelView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.row) {
            SchoolClassDetailMessageCell *cell = (SchoolClassDetailMessageCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return [cell heightWithcell:self.classTypeDMData];
    }else if (1 == indexPath.row){
        SchoolClassDetailDisCell *cell = (SchoolClassDetailDisCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return [cell heightWithcell:self.classTypeDMData];
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 250;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.row) {
        NSString *cellID = @"cellID";
        SchoolClassDetailMessageCell *messageCell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!messageCell) {
            messageCell = [[SchoolClassDetailMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        messageCell.classTypeModel = self.classTypeDMData;
        return messageCell;
    }else if(1 == indexPath.row){
        NSString *ID = @"ID";
        SchoolClassDetailDisCell  *disCell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!disCell) {
            disCell = [[SchoolClassDetailDisCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        disCell.classTypeModel = self.classTypeDMData;
        return disCell;
    }
    return nil;
    
}
- (UITableView *)tabelView{
    if (_tabelView == nil) {
        _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight) style:UITableViewStylePlain];
        _tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tabelView;
}
@end
