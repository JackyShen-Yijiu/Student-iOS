//
//  APCommentViewController.m
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "APCommentViewController.h"
#import "UIDevice+JEsystemVersion.h"
#import "CommentCell.h"
#import "MyAppointmentModel.h"
#import "BCTextView.h"
#import "AppointmentViewController.h"

static NSString *const kuserCommentAppointment = @"courseinfo/usercomment";

@interface APCommentViewController ()<UITableViewDataSource,UITableViewDelegate,CommentCellDelegate,UITextViewDelegate>{
    BCTextView *bctextView;
    NSArray *commentTitleArray;
}
@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) CGFloat starProgress;
@property (assign, nonatomic) CGFloat attitudelevel;
@property (assign, nonatomic) CGFloat timelevel;
@property (assign, nonatomic) CGFloat abilitylevel;

@property (strong, nonatomic) UIButton *submitBtn;
@end

@implementation APCommentViewController

- (UIButton *)submitBtn {
    if (_submitBtn == nil) {
        _submitBtn = [WMUITool initWithTitle:@"提交" withTitleColor:[UIColor whiteColor] withTitleFont:[UIFont systemFontOfSize:16]];
        _submitBtn.backgroundColor = MAINCOLOR;
        [_submitBtn addTarget:self action:@selector(clickSubmit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    commentTitleArray = @[@"总体评价",@"守时",@"态度",@"能力"];
    // 默认4颗星
    _starProgress = 4;
    _attitudelevel = 4;
    _timelevel = 4;
    _abilitylevel = 4;

    bctextView.text = @"";
    self.title = @"评论";
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([UIDevice jeSystemVersion] >= 7.0f) {
        //当你的容器是navigation controller时，默认的布局将从navigation bar的顶部开始。这就是为什么所有的UI元素都往上漂移了44pt
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [self tableViewFootView];
}
- (void)clickSubmit:(UIButton *)sender {
    
    NSString *urlString = [NSString stringWithFormat:BASEURL,kuserCommentAppointment];
    
    NSDictionary *param = @{@"userid":[AcountManager manager].userid,
                            @"reservationid":self.model.infoId,
                            @"starlevel":[NSString stringWithFormat:@"%f",self.starProgress],
                            @"abilitylevel":[NSString stringWithFormat:@"%f",self.abilitylevel],
                            @"timelevel":[NSString stringWithFormat:@"%f",self.timelevel],
                            @"attitudelevel":[NSString stringWithFormat:@"%f",self.attitudelevel],
                            @"commentcontent":bctextView.text};
    [JENetwoking startDownLoadWithUrl:urlString postParam:param WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        DYNSLog(@"data = %@",data);
        NSDictionary *param = data;
        NSNumber *type = param[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@", param[@"msg"]];
        if (type.integerValue == 1) {
            kShowSuccess(@"评论成功");
           
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[AppointmentViewController class]]) {
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }
            
            
        }else {
            kShowFail(msg);
        }
    }];
}

- (UIView *)tableViewFootView {
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 80)];
    [backGroundView addSubview:self.submitBtn];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(backGroundView.mas_top).offset(15);
        make.right.mas_equalTo(backGroundView.mas_right).offset(-15);
        make.height.mas_equalTo(@45);
    }];
    
    return backGroundView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = BACKGROUNDCOLOR;
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 79;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *cellId = @"cellOne";
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
        }
        cell.topLabel.text = commentTitleArray[indexPath.row];
        [cell receiveIndex:indexPath];
        [cell.starBar displayRating:4];
        return cell;

    }else if (indexPath.section == 1) {
        static NSString *cellId = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            bctextView = [[BCTextView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 79) withPlaceholder:@"写点评论吧,对其他伙伴有帮助"];
            bctextView.delegate = self;
            bctextView.font = [UIFont systemFontOfSize:16];
            bctextView.returnKeyType = UIReturnKeyDone;
            [cell.contentView addSubview:bctextView];
        }
        return cell;
    }
    return nil;
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    BCTextView *bcTextView = (BCTextView *)textView;
    bcTextView.placeholder.hidden = YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)senderStarProgress:(CGFloat)newProgress withIndex:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        self.starProgress = newProgress;
    }else if (indexPath.row == 1) {
        self.timelevel = newProgress;
    }else if (indexPath.row == 2) {
        self.attitudelevel = newProgress;
    }else if (indexPath.row == 3) {
        self.abilitylevel = newProgress;
    }
}
@end
