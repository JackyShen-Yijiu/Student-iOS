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
#import "SignUpSuccessViewController.h"
#import "FavouriteViewController.h"
#import "MySaveViewController.h"



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
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(iconImage) name:kiconImage object:nil];
    
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
#pragma mark --- 头像改变的通知
- (void)iconImage{
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
 
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (4 == indexPath.row || 5 == indexPath.row) {
        return 60;
    }
    
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
        NSString *EditorcellID = @"EditorID";
        EditorBottomCell *editorCell = [tableView dequeueReusableCellWithIdentifier:EditorcellID];
        if (!editorCell) {
            editorCell = [[EditorBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:EditorcellID];
        }
        editorCell.titleLabel.text = self.titleArray[indexPath.row];
        return editorCell;
        
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
        MySaveViewController *favouriteVC = [[MySaveViewController alloc] init];
        [self.navigationController pushViewController:favouriteVC animated:YES];
    }
    if (5 == indexPath.row) {
        // 报名详情
        if ([[[AcountManager manager] userApplystate] isEqualToString:@"1"]) {
            [self.navigationController pushViewController:[SignUpSuccessViewController new] animated:YES];
        }else if ([[[AcountManager manager] userApplystate] isEqualToString:@"0"])
        {
//            DrivingViewController *signUPVC = [DrivingViewController new];
//            [self.navigationController pushViewController:signUPVC animated:YES];
            [self obj_showTotasViewWithMes:@"您还未报名!"];
        }else if ([[[AcountManager manager] userApplystate] isEqualToString:@"3"]) {
            [self showTotasViewWithMes:@"验证报名中"];
        }else if ([[[AcountManager manager] userApplystate] isEqualToString:@"2"]) {
            [self obj_showTotasViewWithMes:@"您已经报过名!"];
        }else{
            [self showTotasViewWithMes:@"您去支付完成的订单!"];
        }

    }
}

@end
