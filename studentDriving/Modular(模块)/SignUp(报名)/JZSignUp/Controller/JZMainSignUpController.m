//
//  JZMainSignUpController.m
//  studentDriving
//
//  Created by ytzhang on 16/3/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZMainSignUpController.h"
#import "JZSignUpCell.h"
#import "JZSignUpTopCell.h"
#import "JZShowTitleCell.h"
#import "JZSignUpFooterView.h"

@interface JZMainSignUpController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isShowTitle; // 是否显示班型详细信息

@property (nonatomic, strong) UIButton *commitButton;

@property (nonatomic, strong) JZSignUpFooterView *footerView;

@property (nonatomic, strong) NSArray *topTitleArray;

@property (nonatomic, strong) NSArray *bottonTitleArray;

@property (nonatomic, strong) NSArray *topDesArray;

@property (nonatomic, strong) NSArray *bottonDesArray;


@end

@implementation JZMainSignUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"报名信息";

    self.view.backgroundColor = RGBColor(226, 226, 233);
    self.tableView.tableFooterView = self.footerView;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.commitButton];
    [self initData];
    
}
- (void)initData{
    self.topTitleArray = @[@"报考驾校",@"报考教练",@"班级类型"];
    self.topDesArray = @[@"报考驾校",@"报考教练",@"班级类型"];
    
    self.bottonTitleArray = @[@"您的姓名",@"电话号码",@"Y返现"];
    self.bottonDesArray = @[@"请填写您的真实姓名",@"请填写您的真实号码",@"请选择一张您所领取的Y码"];

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isShowTitle)
    {
        if (0 == indexPath.section)
        {
            if (3 == indexPath.row)
            {
                return 100;
            }else{
                return 44;
            }

        } if (1 == indexPath.section) {
            return 44;
        }
    
    }else if (!_isShowTitle) {
        return 44;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isShowTitle) {
        if (0 == section) {
            return 4;
        }else if( 1 == section){
            return 3;
        }
    }else if (!_isShowTitle) {
        return 3;
    }
        return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (1 == section) {
        return 20;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if (_isShowTitle) {
        // 加载展示班型描述的Cell
        if (0 == indexPath.section) {
            if (3 == indexPath.row) {
                // 展现班型文字描述
                NSString *ID = @"desCell";
                JZShowTitleCell *showTitleCell  = [tableView dequeueReusableCellWithIdentifier:ID];
                if (!showTitleCell) {
                    showTitleCell = [[JZShowTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
                }
                return showTitleCell;
            }else{
                NSString *topCellID = @"topCell";
                JZSignUpTopCell *signUpTopCell  = [tableView dequeueReusableCellWithIdentifier:topCellID];
                if (!signUpTopCell) {
                    signUpTopCell = [[JZSignUpTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topCellID];
                }
                signUpTopCell.titleLabel.text = self.topTitleArray[indexPath.row];
                signUpTopCell.rightLabel.text = self.topDesArray[indexPath.row];
                return signUpTopCell;
            }
            
        }else if(1 == indexPath.section){
            NSString *cellID = @"cellID";
            JZSignUpCell *signUpCell  = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!signUpCell) {
                signUpCell = [[JZSignUpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            signUpCell.titleLabel.text = self.bottonTitleArray[indexPath.row];
            signUpCell.desTextFiled.placeholder = self.bottonDesArray[indexPath.row];
            return signUpCell;
        }
        
    } else if (!_isShowTitle){
       //  加载不展示班型描述的Cell
        if (0 == indexPath.section) {
            
                NSString *topCellID = @"topCell";
                JZSignUpTopCell *signUpTopCell  = [tableView dequeueReusableCellWithIdentifier:topCellID];
                if (!signUpTopCell) {
                    signUpTopCell = [[JZSignUpTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topCellID];
                }
            signUpTopCell.titleLabel.text = self.topTitleArray[indexPath.row];
            signUpTopCell.rightLabel.text = self.topDesArray[indexPath.row];
                return signUpTopCell;
            
        }else if(1 == indexPath.section){
            NSString *cellID = @"cellID";
            JZSignUpCell *signUpCell  = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!signUpCell) {
                signUpCell = [[JZSignUpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            signUpCell.titleLabel.text = self.bottonTitleArray[indexPath.row];
            signUpCell.desTextFiled.placeholder = self.bottonDesArray[indexPath.row];
            return signUpCell;
        }

    }
    
   
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        if (2 == indexPath.row) {
            if (_isShowTitle) {
                _isShowTitle = NO;
                [self.tableView reloadData];
            }else if(!_isShowTitle){
                _isShowTitle = YES;
                [self.tableView reloadData];
            }
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
#pragma mark ----- UIButton Action
- (void)didCommit:(UIButton *)btn{
    // 提交的点击事件
}
#pragma mark ---- Lazy 加载
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight - 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource  = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
- (JZSignUpFooterView *)footerView{
    if (_footerView == nil) {
        _footerView = [[ JZSignUpFooterView alloc] init];
    }
    return _footerView;
}
- (UIButton *)commitButton{
    if (_commitButton == nil) {
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitButton.backgroundColor = YBNavigationBarBgColor;
        CGFloat margin = 18;
        _commitButton.frame = CGRectMake(margin, kSystemHeight - 44 - 64, kSystemWide - 2 * margin, 44);
        _commitButton.layer.cornerRadius = 5;
        _commitButton.layer.masksToBounds = YES;
        [_commitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(didCommit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitButton;
}
@end
