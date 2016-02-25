//
//  ComplaintCoachView.m
//  studentDriving
//
//  Created by zyt on 16/2/18.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBComplaintCoachView.h"
#import "AddlineButtomTextField.h"
#import "PlaceholderTextView.h"
#import "NSString+Helper.h"
#import "ShowWarningMessageView.h"

@interface YBComplaintCoachView ()<UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UIButton *anonymousButton; // 匿名投诉

@property (nonatomic, strong) UIButton *realNameButton;

@property (nonatomic, strong) UIView *lintComlaintView;

@property (nonatomic, strong) UIView *BgoachNameView; // 添加手势，跳转教练列表页面

@property (nonatomic, strong) UILabel *titlieNameCoachLabel;



@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UIView *lineNameView;

@property (nonatomic, strong) UILabel *phontView; // 投诉人联系电话

@property (nonatomic, strong) UITextField *phontTextField;

@property (nonatomic, strong) UILabel *complaintContentLabel; // 投诉内容

@property (nonatomic, strong) PlaceholderTextView *complaintTextField;

@property (nonatomic, strong) UIView *lineCView;

@property (nonatomic, strong)  UIView *bottomBG; // 底部试图



@property (nonatomic, strong)  UIButton *commintButton;

@property (nonatomic, assign) BOOL complaintWay;

@property (nonatomic, strong) ShowWarningMessageView *showWarningMessageView;


