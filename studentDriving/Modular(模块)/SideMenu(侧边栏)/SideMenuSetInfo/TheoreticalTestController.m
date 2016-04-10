//
//  TheoreticalTestController.m
//  studentDriving
//
//  Created by ytzhang on 16/2/29.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "TheoreticalTestController.h"
@interface TheoreticalTestController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, strong) UIImageView *imgHeardView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *desArray;

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *addressLabel;


@end

@implementation TheoreticalTestController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"理论考试";
    self.view.backgroundColor = [UIColor whiteColor];
    //头部视图
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.imgHeardView;
    // 尾部视图
    [self.bgView addSubview:self.phoneLabel];
    [self.bgView addSubview:self.addressLabel];
//    self.tableView.tableFooterView = self.bgView;
    
    [self initData];
    
}
- (void)initData{
    self.titleArray = @[@"科目一",@"科目四"];
    self.desArray = @[@"  科目一，又称科目一理论考试，驾驶员理论考试，是机动车驾驶证考核的一部分。考试内容包括驾车理论基础和道路安全法律法规及相关知识，再加地方性法规。\n  科目一考试总时间为45分钟，考试试卷由100道题目组成，体型为判断题和单项选择题，满分100分，90分合格。考试试卷由计算机驾驶人考试系统按照《机动车驾驶证工作规范》规定的比例关系随机抽取，结合。\n  很多学员在面对科目一交规题都是死记硬背下来，但对于喝多试卷紧张的学员来说，这个办法就行不通了，接下来和大家分享一些科目一考试的技巧，大家只要掌握了下面的这些技巧，考试时调整好心态，使自己尽力不要紧张，考试就一定没有文体路。\n  1、有关公里的题目：城市街道选50公里，其余有30的全选30。\n  2、有不得停车的选择不得停车。\n  3、危险知识：题目里找不需要 不受 可以 三层 坚固无损 是错的，其余都是对的。\n  4、高速公路有关不允许的行为规定的选择题：选带不准、不得的答案。\n  5、判断题：只有远心端和软质担架是错的，其余都是对的。\n  6、判断题：带不得、不准的都是对的;凡带可以、可、允许都是的。\n  7、吊销机动车证的为二年，撤消机动车证的为三年，以醉酒吊销五年，因逃跑而吊销是终身，叫吊二撤三醉五逃终身 \n  8、机动车未...可以上道路行驶的判断题都是错的;专业维修企业可以...的判断题都是错的;(经)运输企业(批准)可以...的判断题都是错的。\n  9、机动车驶入驶出非机动车道/通过铁路道口/急转弯/转弯/窄路/窄桥/掉头/下陡坡/牵引故障机动车/最高时速不准超过(30公里)。\n  10、发生交通事故都是民事责任，出现刑事的都不。\n  11、公安交管部门都是吊销，撤销.交警是扣。\n  12、有横/侧风的就紧握方向盘",
                      @"  科目四，又称科目四理论考试，驾驶员理论考试，是机动车驾驶证考核的一部分。考试内容包括驾车理论基础和道路安全法律法规及相关知识，再加地方性法规。\n  科目一考试总时间为45分钟，考试试卷由100道题目组成，体型为判断题和单项选择题，满分100分，90分合格。考试试卷由计算机驾驶人考试系统按照《机动车驾驶证工作规范》规定的比例关系随机抽取，结合"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.row) {
        return 450;
    }
    if (1 == indexPath.row) {
        return 150;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = @"DetailID";
    DuideDetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!detailCell) {
        detailCell = [[DuideDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    detailCell.backgroundColor = [UIColor clearColor];
    detailCell.titleLabel.text = self.titleArray[indexPath.row];
    detailCell.deTextView.text = self.desArray[indexPath.row];
    detailCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return detailCell;
}
#pragma mark ----- Lazy加载
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGBColor(249, 249, 249);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (UIImageView *)imgHeardView{
    if (_imgHeardView == nil) {
        _imgHeardView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 150)];
        _imgHeardView.image = [UIImage imageNamed:@"Help_DetailHeader"];
    }
    return _imgHeardView;
}
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 50)];
        _bgView.backgroundColor = [UIColor clearColor];
    }
    return _bgView;
}
- (UILabel *)phoneLabel{
    if (_phoneLabel == nil) {
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 14)];
        _phoneLabel.text = @"客服电话:400-101-6669";
        _phoneLabel.font = [UIFont systemFontOfSize:14];
        _phoneLabel.textColor = [UIColor colorWithHexString:@"212121"];
        
    }
    return _phoneLabel;
}
- (UILabel *)addressLabel{
    if (_addressLabel == nil) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 19, 270, 14)];
        _addressLabel.text = @"地址:北京市海淀区中关村E世界财富广场";
        _addressLabel.font = [UIFont systemFontOfSize:14];
        _addressLabel.textColor = [UIColor colorWithHexString:@"212121"];
        
    }
    return _addressLabel;
}

@end
