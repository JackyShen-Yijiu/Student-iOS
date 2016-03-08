//
//  APWaitEvaluationViewController.m
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "APWaitEvaluationViewController.h"
#import "ToolHeader.h"
#import "UIDevice+JEsystemVersion.h"
#import "WaitConfirmCell.h"
#import "APCommentViewController.h"
#import "MyAppointmentModel.h"
#import "ComplainViewController.h"
#import "ChatViewController.h"

@interface APWaitEvaluationViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UIButton *itemMessege;
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIButton *complaintsBtn;
@property (strong, nonatomic) UIButton *commentBtn;

@property (strong, nonatomic) UIImageView *coachImageView;
@property (strong, nonatomic) UILabel *coachName;
@property (strong, nonatomic) UILabel *drivingAddress;

@end

@implementation APWaitEvaluationViewController

- (UIButton *)complaintsBtn {
    if (_complaintsBtn == nil) {
        _complaintsBtn = [WMUITool initWithTitle:@"投诉" withTitleColor:[UIColor whiteColor] withTitleFont:[UIFont systemFontOfSize:16]];
        _complaintsBtn.backgroundColor = MAINCOLOR;
        [_complaintsBtn addTarget:self action:@selector(clickComplaint:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _complaintsBtn;
}
- (UIButton *)commentBtn {
    if (_commentBtn == nil) {
        _commentBtn = [WMUITool initWithTitle:@"评论" withTitleColor:MAINCOLOR withTitleFont:[UIFont systemFontOfSize:16]];
        _commentBtn.backgroundColor = [UIColor whiteColor];
//        _commentBtn.backgroundColor = RGBColor(32, 230, 111);
        _commentBtn.layer.borderColor = (MAINCOLOR).CGColor;
        _commentBtn.layer.borderWidth = 1.0f;
        [_commentBtn addTarget:self action:@selector(clickComment:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentBtn;
}


- (UIButton *)itemMessege {
    if (_itemMessege == nil) {
        _itemMessege = [UIButton buttonWithType:UIButtonTypeCustom];
        [_itemMessege setBackgroundImage:[UIImage imageNamed:@"聊天.png"] forState:UIControlStateNormal];
        _itemMessege.frame = CGRectMake(0, 0, 18, 17);
        [_itemMessege addTarget:self action:@selector(dealMessage:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _itemMessege;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BACKGROUNDCOLOR;
    }
    return _tableView;
}
- (UILabel *)coachName {
    if (_coachName == nil) {
        _coachName = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:16]];
        _coachName.text = @"李教练";
    }
    return _coachName;
}
- (UILabel *)drivingAddress {
    if (_drivingAddress == nil) {
        _drivingAddress = [WMUITool initWithTextColor:TEXTGRAYCOLOR withFont:[UIFont systemFontOfSize:14]];
        _drivingAddress.text = @"北京市海淀区中关村驾校";
    }
    return _drivingAddress;
}
- (UIImageView *)coachImageView{
    if (_coachImageView == nil) {
        _coachImageView = [[UIImageView alloc] init];
        _coachImageView.backgroundColor = MAINCOLOR;
         [_coachImageView sd_setImageWithURL:[NSURL URLWithString:self.model.coachid.headportrait.originalpic]placeholderImage:[UIImage imageNamed:@"littleImage.png"]];
    }
    return _coachImageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = @"科目二训练";
    switch ([self.markNum integerValue]) {
        case 2:
            self.title = @"科目二预约详情";
            break;
        case 3:
            self.title = @"科目三预约详情";
            break;
            
        default:
            break;
    }

    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([UIDevice jeSystemVersion] >= 7.0f) {
        //当你的容器是navigation controller时，默认的布局将从navigation bar的顶部开始。这就是为什么所有的UI元素都往上漂移了44pt
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [self tableViewFootView];
    self.tableView.tableHeaderView = [self tableViewHeadView];

    
    [self conformNavItem];
}

- (void)dealMessage:(UIButton *)sender {
    ChatViewController *chat = [[ChatViewController alloc] initWithChatter:self.model.coachid.infoId  conversationType:eConversationTypeChat];
    chat.title = self.model.coachid.name;
    NSDictionary * extParam = @{@"headUrl":self.model.coachid.headportrait.originalpic,@"nickName":self.model.coachid.name,@"userId":self.model.coachid.infoId,@"userType":@"2"};
    chat.conversation.ext = extParam;
    [self.navigationController pushViewController:chat animated:YES];
}

- (void)conformNavItem {
    UIBarButtonItem *navMessegeItem = [[UIBarButtonItem alloc] initWithCustomView:self.itemMessege];
//    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    spaceItem.width = -15;
    self.navigationItem.rightBarButtonItem = navMessegeItem;
}

- (UIView *)tableViewHeadView {
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 90)];
    backGroundView.backgroundColor = [UIColor whiteColor];
    
    [backGroundView addSubview:self.coachImageView];
    
    [self.coachImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(backGroundView.mas_top).offset(15);
        make.height.mas_equalTo(@60);
        make.width.mas_equalTo(@60);
        
    }];
    
    [backGroundView addSubview:self.coachName];
    [self.coachName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coachImageView.mas_right).offset(10);
        make.top.mas_equalTo(self.coachImageView.mas_top).offset(5);
    }];
    self.coachName.text = self.model.coachid.name;
    
    [backGroundView addSubview:self.drivingAddress];
    
    [self.drivingAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coachImageView.mas_right).offset(10);
        make.top.mas_equalTo(self.coachName.mas_bottom).offset(10);
    }];
    self.drivingAddress.text = self.model.coachid.driveschoolinfo.name;
    return backGroundView;
}

- (UIView *)tableViewFootView {
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 50)];
    backGroundView.backgroundColor = [UIColor whiteColor];
    [backGroundView addSubview:self.complaintsBtn];
    [backGroundView addSubview:self.commentBtn];
    [self.complaintsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backGroundView.mas_centerY);
        make.left.mas_equalTo(backGroundView.mas_left).offset(15);
        NSNumber *wide = [NSNumber numberWithFloat:(kSystemWide-30-14)/2];
        make.width.mas_equalTo(wide);
        make.height.mas_equalTo(@45);
    }];
    
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backGroundView.mas_centerY);
        make.left.mas_equalTo(self.complaintsBtn.mas_right).offset(14);
        make.right.mas_equalTo(backGroundView.mas_right).offset(-15);
        make.height.mas_equalTo(@45);
    }];
    
    return backGroundView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";

    WaitConfirmCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[WaitConfirmCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.courseProgress.text = self.model.courseprocessdesc;
    cell.courseLocation.text = [NSString stringWithFormat:@"接送地点:%@",self.model.shuttleaddress] ;
    cell.courseTime.text = self.model.classdatetimedesc;
    return cell;
}
#pragma mark - Action
- (void)clickComplaint:(UIButton *)sender {
    ComplainViewController *complain = [[ComplainViewController alloc] init];
    complain.isForceComment = self.isForceComment;
    complain.model = self.model;
    [self.navigationController pushViewController:complain animated:YES];
    
}
- (void)clickComment:(UIButton *)sender {
    APCommentViewController *comment = [[APCommentViewController alloc] init];
    comment.model = self.model;
    comment.isForceComment = self.isForceComment;
    [self.navigationController pushViewController:comment animated:YES];
}

@end