@end
@implementation YBComplaintCoachView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.anonymousButton];
    [self addSubview:self.realNameButton];
    [self addSubview:self.lintComlaintView];
    [self addSubview:self.BgoachNameView];
    [self.BgoachNameView addSubview:self.titlieNameCoachLabel];
    [self.BgoachNameView  addSubview:self.nameCoachLabel];
    [self.BgoachNameView  addSubview:self.lineNameView];
    [self.BgoachNameView addSubview:self.imgView];
    // 联系电话
    [self addSubview:self.phontView];
    [self addSubview:self.phontTextField];
    // 投诉内容
    [self addSubview:self.complaintContentLabel];
    [self addSubview:self.complaintTextField];
    [self addSubview:self.lineCView];
    // 底部试图
    [self addSubview:self.bottomBG];
    [self.bottomBG addSubview:self.bottomCoachName];
    [self.bottomBG addSubview:self.commintButton];
}
#pragma mark --- ActionTagart
// 匿名投诉
- (void)didclickAnonymous:(UIButton *)btn{
    if (!btn.selected) {
        btn.selected = YES;
        _realNameButton.selected = NO;
        _complaintWay = 0;
        
    }
}
// 实名投诉
- (void)didclickReal:(UIButton *)btn{
    if (!btn.selected) {
        btn.selected = YES;
        _anonymousButton.selected = NO;
        _complaintWay = 1;
    }

}
// 提交投诉信息
- (void)commitComplaint:(UIButton *)btn{
    [self networkRequest];
}
// 教练详情点击手势
- (void)SingleTap:(UITapGestureRecognizer *)tap{
    if ([self.complaintPushCoachDetailDelegate respondsToSelector:@selector(initWithComplaintPushCoachDetail)]) {
        [self.complaintPushCoachDetailDelegate initWithComplaintPushCoachDetail];
    }
}
- (void)networkRequest {
    CGRect rect = [UIScreen mainScreen].bounds;
    if (self.phontTextField.text == nil || self.phontTextField.text.length  == 0) {
        _showWarningMessageView = [[ShowWarningMessageView alloc] initWithFrame:CGRectMake(rect.size.width - 120 - 8, _phontView.frame.origin.y, 120, 18)];
        _showWarningMessageView.isShowWarningMessage  = NO;
        [self addSubview:self.showWarningMessageView];
        return;
    }
    
    
    if (![AcountManager isValidateMobile:self.phontTextField.text]) {
//        [self obj_showTotasViewWithMes:@"请输入正确的手机号"];
        _showWarningMessageView = [[ShowWarningMessageView alloc] initWithFrame:CGRectMake(rect.size.width - 120 - 8, _phontView.frame.origin.y, 120, 18)];
        _showWarningMessageView.isShowWarningMessage  = NO;
        [self addSubview:self.showWarningMessageView];
        return;
    }
    
    
    if (!_complaintTextField.text.length) {
//        [self obj_showTotasViewWithMes:@"请输入投诉原因"];
        _showWarningMessageView = [[ShowWarningMessageView alloc] initWithFrame:CGRectMake(rect.size.width - 120 - 8, _complaintContentLabel.frame.origin.y, 120, 18)];
        _showWarningMessageView.isShowWarningMessage  = NO;
        [self addSubview:self.showWarningMessageView];
        return;

        return ;
    }

    
    
    
    
    
    
    
    
    
    //    {   "userid":"560539bea694336c25c3acb9",（用户id 可以空）
    //        "feedbackmessage":"无法登录", （反馈信息 必填）
    //        "mobileversion":"小米 4.00",(手机版本 必填)
    //        "network":"wifi",（网络情况 必填）
    //        "resolution":"300*400", （分辨率 必填）
    //        "appversion":"android 1.00"（app 版本 必填）
    //        "feedbacktype": 1, // 反馈类型 0 平台反馈 1 投诉教练 2 投诉驾校
    //        "name": "liyafei",
    //        "feedbackusertype": 1, //投诉类型 0 匿名投诉 1 实名投诉
    //        "moblie": "12345678901", // 投诉人手机号
    //        "becomplainedname": "王教练", //被投诉姓名
    //        "piclist": "pic1.jpg,pic2.jpg" // 图片列表 ,分割}
    
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionary];
    // 用户id 可以空
    if ([AcountManager manager].userid.length) {
        [parmDict setValue:[AcountManager manager].userid forKey:@"userid"];
    }
    // 反馈信息 必填
    [parmDict setValue:_complaintTextField.text forKey:@"feedbackmessage"];
    // 手机型号
    NSString *deviceModel = [NSString getCurrentDeviceModel];
    if (!deviceModel) {
        deviceModel = @"未知";
    }
    [parmDict setValue:deviceModel forKey:@"mobileversion"];
    // 网络情况 必填
    if ([NetMonitor manager].netStateExplain) {
        [parmDict setValue:[NetMonitor manager].netStateExplain forKey:@"network"];
    }
    // 分辨率 必填
    CGSize size = [UIScreen mainScreen].bounds.size;
    [parmDict setValue:[NSString stringWithFormat:@"%.0f*%.0f", size.width, size.height] forKey:@"resolution"];
    // app 版本 必填
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
    [parmDict setValue:[NSString stringWithFormat:@"iOS %@", currentVersion] forKey:@"appversion"];
    // 反馈类型 0 平台反馈 1 投诉教练 2 投诉驾校
    [parmDict setValue:@"1" forKey:@"feedbacktype"];
    // 投诉类型 0 匿名投诉 1 实名投诉
    [parmDict setValue:[NSString stringWithFormat:@"%d", _complaintWay] forKey:@"feedbackusertype"];
    // 投诉人手机号
    if ([AcountManager manager].userMobile) {
        [parmDict setValue:[AcountManager manager].userMobile forKey:@"moblie"];
    }
    // 被投诉姓名
    [parmDict setValue:_nameCoachLabel.text forKey:@"becomplainedname"];
    DYNSLog(@"%@", parmDict);
    [JENetwoking startDownLoadWithUrl:[NSString stringWithFormat:BASEURL, @"userfeedback"] postParam:parmDict WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        NSDictionary *dict = data;
        NSInteger type = [[dict objectForKey:@"type"] integerValue];
        if (type) {
            [self obj_showTotasViewWithMes:@"投诉成功"];
            [_superController.navigationController popViewControllerAnimated:YES];
        }else {
            [self obj_showTotasViewWithMes:@"投诉失败"];
        }
        
    } withFailure:^(id data) {
        [self obj_showTotasViewWithMes:@"投诉失败"];
    }];
}

