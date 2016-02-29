//
//  YBAppointTestViewController.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/25.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBAppointTestViewController.h"
#import "ShowWarningMessageView.h"
#import "YBStudyWebViewController.h"

@interface YBAppointTestViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *statDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;
@property (weak, nonatomic) IBOutlet UIButton *yesBtn;
- (IBAction)yesBtnDidClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *noBtn;
- (IBAction)noBtnDidClick:(id)sender;

@property (strong, nonatomic) UIButton *submitBtn;
@property (strong, nonatomic) UILabel *messageLabel;

@property (strong, nonatomic) ShowWarningMessageView *reasonMsg;

@property (nonatomic,assign) BOOL isYESorNo;

@property (nonatomic,copy) NSString *startTime;
@property (nonatomic,copy) NSString *endTime;

@property (nonatomic,copy) NSString *webURL;

@end

@implementation YBAppointTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = RGBColor(236, 236, 236);
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.mainScrollView addSubview:self.reasonMsg];
    
//    self.mainScrollView.frame = CGRectMake(0, 0, self.view.width, self.view.height-50-64);
//    self.mainScrollView.contentSize = CGSizeMake(self.view.width, self.view.height);
    [self.view addSubview:[self tableViewFootView]];
    
    // 初始化信息
    self.statDatePicker.date = [NSDate date]; // 设置初始时间
    self.statDatePicker.timeZone = [NSTimeZone timeZoneWithName:@"GTM+8"]; // 设置时区，中国在东八区
    self.statDatePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:0]; // 设置最小时间
    self.statDatePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:72 * 60 * 60 * 30 * 6]; // 设置最大时间
    self.statDatePicker.datePickerMode = UIDatePickerModeDate; // 设置样式
    [self.statDatePicker addTarget:self action:@selector(oneDatePickerValueChanged) forControlEvents:UIControlEventValueChanged]; // 添加监听器
    
    self.endDatePicker.date = [NSDate date]; // 设置初始时间
    self.endDatePicker.timeZone = [NSTimeZone timeZoneWithName:@"GTM+8"]; // 设置时区，中国在东八区
    self.endDatePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:0]; // 设置最小时间
    self.endDatePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:72 * 60 * 60 * 30 * 6]; // 设置最大时间
    self.endDatePicker.datePickerMode = UIDatePickerModeDate; // 设置样式
    [self.endDatePicker addTarget:self action:@selector(twoDatePickerValueChanged) forControlEvents:UIControlEventValueChanged]; // 添加监听器
    
    NSDate *select = [self.statDatePicker date]; // 获取被选中的时间
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy-MM-dd"; // 设置时间和日期的格式
    NSString *startDate = [selectDateFormatter stringFromDate:select]; // 把date类型转为设置好格式的string类型
    NSLog(@"startDate:%@",startDate);
    self.startTime = startDate;
    
    NSDate *endselect = [self.endDatePicker date]; // 获取被选中的时间
    NSDateFormatter *endselectDateFormatter = [[NSDateFormatter alloc] init];
    endselectDateFormatter.dateFormat = @"yyyy-MM-dd"; // 设置时间和日期的格式
    NSString *endDate = [endselectDateFormatter stringFromDate:endselect]; // 把date类型转为设置好格式的string类型
    NSLog(@"endDate:%@",endDate);
    self.endTime = endDate;
    
    self.messageLabel.text = [NSString stringWithFormat:@"%@至%@",self.startTime,self.endTime];

    // 获取自主预约URL
    [self getDriveschoolschoolexamurl];
    
}

- (void)getDriveschoolschoolexamurl{
    
    NSLog(@"[AcountManager manager].applyschool.infoId:%@",[AcountManager manager].applyschool.infoId);
    
    if ([AcountManager manager].applyschool.infoId) {
        
        NSString *subjecturl = [NSString stringWithFormat:kdriveschoolSchoolexamurl,[AcountManager manager].applyschool.infoId];
        
        NSString *urlString = [NSString stringWithFormat:BASEURL,subjecturl];
        
        __weak YBAppointTestViewController *weakSelf = self;
        [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
            
            NSLog(@"data:%@",data);
            
            NSString *type = [NSString stringWithFormat:@"%@",data[@"type"]];
            NSString *webURL = [NSString stringWithFormat:@"%@",data[@"data"]];
            
            if (type && [type isEqualToString:@"1"] && webURL && [webURL length]!=0) {
                
                weakSelf.webURL = webURL;
                
                weakSelf.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"自主预约" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarDidClick)];
            }

        }];
        
    }
    
}

- (void)rightBarDidClick
{
    YBStudyWebViewController *vc = [[YBStudyWebViewController alloc] init];
    vc.weburl = self.webURL;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)oneDatePickerValueChanged
{
    NSDate *select = [self.statDatePicker date]; // 获取被选中的时间
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy-MM-dd"; // 设置时间和日期的格式
    NSString *startDate = [selectDateFormatter stringFromDate:select]; // 把date类型转为设置好格式的string类型
    NSLog(@"startDate:%@",startDate);
    self.startTime = startDate;
    
    self.endDatePicker.date = select;
    self.endDatePicker.minimumDate = select; // 设置最小时间
    self.endDatePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:72 * 60 * 60 * 30 * 6]; // 设置最大时间
    self.endDatePicker.datePickerMode = UIDatePickerModeDate; // 设置样式

    self.messageLabel.text = [NSString stringWithFormat:@"%@至%@",self.startTime,self.endTime];
    
}

