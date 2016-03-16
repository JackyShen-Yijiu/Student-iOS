//
//  SignSuccessView.m
//  chooseView
//
//  Created by 胡东苑 on 15/12/13.
//  Copyright © 2015年 胡东苑. All rights reserved.
//

#import "SignSuccessView.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "YBSignUpSuccessRootClass.h"
#import "YBSignUpSuccessData.h"
#import "YBSignUpSuccessApplyclasstypeinfo.h"
#import "YBSignUpSuccessApplyschoolinfo.h"


static NSString *const kCreatQrcode = @"/create_qrcode";

@interface SignSuccessView ()<UIAlertViewDelegate>

@property (nonatomic, strong) UILabel     *successContentLb;
@property (nonatomic, strong) UILabel     *orderNumLb;
@property (nonatomic, strong) UILabel     *dataExplainLb;
@property (nonatomic, strong) UILabel     *dataExplainContentLb;
@property (nonatomic, strong) UILabel     *barCodeUseExplainLb;
@property (nonatomic, strong) UILabel     *barCodeUseExplainContentLb;
@property (nonatomic, strong) UIImageView *barCodeView;
@property (nonatomic,strong) UILabel *messageLabel;

@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic,strong) UIView *midView;
@property (nonatomic,strong) UIImageView *iconImgView;
@property (nonatomic, strong) UILabel     *nameLabel;
@property (nonatomic, strong) UILabel     *payMoneyLabel;
@property (nonatomic, strong) UILabel     *typeLabel;
@property (nonatomic, strong) UILabel     *payTypeLabel;
@property (nonatomic, strong) UILabel     *timeLabel;
@property (nonatomic, strong) UIButton     *cancleBtn;

@property (nonatomic,strong) UIView *delive1View;
@property (nonatomic,strong) UIView *delive2View;

@property (nonatomic,strong) UIView *delive3View;

@property (nonatomic,strong) YBSignUpSuccessRootClass *signUpSuccessClass;

@end

@implementation SignSuccessView

- (UIView *)delive1View
{
    if (_delive1View==nil) {
        _delive1View = [[UIView alloc] init];
        _delive1View.backgroundColor = YBMainViewControlerBackgroundColor;
    }
    return _delive1View;
}
- (UIView *)delive2View
{
    if (_delive2View==nil) {
        _delive2View = [[UIView alloc] init];
        _delive2View.backgroundColor = YBMainViewControlerBackgroundColor;
    }
    return _delive2View;
}
- (UIView *)delive3View
{
    if (_delive3View==nil) {
        _delive3View = [[UIView alloc] init];
        _delive3View.backgroundColor = YBMainViewControlerBackgroundColor;
        _delive3View.alpha = 0.5;
    }
    return _delive3View;
}

- (instancetype)initWithFrame:(CGRect)frame signUpSuccessClass:(YBSignUpSuccessRootClass *)signUpSuccessClass
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.signUpSuccessClass = signUpSuccessClass;
        
        [self addUI];
        
        [self configeUI];
        
        [self setupUI];
    }
    
    return self;
    
}