-(void)textViewDidChange:(UITextView *)textView
{
    if([textView.text length]>200)
    {
        textView.text = [textView.text substringToIndex:200];
        [self obj_showTotasViewWithMes:@"已超过最大字数！"];
        return;
    }
    self.complaintContentLabel.text = [NSString stringWithFormat:@"投诉内容%lu/200",[textView.text length]];
}
// 提示框消失操作
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (!self.showWarningMessageView.isShowWarningMessage) {
        self.showWarningMessageView.hidden = YES;
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (!self.showWarningMessageView.isShowWarningMessage) {
        self.showWarningMessageView.hidden = YES;
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.anonymousButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(24);
    }];
    [self.realNameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.left.mas_equalTo(self.anonymousButton.mas_right).offset(70);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(24);
    }];
    [self.lintComlaintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.anonymousButton.mas_bottom).offset(20);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(1);
    }];
    [self.BgoachNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lintComlaintView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.height.mas_equalTo(73);
        make.right.mas_equalTo(self.mas_right).offset(0);
    }];
    [self.titlieNameCoachLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.BgoachNameView.mas_top).offset(16);
        make.left.mas_equalTo(self.BgoachNameView.mas_left).offset(20);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(10);
    }];
    [self.nameCoachLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titlieNameCoachLabel.mas_bottom).offset(16);
        make.left.mas_equalTo(self.BgoachNameView.mas_left).offset(20);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(14);
    }];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.BgoachNameView.mas_top).offset(24);
        make.right.mas_equalTo(self.BgoachNameView.mas_right).offset(-20);
        make.width.mas_equalTo(@24);
        make.height.mas_equalTo(24);
    }];

    [self.lineNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameCoachLabel.mas_bottom).offset(16);
        make.left.mas_equalTo(self.BgoachNameView.mas_left).offset(20);
        make.right.mas_equalTo(self.BgoachNameView.mas_right).offset(0);
        make.height.mas_equalTo(1);
    }];
    [self.phontView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineNameView.mas_bottom).offset(16);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(@10);
    }];
    [self.phontTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phontView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(@40);
    }];
    [self.complaintContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phontTextField.mas_bottom).offset(16);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(@10);
    }];
    [self.complaintTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.complaintContentLabel.mas_bottom).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(@60);
    }];
    [self.lineCView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.complaintTextField.mas_bottom).offset(-1);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(@1);
    }];

    [self.bottomBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(@40);
    }];

    [self.bottomCoachName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomBG.mas_top).offset(13);
        make.left.mas_equalTo(self.bottomBG.mas_left).offset(20);
        make.width.mas_equalTo(@150);
        make.height.mas_equalTo(14);
    }];
    [self.commintButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomBG.mas_top).offset(5);
        make.right.mas_equalTo(self.bottomBG.mas_right).offset(-20);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(30);
    }];


}
#pragma mark --- Lazy加载

