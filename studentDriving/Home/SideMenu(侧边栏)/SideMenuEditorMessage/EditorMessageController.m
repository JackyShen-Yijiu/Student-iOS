//
//  EditorMessageController.m
//  studentDriving
//
//  Created by zyt on 16/2/23.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "EditorMessageController.h"
#import "EditorMessageCell.h"
#import "EditorBottomCell.h"
#import "EditorTopCell.h"
#import "EditorDetailController.h"



@interface EditorMessageController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *descriArray;

@end

@implementation EditorMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"个人中心";
    [self initData];
    
}
- (void)initData{
    self.titleArray = @[@"",@"报考驾校",@"报考班型",@"报考车型",@"我的喜欢",@"报名详情"];
    if ([[AcountManager manager].userApplystate isEqualToString:@"0"] || [[AcountManager manager].userApplystate isEqualToString:@"1"]) {
        self.descriArray = @[@"",@"尚未报名",@"尚未报名",@"尚未报名"];
    }
    if ([[AcountManager manager].userApplystate isEqualToString:@"2"]) {
        self.descriArray = @[@"",[AcountManager manager].applyschool.name,[AcountManager manager].applyclasstype.name,[AcountManager manager].userCarmodels.name];
    }
    
    /*
     @property (readonly,strong, nonatomic) ApplyclasstypeinfoModel *applyclasstype;
     @property (readonly,strong, nonatomic) ApplycoachinfoModel *applycoach;
     @property (readonly,strong, nonatomic) ApplyschoolinfoModel *applyschool;
     @property (readonly,strong, nonatomic) ExamCarModel *userCarmodels;
     */

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (0 == indexPath.row) {
        NSString *cellID = @"TopID";
        EditorTopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[EditorTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (1 == indexPath.row || 2 == indexPath.row || 3 == indexPath.row) {
        NSString *cellID = @"signUpID";
        EditorMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[EditorMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = self.titleArray[indexPath.row];
        cell.describeLabel.text = self.descriArray[indexPath.row];
        return cell;

    }
    if (4 == indexPath.row || 5 == indexPath.row) {
        NSString *cellID = @"EditorID";
        EditorBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[EditorBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.titleLabel.text = self.titleArray[indexPath.row];
        return cell;
        
    }
    return nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return _tableView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.row) {
        // 头像编辑
        EditorDetailController *editorVC = [[EditorDetailController alloc] init];
        [self.navigationController pushViewController:editorVC animated:YES];
                                            //        [JEPhotoPickManger pickPhotofromController:self];
    }
    if (4 == indexPath.row) {
        // 我的喜欢
    }
    if (5 == indexPath.row) {
        // 报名详情
    }
}

@end