- (void)addUI {
    
    _topImageView = [[UIImageView alloc] init];
    [self addSubview:_topImageView];
    
    [self addSubview:self.delive1View];
    
    _midView = [[UIView alloc] init];
    _midView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_midView];
    
    _iconImgView = [[UIImageView alloc] init];
    [_midView addSubview:_iconImgView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:12];

    [_midView addSubview:_nameLabel];
    
    _payMoneyLabel = [[UILabel alloc] init];
    _payMoneyLabel.font = [UIFont systemFontOfSize:12];

    [_midView addSubview:_payMoneyLabel];
    
    _typeLabel = [[UILabel alloc] init];
    _typeLabel.font = [UIFont systemFontOfSize:12];

    [_midView addSubview:_typeLabel];
    
    _payTypeLabel = [[UILabel alloc] init];
    _payTypeLabel.font = [UIFont systemFontOfSize:12];

    [_midView addSubview:_payTypeLabel];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:12];

    [_midView addSubview:_timeLabel];
    
    _cancleBtn = [[UIButton alloc] init];
    [_cancleBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    _cancleBtn.backgroundColor = [UIColor whiteColor];
    [_cancleBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _cancleBtn.layer.masksToBounds = YES;
    _cancleBtn.layer.cornerRadius = 3;
    _cancleBtn.layer.borderWidth = 1;
    _cancleBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [_cancleBtn addTarget:self action:@selector(cancleBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [_midView addSubview:_cancleBtn];
    
    [self addSubview:self.delive2View];
    
    _successContentLb = [[UILabel alloc] init];
    _successContentLb.font = [UIFont systemFontOfSize:12];

    _barCodeView = [[UIImageView alloc] init];
    _orderNumLb = [[UILabel alloc] init];
    _orderNumLb.font = [UIFont systemFontOfSize:12];

    _dataExplainLb = [[UILabel alloc] init];
    _dataExplainLb.font = [UIFont systemFontOfSize:12];

    _dataExplainContentLb = [[UILabel alloc] init];
    _dataExplainContentLb.font = [UIFont systemFontOfSize:12];

    _barCodeUseExplainLb = [[UILabel alloc] init];
    _barCodeUseExplainLb.font = [UIFont systemFontOfSize:12];

    _barCodeUseExplainContentLb = [[UILabel alloc] init];
    _barCodeUseExplainContentLb.font = [UIFont systemFontOfSize:12];

    _messageLabel= [[UILabel alloc] init];
    _messageLabel.font = [UIFont systemFontOfSize:12];
    
    [self addSubview:_successContentLb];
    [self addSubview:_barCodeView];
    [self addSubview:_orderNumLb];
    [self addSubview:_dataExplainLb];
    [self addSubview:_dataExplainContentLb];
    [self addSubview:_barCodeUseExplainLb];
    [self addSubview:_barCodeUseExplainContentLb];
    [self addSubview:_messageLabel];
    
    [self addSubview:self.delive3View];
    
}

- (void)cancleBtnDidClick
{
    NSString *message = [NSString stringWithFormat:@"您确定要取消报名%@%@吗?",self.signUpSuccessClass.data.applyschoolinfo.name,self.signUpSuccessClass.data.applyclasstypeinfo.name];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"取消订单" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==1) {
        
        NSLog(@"%s",__func__);
        NSString *url = [NSString stringWithFormat:kusercancelorder,[AcountManager manager].userid];
        NSString *applyUrlString = [NSString stringWithFormat:BASEURL,url];
        [JENetwoking startDownLoadWithUrl:applyUrlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
            
            NSString *type = [NSString stringWithFormat:@"%@",data[@"type"]];
            
            if ([type isEqualToString:@"1"]) {
                
                [self obj_showTotasViewWithMes:@"取消成功"];
                
                [self.parentViewController.navigationController popToRootViewControllerAnimated:YES];
                
            }else{
                
                [self obj_showTotasViewWithMes:data[@"msg"]];

            }
            
        } withFailure:^(id data) {
            
            
        }];
        
    }
    
}

- (void)configeUI {
    
    
    _successContentLb.textColor = [UIColor lightGrayColor];
    _successContentLb.text = [NSString stringWithFormat:@"请您与%@之前携带资料前往您所报名的驾校确认报名信息，支付报名费用",self.signUpSuccessClass.data.endapplytime];
   
    NSString *applyUrlStr = [NSString stringWithFormat:BASEURL,kCreatQrcode];
    NSString *scanaiditurl = [NSString stringWithFormat:@"%@?text=%@&size=10",applyUrlStr,self.signUpSuccessClass.data.scanauditurl];
    NSLog(@"scanaiditurl:%@",scanaiditurl);
    [_barCodeView sd_setImageWithURL:[NSURL URLWithString:scanaiditurl]];
    _barCodeView.backgroundColor = [UIColor lightGrayColor];

    _messageLabel.textColor = [UIColor grayColor];
    _messageLabel.text = @"(扫码提交报名信息)";
    
    _orderNumLb.text = [NSString stringWithFormat:@"您的报名订单编码为:%@",self.signUpSuccessClass.data.orderid];
    _orderNumLb.textColor = [UIColor redColor];
    
    _dataExplainLb.text = @"携带资料说明:";
    _dataExplainLb.textColor = [UIColor colorWithHexString:@"6e6e6e"];
    _dataExplainLb.font = [UIFont boldSystemFontOfSize:13];
    
    _dataExplainContentLb.text = @"去驾校缴费时请携带身份证，体检表，户口本，报名电子订单，相关流程如有疑问，请直接致电400-101-6669";
    _dataExplainContentLb.textColor = [UIColor lightGrayColor];
    _dataExplainContentLb.font = [UIFont systemFontOfSize:12];
    
    _barCodeUseExplainLb.text = @"订单二维码使用说明:";
    _barCodeUseExplainLb.textColor = [UIColor colorWithHexString:@"6e6e6e"];
    _barCodeUseExplainLb.font = [UIFont boldSystemFontOfSize:13];
    
    _barCodeUseExplainContentLb.text = @"在确认订单信息时，只需将此二维码提供给驾校工作人员即可，由工作人员扫描二维码，确认报名信息。";
    _barCodeUseExplainContentLb.textColor = [UIColor lightGrayColor];
    _barCodeUseExplainContentLb.font = [UIFont systemFontOfSize:12];
    
    _topImageView.image = [UIImage imageNamed:@"payoffline_success"];
    
    [_iconImgView sd_setImageWithURL:[NSURL URLWithString:self.signUpSuccessClass.data.schoollogoimg] placeholderImage:[UIImage imageNamed:@"background_mine"]];

    _nameLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.text = [NSString stringWithFormat:@"%@",self.signUpSuccessClass.data.applyschoolinfo.name];

    NSString *num1 = @"实付款:";
    NSInteger range1 = [num1 length];
    NSString *num2 = [NSString stringWithFormat:@"¥%ld",(long)self.signUpSuccessClass.data.applyclasstypeinfo.onsaleprice];
    NSInteger range2 = [num2 length];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",num1,num2]];
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"6e6e6e"] range:NSMakeRange(0, range1)];
    [attStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(0, range1)];
    [attStr addAttribute:NSForegroundColorAttributeName value:YBNavigationBarBgColor range:NSMakeRange(range1, range2+1)];
    _payMoneyLabel.attributedText = attStr;
    
    _typeLabel.font = [UIFont systemFontOfSize:12];
    _typeLabel.textColor = [UIColor lightGrayColor];
    _typeLabel.text = [NSString stringWithFormat:@"%@",self.signUpSuccessClass.data.applyclasstypeinfo.name];

    _payTypeLabel.font = [UIFont systemFontOfSize:12];
    _payTypeLabel.textColor = [UIColor lightGrayColor];
    _payTypeLabel.text = [NSString stringWithFormat:@"%@",[self getpayType]];

    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor lightGrayColor];
    _timeLabel.text = [NSString stringWithFormat:@"%@",self.signUpSuccessClass.data.applytime];
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            label.numberOfLines = 0;
        }
    }
 
    if (self.signUpSuccessClass.data.applystate==2) {
        self.cancleBtn.userInteractionEnabled = NO;
        self.cancleBtn.hidden = YES;
    }
    
}

