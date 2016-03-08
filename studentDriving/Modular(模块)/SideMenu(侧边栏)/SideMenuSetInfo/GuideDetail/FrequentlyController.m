//
//  FrequentlyController.m
//  studentDriving
//
//  Created by ytzhang on 16/2/29.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "FrequentlyController.h"
#import "DuideDetailCell.h"

@interface FrequentlyController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, strong) UIImageView *imgHeardView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *desArray;

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *addressLabel;


@end

@implementation FrequentlyController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"常见问题";
    self.view.backgroundColor = [UIColor whiteColor];
    //头部视图
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.imgHeardView;
    // 尾部视图
//    [self.bgView addSubview:self.phoneLabel];
    [self.bgView addSubview:self.addressLabel];
    self.tableView.tableFooterView = self.bgView;
    
    [self initData];
    
}
- (void)initData{
    self.titleArray = @[@"1.教练教学是一对一，还是一对多？",@"2.如何报名",@"3.“极致驾服”的训练场在哪？",@"4.在“极致驾服”上报考的班型一般需要多久可以拿本？",@"5.通过“极致驾服”考驾照的基本流程是什么？",@"6.教练是怎么选择的，教学经验怎么样？",@"7.学习车辆是什么样的？",@"8.如果临时有事无法参加考试，是否可以延期？",@"9.报名以后多久开始学车？",@"10.是否包过，如果考试不过怎么收费？"];
    self.desArray = @[@"  “极致驾服”以学员满意拿本为宗旨，严格保证学员学车质量，执行“一对一教学”，也会因为部分城市差异出现不同。",
                      @"  1．APP线上报名：下载极致驾服APP，注册信息并选择驾校或教练的班型进行报名，选择线上报名的方式，通过支付宝或微信线上支付报名费；支付成功后至驾校进行信息采集。\n  2．APP线下报名：下载一部学车APP，注册信息并选择驾校或教练的班型进行报名，选择线下报名的方式，成功提交后系统将为您生成报名二维码，在截止时间内至驾校支付报名费并进行信息采集。\n  报名资料\n  1.	证件：身份证原件、暂住证（本地学员无需暂住证）\n  2.	照片：8张白底一寸证件照\n  3.	医院体检证明一份（照片需与如上照片一致)\n  联系电话官方电话：\n  400-626-9255",
                      @"  目前“极致驾服”已开放全北京地域的学车报名，北京各个区都有深度合作的”优质驾校“和“金牌教练”为其提供服务，全部由班车接送，交通方便。",
                      @"  看约车速度与个人练车安排。通常情况下，按照北京车管所的要求，2至3个月即可顺利拿本，部分班型拿本周期可缩短至45天左右。",
                      @"  1）在“极致驾服”咨询并报名；\n （2）“学车管家”协助学员完成学车前准备，包含“照片，体检表，身份证…”等材料.\n （3）学员开始参与驾考培训以后，学车管家全程跟踪学员学车进度，及时处理学员在学车过程中出现的常见问题及投诉的处理，帮助学员快速拿本。",
                      
                      @"  极致驾服服务方为区域内龙头优质驾校进行深度合作参与培训的教练全部是有十年以上教学经验且服务素质高的金牌教练保证学员能够快速学成拿本",
                      
                      @"  教学车辆全部是符合“北京市车管所”要求的专业教练车，操作简单，乘坐舒适。",
                      @"  可以的，只需提前告诉教练，并到驾校信息大厅进行改期即可。",
                      @"  一般情况下，在报名后建立档案后1至2周内会有驾校的工作人员安排科目一法培课及考试相关事宜。",
                      @"  包过是指收费从一而终一次收费的意思，  “极致驾服”目前推出的“春节包过班型”就是这样的，学车过程中产生的所以补考费用全部由”极致驾服“承担；而”极致驾服“的”猴年专享班型“是不提供包过服务的，对于学车过程中的补考费用，需由学员自行承担。保障班型为驾校班型，价格与驾校统一，额外由极致为其做服务保障。"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.row) {
        return 70;
    }
    if (1 == indexPath.row) {
        return 200;
    }
    if (2 == indexPath.row) {
        return 80;
    }
    if (3 == indexPath.row) {
        return 80;
    }
    if (4 == indexPath.row) {
        return 100;
    }
    if (5 == indexPath.row) {
        return 80;
    }
    if (6 == indexPath.row) {
        return 80;
    }
    if (7 == indexPath.row) {
        return 80;
    }
    if (8 == indexPath.row) {
        return 80;
    }
    if (9 == indexPath.row) {
        return 120;
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
        _phoneLabel.text = @"客服电话:400-626-9255";
        _phoneLabel.font = [UIFont systemFontOfSize:14];
        _phoneLabel.textColor = [UIColor colorWithHexString:@"212121"];
        
    }
    return _phoneLabel;
}
- (UILabel *)addressLabel{
    if (_addressLabel == nil) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 19, 270, 14)];
        _addressLabel.text = @"更多信息请拨打热线电话:400-626-9255";
        _addressLabel.font = [UIFont systemFontOfSize:14];
        _addressLabel.textColor = [UIColor colorWithHexString:@"212121"];
        
    }
    return _addressLabel;
}

@end
