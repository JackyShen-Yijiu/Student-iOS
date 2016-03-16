//
//  JZPayWayController.m
//  studentDriving
//
//  Created by ytzhang on 16/3/15.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZPayWayController.h"

#import "JZPayWayHeaderCell.h"
#import "JZSignUpCell.h"
#import "JZPayWayFooterCell.h"
#import "JGPayTool.h"
#import "DVVPaySuccessController.h"
#import "YBOrderListViewController.h"
#import "SignUpSuccessViewController.h"

@interface JZPayWayController ()<UITableViewDataSource,UITableViewDelegate,JZPayWayDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

// 有Y码时显示
@property (nonatomic, strong) UIView *moreShowYBGView;

@property (nonatomic, strong) UIView *topMoreView;

@property (nonatomic, strong) UIView *bottomMoreView;

@property (nonatomic, strong) UILabel *topLabel;

@property (nonatomic, strong) UILabel *bottomLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *otherHeaderView;

// 底部UIButton
@property (nonatomic, strong) UIView *btnBG;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

// 数据源数据
@property (nonatomic, strong) NSArray *middhtTitleArray;
@property (nonatomic, strong) NSArray *midDesArray;

@property (nonatomic, strong) NSArray *imgArray;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *desArray;
@property (nonatomic, strong) NSArray *tagArray;
@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, assign) NSInteger tag;

@end

@implementation JZPayWayController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBColor(226, 226, 233);
    [self.view addSubview:self.tableView];
    [self initUI];
    [self initData];
    
    self.title = @"费用支付";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weixinPaySuccess) name:weixinpaySuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weixinPayError) name:weixinpayErrorNotification object:nil];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
}

- (void)back
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"退出支付" message:@"您还没有支付成功,确定要退出支付吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        
        // 报名成功时清除
        NSUserDefaults *defauts = [NSUserDefaults standardUserDefaults];
        [defauts setObject:@"" forKey:@"SignUp"];
        
        YBOrderListViewController *vc = [[YBOrderListViewController alloc] init];
        vc.isPaySuccess = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        [AcountManager saveUserApplyState:@"1"];
        
    }
}

