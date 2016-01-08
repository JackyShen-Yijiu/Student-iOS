//
//  ComplainViewController.m
//  studentDriving
//
//  Created by bestseller on 15/10/29.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "ComplainViewController.h"
#import "MyAppointmentModel.h"
#import "BCTextView.h"
#import "ComplainTableViewCell.h"
#import "UIDevice+JEsystemVersion.h"
#import "AppointmentViewController.h"

static NSString *const kuserComplainAppointment = @"courseinfo/usercomplaint";

@interface ComplainViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,ComplainTableViewCellDelegate> {
    BCTextView *contentField;
}
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIButton *submitBtn;

@property (copy, nonatomic) NSString *cancelMessage;
@property (copy, nonatomic) NSString *cancelContent;

@end

@implementation ComplainViewController


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
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
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
    for (UIButton *btn in self.buttonArray) {
        if (btn.selected) {
            
        }
    }
    self.cancelContent = contentField.text;
    NSString *urlString  = [NSString stringWithFormat:BASEURL,kuserComplainAppointment];
    
    if (self.cancelContent == nil) {
        self.cancelContent = @"";
    }
    if (self.cancelMessage == nil) {
        self.cancelMessage = @"";
    }
    NSDictionary *param = @{@"userid":[AcountManager manager].userid,@"reservationid":self.model.infoId,@"complaintcontent":self.cancelContent,@"reason":self.cancelMessage};
    [JENetwoking startDownLoadWithUrl:urlString postParam:param WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        DYNSLog(@"data = %@",data);
        NSDictionary *param = data;
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        if ([type isEqualToString:@"1"]) {
            [self showTotasViewWithMes:@"投诉成功"];
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[AppointmentViewController class]]) {
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }
        }else if([type isEqualToString:@"0"]){
            [self showTotasViewWithMes:@"投诉失败"];
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
    if (section == 0) {
        return 0;
    }
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = BACKGROUNDCOLOR;
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 200;
    }else if (indexPath.section == 1 && indexPath.row == 0){
        return 80;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *cellId = @"cellOne";
        ComplainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[ComplainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
        }
        self.buttonArray = cell.bntArray;
        self.labelArray = cell.titleArray;
        return cell;
        
    }else if (indexPath.section == 1) {
        static NSString *cellId = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            contentField = [[BCTextView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 79) withPlaceholder: @"投诉说明"];
            contentField.delegate = self;
            contentField.font = [UIFont systemFontOfSize:16];
            contentField.returnKeyType = UIReturnKeyDone;

            [cell.contentView addSubview:contentField];
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
- (void)senderCancelMessage:(NSString *)message {
    self.cancelMessage = message;
}

@end