- (void)twoDatePickerValueChanged
{
    NSDate *select = [self.endDatePicker date]; // 获取被选中的时间
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy-MM-dd"; // 设置时间和日期的格式
    NSString *endDate = [selectDateFormatter stringFromDate:select]; // 把date类型转为设置好格式的string类型
    NSLog(@"endDate:%@",endDate);
    self.endTime = endDate;
    
    self.messageLabel.text = [NSString stringWithFormat:@"%@至%@",self.startTime,self.endTime];

}

- (ShowWarningMessageView *)reasonMsg
{
    if (_reasonMsg==nil) {
        _reasonMsg = [[ShowWarningMessageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-100-20, self.phoneTextField.frame.origin.y-20, 100, 20)];
        _reasonMsg.message = @"您输入的信息有误";
        _reasonMsg.hidden = YES;
    }
    return _reasonMsg;
}
- (UIButton *)submitBtn {
    if (_submitBtn == nil) {
        _submitBtn = [WMUITool initWithTitle:@"立即申请" withTitleColor:[UIColor whiteColor] withTitleFont:[UIFont systemFontOfSize:16]];
        _submitBtn.backgroundColor = YBNavigationBarBgColor;
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 3;
        [_submitBtn addTarget:self action:@selector(applyBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}
- (UILabel *)messageLabel {
    if (_messageLabel == nil) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.font = [UIFont systemFontOfSize:12];
        _messageLabel.text = @"请选择约考时间";
        _messageLabel.textColor = [UIColor blackColor];
    }
    return _messageLabel;
}

- (UIView *)tableViewFootView {
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 64 - 50 - 8, kSystemWide, 50)];
    backGroundView.backgroundColor = [UIColor whiteColor];
    
    [backGroundView addSubview:self.submitBtn];
    [backGroundView addSubview:self.messageLabel];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backGroundView.mas_top).offset(5);
        make.right.mas_equalTo(backGroundView.mas_right).offset(-15);
        make.height.mas_equalTo(@40);
        make.width.mas_equalTo(@90);
    }];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@5);
        make.bottom.equalTo(@5);
        make.left.equalTo(@10);
    }];
    
    return backGroundView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)applyBtnDidClick
{
    NSLog(@"%s",__func__);
    if (self.nameTextField.text == nil) {
        [self obj_showTotasViewWithMes:@"请输入姓名"];
        return;
    }
    if (self.phoneTextField.text == nil) {
        [self obj_showTotasViewWithMes:@"请输入电话号码"];
        return;
    }
    if (![AcountManager isValidateMobile:self.phoneTextField.text]) {
        [self obj_showTotasViewWithMes:@"请输入正确的手机号"];
        self.reasonMsg.hidden = NO;
        return;
    }
    self.reasonMsg.hidden = YES;
    
    if (self.startTime==nil) {
        [self obj_showTotasViewWithMes:@"请选择开始时间"];
        return;
    }
    if (self.endTime==nil) {
        [self obj_showTotasViewWithMes:@"请选择结束时间"];
        return;
    }
    
    NSLog(@"[AcountManager manager].userSubject.subjectId:%@",[AcountManager manager].userSubject.subjectId);
    
//    NSString *appointURL = [NSString stringWithFormat:kapplyexamination,self.startTime,self.endTime,self.phoneTextField.text,self.nameTextField.text,[NSString stringWithFormat:@"%d",self.isYESorNo],[NSString stringWithFormat:@"%@",[AcountManager manager].userSubject.subjectId]];
//    NSLog(@"appointURL:%@",appointURL);
    
    NSString *urlString  = [NSString stringWithFormat:BASEURL,kapplyexamination];
    NSLog(@"urlString:%@",urlString);
    
    // static NSString *const kapplyexamination = @"userinfo/applyexamination?exambegintime=%@&examendtime=%@&exammobile=%@&examname=%@&exampractice=%@&subjectid=%@";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"exambegintime"] = self.startTime;
    dict[@"examendtime"] = self.endTime;
    dict[@"exammobile"] = self.phoneTextField.text;
    dict[@"examname"] = self.nameTextField.text;
    dict[@"exampractice"] = [NSString stringWithFormat:@"%d",self.isYESorNo];
    dict[@"subjectid"] = [NSString stringWithFormat:@"%@",[AcountManager manager].userSubject.subjectId];

    [JENetwoking startDownLoadWithUrl:urlString postParam:dict WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        DYNSLog(@"申请urlString:%@ param:%@ data:%@",urlString,dict,data);
        
        NSDictionary *param = data;
        NSNumber *type = param[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@",param[@"msg"]];
        
        if (type.integerValue == 1) {
            [self obj_showTotasViewWithMes:@"约考成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [self obj_showTotasViewWithMes:msg];
        }
    }];
    
    
}

- (IBAction)yesBtnDidClick:(id)sender {
    [self.yesBtn setImage:[UIImage imageNamed:@"ic_single_selection_yes"] forState:UIControlStateNormal];
    [self.noBtn setImage:[UIImage imageNamed:@"ic_single_selection_no"] forState:UIControlStateNormal];
    
    [self.yesBtn setTitleColor:YBNavigationBarBgColor forState:UIControlStateNormal];
    [self.noBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    self.isYESorNo = YES;
}
- (IBAction)noBtnDidClick:(id)sender {
    [self.yesBtn setImage:[UIImage imageNamed:@"ic_single_selection_no"] forState:UIControlStateNormal];
    [self.noBtn setImage:[UIImage imageNamed:@"ic_single_selection_yes"] forState:UIControlStateNormal];
    
    [self.yesBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.noBtn setTitleColor:YBNavigationBarBgColor forState:UIControlStateNormal];
    
    self.isYESorNo = NO;
}

@end
