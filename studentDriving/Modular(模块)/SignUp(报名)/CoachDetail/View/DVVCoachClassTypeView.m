//
//  DVVCoachDetailClassTypeView.m
//  studentDriving
//
//  Created by 大威 on 16/2/22.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVCoachClassTypeView.h"

#define kCellIdentifier @"kCellIdentifier"

@interface DVVCoachClassTypeView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) DVVCoachClassTypeViewBlock signUpButtonBlock;
@property (nonatomic, copy) DVVCoachClassTypeViewBlock cellDidSelectBlock;

@property (nonatomic, strong) UIButton *markButton;

@end

@implementation DVVCoachClassTypeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArray = [NSMutableArray array];
        _heightArray = [NSMutableArray array];
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.bounces = NO;
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

- (CGFloat)dynamicHeight:(NSArray *)dataArray {
    
    [_dataArray removeAllObjects];
    [_heightArray removeAllObjects];
    _totalHeight = 0;
    for (NSDictionary *dict in dataArray) {
        NSLog(@"%@", dict);
        ClassTypeDMData *dmData = [ClassTypeDMData yy_modelWithDictionary:dict];
        dmData.coachID = _coachID;
        dmData.coachName = _coachName;
        dmData.schoolinfo = [ClassTypeDMSchoolinfo new];
        dmData.schoolinfo.schoolid = _schoolID;
        dmData.schoolinfo.name = _schoolName;
        [_dataArray addObject:dmData];
    }
    for (ClassTypeDMData *dmData in _dataArray) {
        
        CGFloat height = [ClassTypeCell dynamicHeight:dmData.classdesc];
        _totalHeight += height;
        
        [_heightArray addObject:[NSString stringWithFormat:@"%f",height]];
    }
    if (_dataArray.count) {
        [self.noDataPromptView remove];
        [self reloadData];
    }else {
        [self addSubview:self.noDataPromptView];
    }
    return _totalHeight;
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_heightArray[indexPath.row] floatValue];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ClassTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[ClassTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
        [cell.signUpButton addTarget:self action:@selector(signUpButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.signUpButton.tag = indexPath.row;
    [cell refreshData:_dataArray[indexPath.row]];
    
    if (_dataArray.count == indexPath.row + 1) {
        cell.lineImageView.hidden = YES;
    }else {
        cell.lineImageView.hidden = NO;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ClassTypeDMData *dmData = _dataArray[indexPath.row];
    if (_cellDidSelectBlock) {
        _cellDidSelectBlock(dmData);
    }
}
- (void)signUpButtonAction:(UIButton *)sender {
    
    if (![AcountManager isLogin]) {
        [DVVUserManager userNeedLogin];
        return ;
    }
    
    if ([[AcountManager manager].userApplystate isEqualToString:@"0"]) {
    
        if (_signUpButtonBlock) {
            ClassTypeDMData *dmData = _dataArray[sender.tag];
            _signUpButtonBlock(dmData);
        }
        
    }else if ([[AcountManager manager].userApplystate isEqualToString:@"1"]){
        [self obj_showTotasViewWithMes:@"报名正在申请中"];
    }else if ([[AcountManager manager].userApplystate isEqualToString:@"2"]){
        [self obj_showTotasViewWithMes:@"您已经报过名"];
    }
}

- (DVVNoDataPromptView *)noDataPromptView {
    if (!_noDataPromptView) {
        _noDataPromptView = [[DVVNoDataPromptView alloc] initWithTitle:@"暂无班型信息" image:[UIImage imageNamed:@"app_error_robot"]];
        CGSize size = [UIScreen mainScreen].bounds.size;
        _noDataPromptView.frame = CGRectMake(0, 0, size.width, size.height - 64 - 44);
    }
    return _noDataPromptView;
}

#pragma mark - set block

- (void)dvvCoachClassTypeView_setSignUpButtonActionBlock:(DVVCoachClassTypeViewBlock)handle {
    _signUpButtonBlock = handle;
}

- (void)dvvCoachClassTypeView_setCellDidSelectBlock:(DVVCoachClassTypeViewBlock)handle {
    _cellDidSelectBlock = handle;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
