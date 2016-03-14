//
//  YBCancleAppointMentController.m
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "YBCancleAppointMentController.h"
#import "UIDevice+JEsystemVersion.h"
#import "CancelAppointmentCell.h"
#import "YBTextView.h"
#import "MyAppointmentModel.h"
#import "HMCourseModel.h"
#import "YBAppointMentController.h"

//static NSString *const kuserCancelAppointment = @"/courseinfo/cancelreservation";


@interface YBCancleAppointMentController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,CancelAppointmentCellDelegate> {
    YBTextView *contentField;
}
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIButton *submitBtn;

@property (copy, nonatomic) NSString *cancelMessage;
@property (copy, nonatomic) NSString *cancelContent;

@end

@implementation YBCancleAppointMentController

- (UIButton *)submitBtn {
    if (_submitBtn == nil) {
        _submitBtn = [WMUITool initWithTitle:@"提交" withTitleColor:[UIColor whiteColor] withTitleFont:[UIFont systemFontOfSize:14]];
        _submitBtn.backgroundColor = YBNavigationBarBgColor;
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 4;
        [_submitBtn addTarget:self action:@selector(clickSubmit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = YBMainViewControlerBackgroundColor;
    }
    return _tableView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"取消原因";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([UIDevice jeSystemVersion] >= 7.0f) {
        //当你的容器是navigation controller时，默认的布局将从navigation bar的顶部开始。这就是为什么所有的UI元素都往上漂移了44pt
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:[self tableViewFootView]];
    self.view.backgroundColor = YBMainViewControlerBackgroundColor;
    
}

- (void)clickSubmit:(UIButton *)sender {
    
    self.cancelContent = contentField.text;
    
    NSString *urlString  = [NSString stringWithFormat:BASEURL,kuserCancelAppointment];
    
    NSLog(@"%@%@",self.cancelContent,self.cancelMessage);
    
    if (self.cancelMessage == nil) {
        
        [self obj_showTotasViewWithMes:@"请填写取消原因"];

        return;
    }
    if (self.cancelContent == nil) {
        [self obj_showTotasViewWithMes:@"请填写取消原因"];

        return;
    }
   
    NSDictionary *param = @{@"userid":[AcountManager manager].userid,@"reservationid":_courseModel.courseId,@"cancelcontent":self.cancelContent,@"cancelreason":self.cancelMessage};
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:param WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        DYNSLog(@"data = %@",data);
        NSDictionary *param = data;
        NSNumber *type = param[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@",param[@"msg"]];
        
        if (type.integerValue == 1) {
            
            [self obj_showTotasViewWithMes:@"取消成功"];
            
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[YBAppointMentController class]]) {
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }
            
        }else{

            [self obj_showTotasViewWithMes:msg];
        }
        
    }];
}

- (UIView *)tableViewFootView {
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height-56-64, kSystemWide, 56)];
    backGroundView.backgroundColor = YBMainViewControlerBackgroundColor;
    
    [backGroundView addSubview:self.submitBtn];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backGroundView.mas_top).offset(0);
        make.right.mas_equalTo(backGroundView.mas_right).offset(-16);
        make.left.mas_equalTo(backGroundView.mas_left).offset(16);
        make.height.mas_equalTo(@44);
//        make.width.mas_equalTo(@90);
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
        CancelAppointmentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[CancelAppointmentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
        }
        return cell;
        
    }else if (indexPath.section == 1) {
        static NSString *cellId = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            contentField = [[YBTextView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 79) withPlaceholder: @"取消预约说明"];
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
//    BCTextView *bcTextView = (BCTextView *)textView;
    contentField.placeholderLabel.hidden = YES;
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
}
@end