- (UIButton *)anonymousButton{
    if (_anonymousButton == nil) {
        
        _anonymousButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_anonymousButton setTitle:@"匿名投诉" forState:UIControlStateNormal];
        [_anonymousButton setTitleColor:[UIColor colorWithHexString:@"bdbdbd"] forState:UIControlStateNormal];
        [_anonymousButton setTitleColor:[UIColor colorWithHexString:@"bd4437"] forState:UIControlStateSelected];
        [_anonymousButton setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        [_anonymousButton setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
        [_anonymousButton setImageEdgeInsets:UIEdgeInsetsMake(0,-25,0,0)];
        _anonymousButton.titleEdgeInsets = UIEdgeInsetsMake(5, -20, 5, 0);
        _anonymousButton.selected = YES;
//        _anonymousButton.backgroundColor = [UIColor orangeColor];
        [_anonymousButton addTarget:self action:@selector(didclickAnonymous:) forControlEvents:UIControlEventTouchUpInside];
        _anonymousButton.titleLabel.font = [UIFont systemFontOfSize:14];
//        _anonymousButton.backgroundColor = [UIColor cyanColor]
        ;
        
    }
    return _anonymousButton;
    
    
}
- (UIButton *)realNameButton{
    if (_realNameButton == nil) {
        
        _realNameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_realNameButton setTitle:@"实名投诉" forState:UIControlStateNormal];
        [_realNameButton setTitleColor:[UIColor colorWithHexString:@"bdbdbd"] forState:UIControlStateNormal];
        [_realNameButton setTitleColor:[UIColor colorWithHexString:@"bd4437"] forState:UIControlStateSelected];
        [_realNameButton setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        [_realNameButton setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
        [_realNameButton setImageEdgeInsets:UIEdgeInsetsMake(0,-25,0,0)];
         _realNameButton.titleEdgeInsets = UIEdgeInsetsMake(5, -20, 5, 0);
        
        [_realNameButton addTarget:self action:@selector(didclickReal:) forControlEvents:UIControlEventTouchUpInside];
        _realNameButton.titleLabel.font = [UIFont systemFontOfSize:14];
         _realNameButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    }
    return _realNameButton;
    
    
}
- (UIView *)lintComlaintView{
    if (_lintComlaintView == nil) {
        _lintComlaintView = [[UIView alloc] init];
        _lintComlaintView.backgroundColor  = [UIColor colorWithHexString:@"bdbdbd"];
        
    }
    return _lintComlaintView;
}
- (UIView *)BgoachNameView{
    if (_BgoachNameView == nil) {
        _BgoachNameView = [[UIView alloc] init];
        _BgoachNameView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
        //给self.view添加一个手势监测；
        [_BgoachNameView addGestureRecognizer:singleRecognizer];
        
    }
    return _BgoachNameView;
}
- (UILabel *)titlieNameCoachLabel{
    if (_titlieNameCoachLabel == nil) {
        _titlieNameCoachLabel = [[UILabel alloc] init];
        _titlieNameCoachLabel.text = @"投诉教练姓名";
        _titlieNameCoachLabel.textColor = [UIColor colorWithHexString:@"bdbdbd"];
        _titlieNameCoachLabel.font = [UIFont systemFontOfSize:10];
        
        
    }
    return _titlieNameCoachLabel;
}

- (UILabel *)nameCoachLabel{
    if (_nameCoachLabel == nil) {
        _nameCoachLabel = [[UILabel alloc] init];
        _nameCoachLabel.text = [[AcountManager manager] applycoach].name;
        _nameCoachLabel.textColor = [UIColor blackColor];
        _nameCoachLabel.font = [UIFont systemFontOfSize:14];
        
        
    }
    return _nameCoachLabel;
}

- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor  = [UIColor clearColor];
        _imgView.image = [UIImage imageNamed:@"箭头"];
    }
    return _imgView;
                          
}
- (UIView *)lineNameView{
    if (_lineNameView == nil) {
        _lineNameView = [[UIView alloc] init];
        _lineNameView.backgroundColor  = [UIColor colorWithHexString:@"bdbdbd"];
        
    }
    return _lineNameView;
}
- (UILabel *)phontView{
    if (_phontView == nil) {
        _phontView = [[UILabel  alloc] init];
        _phontView.text = @"您的联系电话";
        _phontView.textColor = [UIColor colorWithHexString:@"bdbdbd"];
        _phontView.font = [UIFont systemFontOfSize:10];
//        _phontView.backgroundColor = [UIColor cyanColor];
    }
    return _phontView;
}
- (UITextField *)phontTextField{
    if (_phontTextField == nil) {
        _phontTextField = [[AddlineButtomTextField alloc] init];
        _phontTextField.delegate = self;
        _phontTextField.textColor = [UIColor colorWithHexString:@"212121"];
        _phontTextField.font = [UIFont systemFontOfSize:14];
        _phontTextField.text = [AcountManager manager].userMobile;
        
    }
    return _phontTextField;
}
- (UILabel *)complaintContentLabel{
    if (_complaintContentLabel == nil) {
        _complaintContentLabel = [[UILabel  alloc] init];
        _complaintContentLabel.text = @"投诉内容 0/200";
        
        _complaintContentLabel.textColor = [UIColor colorWithHexString:@"bdbdbd"];
        _complaintContentLabel.font = [UIFont systemFontOfSize:10];
        //        _phontView.backgroundColor = [UIColor cyanColor];
    }
    return _complaintContentLabel;
}
- (PlaceholderTextView *)complaintTextField{
    if (_complaintTextField == nil) {
        _complaintTextField = [[PlaceholderTextView alloc] init];
        _complaintTextField.delegate = self;
        _complaintTextField.textColor = [UIColor colorWithHexString:@"212121"];
        _complaintTextField.font = [UIFont systemFontOfSize:14];
        _complaintTextField.backgroundColor = [UIColor clearColor];
        
    }
    return _complaintTextField;
}
- (UIView *)lineCView{
    if (_lineCView == nil) {
        _lineCView = [[UIView alloc] init];
        _lineCView.backgroundColor  = [UIColor colorWithHexString:@"bdbdbd"];
    }
    return _lineCView;
}
- (UIView *)bottomBG{
    if (_bottomBG == nil) {
        _bottomBG = [[UIView alloc] init];
//        _bottomBG.backgroundColor = [UIColor cyanColor];
        
    }
    return _bottomBG;
}
- (UILabel *)bottomCoachName{
    if (_bottomCoachName == nil) {
        _bottomCoachName = [[UILabel alloc] init];
        _bottomCoachName.text = [NSString stringWithFormat:@"投诉 %@教练",[[AcountManager manager] applycoach].name];
        _bottomCoachName.textColor = [UIColor blackColor];
        _bottomCoachName.font = [UIFont systemFontOfSize:14];
        
        
    }
    return _bottomCoachName;
}
- (UIButton *)commintButton{
    if (_commintButton == nil) {
        _commintButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commintButton.backgroundColor = YBNavigationBarBgColor;
        [_commintButton setTitle:@"提交" forState:UIControlStateNormal];
        [_commintButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commintButton addTarget:self action:@selector(commitComplaint:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commintButton;
}
@end