- (void)initUI{
    [self.btnBG addSubview:self.leftButton];
    [self.btnBG addSubview:self.rightButton];
    [self.view addSubview:self.btnBG];
}
- (void)initData{
    /* _extraDict = {
     "__v": 0,
     "paymoney": 4700,
     //支付金额"payendtime": "2016-02-03T12:29:49.423Z",
     "creattime": "2016-01-31T12:29:49.423Z",
     "userid": "564e1242aa5c58b901e4961a",
     "_id": "56adfe3d323ed17278e71914",
     订单id"discountmoney": 0,
     "applyclasstypeinfo": {
     "onsaleprice": 4700,
     "price": 4700,
     "name": "一步互联网驾校快班",
     "id": "562dd1fd1cdf5c60873625f3"
     },
     "applyschoolinfo": {
     "name": "一步互联网驾校",
     "id": "562dcc3ccb90f25c3bde40da"
     },
     "paychannel": 0,
     userpaystate": 0订单状态//0订单生成1开始支付2支付成功3支付失败4订单取消 //支付方式"
     }
     */

    // 中部cell赋值
    if (_isHaveYCode) {
        self.middhtTitleArray = @[@"报考班型",@"支付费用",@"Y码返现",@"邀请码"];
        self.midDesArray = @[self.extraDict[@"applyclasstypeinfo"][@"name"],[NSString stringWithFormat:@"%@¥",self.extraDict[@"applyclasstypeinfo"][@"price"]],self.yCodeStr,@"请输入或扫描邀请码(选填)"];
    }else if (!_isHaveYCode){
        self.middhtTitleArray = @[@"报考班型",@"支付费用",@"邀请码"];
        self.midDesArray = @[self.extraDict[@"applyclasstypeinfo"][@"name"],[NSString stringWithFormat:@"%@¥",self.extraDict[@"applyclasstypeinfo"][@"price"]],@"请输入或扫描邀请码(选填)"];
    }
    // 底部cell赋值
    self.imgArray = @[@"wechat",@"alipay",@"offline"];
    self.titleArray = @[@"微信支付",@"支付宝支付",@"现场支付"];
    self.desArray = @[@"推荐开通微信支付的用户使用",@"推荐开通支付宝的用户使用",@"到指定现场了解更多后支付"];
    self.tagArray = @[@"1000",@"1001",@"1002"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (0 == section) {
        return 0;
    }
    if (2 == section) {
        if (_isHaveYCode) {
            return 72;
        }else if (!_isHaveYCode){
            return 60;
        }
        
    }
    return 20;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (2 == section) {
        if (_isHaveYCode) {
            [self.topMoreView addSubview:self.topLabel];
            [self.moreShowYBGView addSubview:self.topMoreView];
            [self.bottomMoreView addSubview:self.bottomLabel];
            [self.bottomMoreView addSubview:self.lineView];
            [self.moreShowYBGView addSubview:self.bottomMoreView];
            
            return self.moreShowYBGView;

        }else if(!_isHaveYCode){
            [self.moreShowYBGView addSubview:self.topMoreView];
            [self.bottomMoreView addSubview:self.bottomLabel];
            [self.bottomMoreView addSubview:self.lineView];
            [self.moreShowYBGView addSubview:self.bottomMoreView];
            return self.moreShowYBGView;
        }
            }
    return self.otherHeaderView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0 == section) {
        return 1;
    }
    if (1 == section) {
        if (_isHaveYCode) {
            // 有Y码
            return 4;
        }
        else{
            return 3;
        }

    }
    if (2 == section) {
        return 3;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        return 122;
    }
    if (1 == indexPath.section) {
        return 44;
    }
    if (2 == indexPath.section) {
        return 54;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        // 加载头部Cell
        static NSString *payHeaderID = @"payHeaderID";
        JZPayWayHeaderCell *payWayeHeaderCell = [tableView dequeueReusableCellWithIdentifier:payHeaderID];
        if (!payWayeHeaderCell) {
            payWayeHeaderCell = [[JZPayWayHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:payHeaderID];
        }
        payWayeHeaderCell.extraDict = self.extraDict;
        return payWayeHeaderCell;
    }
    if (1 == indexPath.section) {
        // 加载中部Cell
        static NSString *payMightID = @"payMightID";
        JZSignUpCell *signUpCell = [tableView dequeueReusableCellWithIdentifier:payMightID];
        if (!signUpCell) {
            signUpCell = [[JZSignUpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:payMightID];
        }
        // textFiled 不能编辑
        if (_isHaveYCode) {
            if (0 == indexPath.row || 1 == indexPath.row || 2 == indexPath.row) {
                signUpCell.desTextFiled.enabled = NO;
            }
        } else if (!_isHaveYCode){
            if (0 == indexPath.row || 1 == indexPath.row) {
                signUpCell.desTextFiled.enabled = NO;
            }
        }
        // 设置价格字体为主题色
        if (1 == indexPath.row) {
            signUpCell.desTextFiled.textColor = YBNavigationBarBgColor;
        }
        // 隐藏右侧箭头
        signUpCell.arrowImageView.hidden = YES ;

        // 设置数据
        signUpCell.titleLabel.text = self.middhtTitleArray[indexPath.row];
        signUpCell.desTextFiled.text = self.midDesArray[indexPath.row];
            return signUpCell;
    }
    if (2 == indexPath.section) {
        // 加载低部Cell
        static NSString *payFooterID = @"payFooterID";
        JZPayWayFooterCell *payWayFooterCell = [tableView dequeueReusableCellWithIdentifier:payFooterID];
        if (!payWayFooterCell) {
            payWayFooterCell = [[JZPayWayFooterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:payFooterID];
        }
        // cell赋值
        NSString *imgStr = self.imgArray[indexPath.row];
        payWayFooterCell.payWayIcon.image = [UIImage imageNamed:imgStr];
        payWayFooterCell.payWayLabel.text = self.titleArray[indexPath.row];
        payWayFooterCell.desPayWay.text = self.desArray[indexPath.row];
        payWayFooterCell.payWayButton.tag = [self.tagArray[indexPath.row] integerValue];
        [self.btnArray addObject:payWayFooterCell.payWayButton];
        payWayFooterCell.delegate = self;
        NSLog(@"imgStr = %@,payWayFooterCell.payWayLabel.text = %@,payWayFooterCell.desPayWay.text = %@",imgStr,self.titleArray[indexPath.row],payWayFooterCell.desPayWay.text);
        return payWayFooterCell;
    }

    
    return nil;
    
}
#pragma   mark ------   action Target
- (void)didRight:(UIButton *)btn{
    NSLog(@"_ben =%ld",_tag);
    if ( !(_tag == 1000) && !(_tag == 1001) && !(_tag == 1002) ) {
        [self obj_showTotasViewWithMes:@"请选择支付方式!"];
        return;
    }
    // 确认支付
    if (_tag == 1000) {
        
        [self pay:WeChatPay];
        
    }
    if (_tag == 1001) {
        // 支付宝支付
        [self pay:AlixPay];

    }
    if (_tag == 1002) {
        // 线下支付
        SignUpSuccessViewController *vc = [[SignUpSuccessViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (void)pay:(payType)paytype
{
    NSLog(@"_extraDict:%@",_extraDict);
    NSLog(@"self.dmData.price:%ld",(long)self.dmData.price);
    
    
    
    
    
    
    /* _extraDict = {
        "__v": 0,
        "paymoney": 4700,
        //支付金额"payendtime": "2016-02-03T12:29:49.423Z",
        "creattime": "2016-01-31T12:29:49.423Z",
        "userid": "564e1242aa5c58b901e4961a",
        "_id": "56adfe3d323ed17278e71914",
        订单id"discountmoney": 0,
        "applyclasstypeinfo": {
            "onsaleprice": 4700,
            "price": 4700,
            "name": "一步互联网驾校快班",
            "id": "562dd1fd1cdf5c60873625f3"
        },
        "applyschoolinfo": {
            "name": "一步互联网驾校",
            "id": "562dcc3ccb90f25c3bde40da"
        },
        "paychannel": 0,
        userpaystate": 0订单状态//0订单生成1开始支付2支付成功3支付失败4订单取消 //支付方式"
    }
*/
    
    /*
    
     {
     "__v" = 0;
     "_id" = 56e82044a9f1542a1c7053dc;
     applyclasstypeinfo =     {
     id = 56aecf9b70667d997fda6247;
     name = "\U6d4b\U8bd5\U73ed\U578b \U8df3\U697c\U4ef7";
     onsaleprice = 1;
     price = 1;
     };
     applyschoolinfo =     {
     id = 562dcc3ccb90f25c3bde40da;
     name = "\U4e00\U6b65\U4e92\U8054\U7f51\U9a7e\U6821";
     };
     couponcode = "";
     creattime = "2016-03-15T14:46:28.184Z";
     discountmoney = 0;
     paychannel = 0;
     payendtime = "2016-03-18T14:46:28.184Z";
     paymoney = 1;
     userid = 56e802cfcd82196b068682e4;
     userpaystate = 0;
     weixinpayinfo = "";
     }
     
     */
    // 描述
    NSString *desStr = [NSString stringWithFormat:@"%@ %@",_extraDict[@"applyclasstypeinfo"][@"name"],_extraDict[@"applyschoolinfo"][@"name"]];
    
    [JGPayTool payWithPaye:paytype tradeNO:_extraDict[@"_id"] parentView:self price:[NSString stringWithFormat:@"%ld",(long)self.dmData.price] title:_extraDict[@"applyclasstypeinfo"][@"name"] description:desStr success:^(NSString *str) {
        
        // 支付宝支付成功回调
        [self weixinPaySuccess];
        
    } error:^(NSString *str) {
        
        NSLog(@"支付失败");
        [self obj_showTotasViewWithMes:@"支付失败"];
        [self weixinPayError];
    }];
}

- (void)weixinPaySuccess{
    
    [self obj_showTotasViewWithMes:@"支付成功"];

    // 报名成功时清除
    NSUserDefaults *defauts = [NSUserDefaults standardUserDefaults];
    [defauts setObject:@"" forKey:@"SignUp"];
    
    DVVPaySuccessController *vc = [DVVPaySuccessController new];
    vc.isPaySuccess = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    [AcountManager saveUserApplyState:@"2"];
    
}

- (void)weixinPayError{
    
    [self obj_showTotasViewWithMes:@"支付失败"];
    
    // 报名成功时清除
    NSUserDefaults *defauts = [NSUserDefaults standardUserDefaults];
    [defauts setObject:@"" forKey:@"SignUp"];
    
    YBOrderListViewController *vc = [[YBOrderListViewController alloc] init];
    vc.isPaySuccess = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    [AcountManager saveUserApplyState:@"1"];
    
}

#pragma mark ---- 支付方式代理方法
- (void)initWithPayWay:(UIButton *)btn{
    for (UIButton *sender in self.btnArray) {
        if (btn.tag == sender.tag ) {
            btn.selected = YES;
            self.tag = btn.tag;
        }else{
            sender.selected = NO;
        }
    }
}
#pragma mark ---- Lazy 加载

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight - 64 - 48 - 5 ) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource  = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
// 有Y码时展示
- (UIView *)moreShowYBGView{
    if (_moreShowYBGView == nil) {
        if (_isHaveYCode) {
            _moreShowYBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 72)];
        } else if(!_isHaveYCode){
             _moreShowYBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 60)];
        }
        _moreShowYBGView.backgroundColor = [UIColor clearColor];
    }
    return _moreShowYBGView;
}
- (UIView *)topMoreView{
    if (_topMoreView == nil) {
        
        if (_isHaveYCode) {
            _topMoreView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.moreShowYBGView.width, 32)];
                    }
        else if(!_isHaveYCode){
           _topMoreView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.moreShowYBGView.width, 20)];
        }
        
        _topMoreView.backgroundColor = RGBColor(226, 226, 233);
    }
    return _topMoreView;
}
- (UIView *)bottomMoreView{
    if (_bottomMoreView == nil) {
        _bottomMoreView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topMoreView.frame), self.moreShowYBGView.width, 40)];
        _bottomMoreView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomMoreView;
}
- (UILabel *)topLabel{
    if (_topLabel == nil) {
        CGFloat margin = 16;
        _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 10, kSystemWide - 2 * margin, 12)];
        _topLabel.text = @"金额会驾校通过您的报名信息后自动存入我的钱包";
        _topLabel.font = [UIFont systemFontOfSize:12];
        _topLabel.textColor = RGBColor(156, 156, 156);
    }
    return _topLabel;
}
- (UILabel *)bottomLabel{
    if (_bottomLabel == nil) {
        CGFloat margin = 16;
        _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 13, kSystemWide - 2 * margin, 14)];
        _bottomLabel.text = @"付款方式";
        _bottomLabel.font = [UIFont systemFontOfSize:14];
        _bottomLabel.textColor = RGBColor(91, 91, 91);
    }
    return _bottomLabel;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, kSystemWide, 1)];
        _lineView.backgroundColor = HM_LINE_COLOR;
    }
    return _lineView;
}

