//
//  ConfirmStudyFinishViewController.m
//  studentDriving
//
//  Created by bestseller on 15/10/29.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "ConfirmStudyFinishViewController.h"
#import "BCTextView.h"
#import "UIDevice+JEsystemVersion.h"
#import "ConfirmSubjectOneCell.h"
#import "ConfirmSubjectTwoCell.h"
#import "MyAppointmentModel.h"
#import "AppointmentViewController.h"
#import <SVProgressHUD.h>
static NSString *const kconfirmStudyEnd = @"/courseinfo/finishreservation";

@interface ConfirmStudyFinishViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate> {
    BCTextView *contentField;
}
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIButton *submitBtn;

@property (copy, nonatomic) NSString *cancelMessage;
@property (copy, nonatomic) NSString *cancelContent;
@property (strong, nonatomic) UIButton *naviBarRightButton;



@end

@implementation ConfirmStudyFinishViewController

- (UIButton *)naviBarRightButton {
    if (_naviBarRightButton == nil) {
        _naviBarRightButton = [WMUITool initWithTitle:@"完成" withTitleColor:MAINCOLOR withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarRightButton.frame = CGRectMake(0, 0, 44, 44);
        [_naviBarRightButton addTarget:self action:@selector(clickRight:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBarRightButton;
}

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
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)clickRight:(UIButton *)sender {
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[AppointmentViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
}

- (void)clickSubmit:(UIButton *)sender {
    self.cancelContent = contentField.text;
    NSString *urlString  = [NSString stringWithFormat:BASEURL,kconfirmStudyEnd];
    
    if (self.cancelContent == nil) {
        self.cancelContent = @"";
    }
    if (self.cancelMessage == nil) {
        self.cancelMessage = @"";
    }
    NSDictionary *param = @{@"userid":[AcountManager manager].userid,@"reservationid":self.model.infoId,@"learningcontent":self.cancelContent,@"cancelreason":self.cancelMessage};
    [JENetwoking startDownLoadWithUrl:urlString postParam:param WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        DYNSLog(@"data = %@",data);
        NSDictionary *param = data;
        NSNumber *type = param[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@",param[@"msg"]];
        if (type.integerValue == 1) {
            kShowSuccess(@"成功确认");
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[AppointmentViewController class]]) {
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }
        }else {
            kShowFail(msg)
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
        if (self.model.subjectModel.subjectId.integerValue == 2) {
            return 200;
        }else if (self.model.subjectModel.subjectId.integerValue == 3) {
            return 300;
        }
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
        if (self.model.subjectModel.subjectId.integerValue == 2) {
            static NSString *cellId = @"cellOne";

            ConfirmSubjectOneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[ConfirmSubjectOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }else if (self.model.subjectModel.subjectId.integerValue == 3) {
            static NSString *cellId = @"cellTwo";
            ConfirmSubjectTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[ConfirmSubjectTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }
        
        
    }else if (indexPath.section == 1) {
        static NSString *cellId = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            contentField = [[BCTextView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 79) withPlaceholder: @"其他教学内容"];
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
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    kShowDismiss
}
@end