- (NSString *)getpayType
{
    //     "paytype": "支付 1 线下支付， 2 线上支付",
    if (self.signUpSuccessClass.data.paytype==1) {
        return @"线下支付";
    }else if (self.signUpSuccessClass.data.paytype==2){
        return @"线上支付";
    }
    return @"";
}

- (void)setupUI {
    
    __weak typeof(self) weakSelf = self;
    
    [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(175);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }]; 
    
    [self.delive1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.topImageView.mas_bottom);
        make.height.mas_equalTo(10);
    }];
    
    [_midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_topImageView.mas_bottom).offset(10);
        make.height.mas_equalTo(110);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(110/2-60/2);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(60);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.iconImgView.mas_top).offset(-5);
        make.left.mas_equalTo(weakSelf.iconImgView.mas_right).offset(10);
    }];
    [_nameLabel sizeToFit];

    [_payMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLabel.mas_top);
        make.right.mas_equalTo(-20);
    }];
    [_payMoneyLabel sizeToFit];

    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.nameLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(weakSelf.nameLabel.mas_left);
    }];
    [_typeLabel sizeToFit];

    [_payTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.nameLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(-10);
    }];
    [_payTypeLabel sizeToFit];

    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.typeLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(weakSelf.nameLabel.mas_left);
    }];
    [_timeLabel sizeToFit];

    [_cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.typeLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(21);
    }];
    
    [self.delive2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.midView.mas_bottom);
        make.height.mas_equalTo(10);
    }];
    
    [_successContentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(_delive2View.mas_bottom).offset(11);
        make.width.mas_equalTo(weakSelf.frame.size.width -20);
    }];
    [_successContentLb sizeToFit];
    
    [_barCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.mas_equalTo(_successContentLb.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(120, 120));
    }];
    
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.mas_equalTo(_barCodeView.mas_bottom);
    }];
    [_messageLabel sizeToFit];
    
    [_orderNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.mas_equalTo(_messageLabel.mas_bottom).offset(10);
    }];
    [_orderNumLb sizeToFit];
    
    [self.delive3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(_orderNumLb.mas_bottom).offset(10);
        make.height.mas_equalTo(0.5);
    }];
    
    [_barCodeUseExplainLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(_delive3View.mas_bottom).offset(10);
    }];
    [_barCodeUseExplainLb sizeToFit];
    
    [_barCodeUseExplainContentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(_barCodeUseExplainLb.mas_bottom).offset(7);
        make.width.mas_equalTo(weakSelf.frame.size.width -20);
    }];
    
    [_dataExplainLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(_barCodeUseExplainContentLb.mas_bottom).offset(10);
    }];
    [_dataExplainLb sizeToFit];
    
    [_dataExplainContentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(_dataExplainLb.mas_bottom).offset(7);
        make.width.mas_equalTo(weakSelf.frame.size.width - 20);
    }];
    [_dataExplainContentLb sizeToFit];
    
}

- (CGFloat)successViewH
{
    return 420+110+175+20;
}
@end