- (UIView *)otherHeaderView{
    if (_otherHeaderView == nil) {
        _otherHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0 , 0 , kSystemWide, 20)];
        _otherHeaderView.backgroundColor = RGBColor(226, 226, 233);
    }
    return _otherHeaderView;
}
// 底部按钮控件
- (UIView *)btnBG{
    if (_btnBG == nil) {
        _btnBG = [[UIView alloc] initWithFrame:CGRectMake(0, kSystemHeight - 64 - 48, kSystemWide, 48)];
        _btnBG.backgroundColor = [UIColor clearColor];
    }
    return _btnBG;
}
- (UIButton *)leftButton{
    if (_leftButton == nil) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectMake(0 , 0 , kSystemWide / 2, 48);
        NSString *title = [NSString stringWithFormat:@"合计 ¥%lu",self.dmData.price];
        [_leftButton setTitle:title forState:UIControlStateNormal];
        _leftButton.backgroundColor = [UIColor whiteColor];
        [_leftButton setTitleColor:RGBColor(91, 91, 91)forState:UIControlStateNormal];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _leftButton;
}
- (UIButton *)rightButton{
    if (_rightButton == nil) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
         _rightButton.frame = CGRectMake(kSystemWide / 2 , 0 , kSystemWide / 2, 48);
         _rightButton.backgroundColor = YBNavigationBarBgColor;
        [_rightButton setTitle:@"确认支付" forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightButton addTarget:self action:@selector(didRight:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}
// 初始化数组
//- (NSArray *)middhtTitleArray{
//    if (_middhtTitleArray == nil) {
//        _middhtTitleArray = [NSArray array];
//    }
//    return _middhtTitleArray;
//}
//- (NSArray *)midDesArray{
//    if (_midDesArray == nil) {
//        _midDesArray = [NSArray array];
//    }
//    return _midDesArray;
//}
//
//- (NSArray *)imgArray{
//    if (_imgArray == nil) {
//        _imgArray = [NSArray array];
//    }
//    return _imgArray;
//}
//
//- (NSArray *)titleArray{
//    if (_titleArray == nil) {
//        _titleArray = [NSArray array];
//    }
//    return _titleArray;
//}
//- (NSArray *)desArray{
//    if (_desArray == nil) {
//        _desArray = [NSArray array];
//    }
//    return _desArray;
//}
//- (NSArray *)tagArray{
//    if (_tagArray == nil) {
//        _tagArray = [NSArray array];
//    }
//    return _tagArray;
//}
- (NSMutableArray *)btnArray{
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

@end
