//
//  PrivateMessageController.m
//  Magic
//
//  Created by ytzhang on 15/11/10.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "PrivateMessageController.h"
#import "PrivateMessageCell.h"
#import "finishMessageView.h"
#import "ToolHeader.h"
#import "MagicMainTableViewController.h"
#import "InfoModel.h"
#import "MyWalletViewController.h"
#import "UIColor+Hex.h"

static NSString *const kMyInfotUrl = @"userinfo/getuserinfo?userid=%@&usertype=1";
static NSString *const kBuyproduct =  @"userinfo/buyproduct";

@interface PrivateMessageController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation PrivateMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加取消键盘的手势
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    // 初始化数组
    self.cellArray = [NSMutableArray array];
    self.textFiledArray = [NSMutableArray array];
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self initUI];
    [self addBottomView];
    // 去除多余的线
    [self cleaExtraLine];
    

}

-(void)keyboardHide:(UITapGestureRecognizer*)tap
{
    UITextField *textFiledOne = [_textFiledArray objectAtIndex:0];
    UITextField *textFiledTwo = [_textFiledArray objectAtIndex:1];
    UITextField *textFiledThree = [_textFiledArray objectAtIndex:2];
    [textFiledOne resignFirstResponder];
    [textFiledTwo resignFirstResponder];
    [textFiledThree resignFirstResponder];
}
- (void)initUI
{
    // 创建头部试图
    CGFloat kwight = self.view.bounds.size.width;
    CGFloat khight = 50;
    CGFloat messageLabelW = 100;
    CGFloat messageLabelX = (self.view.frame.size.width - messageLabelW) / 2;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kwight, khight)];
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(messageLabelX, khight - 15, messageLabelW, 10)];
    messageLabel.font = [UIFont systemFontOfSize:13.f];
    messageLabel.text = @"收件人信息";
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.textColor = [UIColor lightGrayColor];
    
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, messageLabel.frame.origin.y + 15, kwight, 0.5)];
    lineView.backgroundColor = [UIColor blackColor];
    
    [headerView addSubview:lineView];
    [headerView addSubview:messageLabel];
    
    
    headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headerView;
 
}
// 点击确认购买按钮
#pragma mark -----加载底部View
- (void)addBottomView
{
    // 加载底部View
    _bottomView = [LTBottomView instanceBottomView];
    _didClickBtn = [_bottomView viewWithTag:102];
    // 取出积分的Label
    UILabel *numberLabel = [_bottomView viewWithTag:103];
    NSUserDefaults *defaules = [NSUserDefaults standardUserDefaults];
    NSString *walletstr = [defaules objectForKey:@"walletStr"];
    numberLabel.text = walletstr;
    [_didClickBtn setTitle:@"确认购买" forState:UIControlStateNormal];
    
    CGFloat kWight = [UIScreen mainScreen].bounds.size.width;
    CGFloat kHight = [UIScreen mainScreen].bounds.size.height;
    CGFloat kbottonViewh = 50;
    _bottomView.frame = CGRectMake(0,kHight - 50 , kWight, kbottonViewh);
    _bottomView.tag = 200;
    [self.view addSubview:_bottomView];
    
    
}


- (void)backMainView:(UIButton *)btn
{
    [_finishView removeFromSuperview];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}
- (void)cleaExtraLine
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
}
- (void)backAction:(UIButton *)btn
{
        self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.automaticallyAdjustsScrollViewInsets = YES;

    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 字符数组
    NSArray *strArray = [[NSArray alloc] initWithObjects:@"姓名",@"电话",@"地址", nil];
    // tag数组
    NSArray *tagArray = @[@200,@201,@202];
    
    static NSString *definition = @"myCell";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered)
        {
            UINib *nib = [UINib nibWithNibName:@"PrivateMessageCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:definition];
            nibsRegistered = YES;
        }
        _cell = [tableView dequeueReusableCellWithIdentifier:definition];

    
    // 添加当开始输入通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectorCell:) name:UITextFieldTextDidBeginEditingNotification object:_cell.messageTextField];
    
    // 添加值改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeEndValue:) name:UITextFieldTextDidEndEditingNotification object:_cell.messageTextField];
  UILabel *label = [_cell viewWithTag:101];
    label.text = [strArray objectAtIndex:indexPath.row];
    _cell.tag = [tagArray[indexPath.row]intValue];
    
    [_cellArray addObject:_cell];
    [_textFiledArray addObject:_cell.messageTextField];
      return _cell;
    }

- (void)selectorCell:(NSNotification *)notification
{
    
    UITableViewCell *cellOne = [_cellArray objectAtIndex:0];
    UITableViewCell *cellTwo = [_cellArray objectAtIndex:1];
    UITableViewCell *cellThree = [_cellArray objectAtIndex:2];
    //获得textfield
    UITextField *textField = notification.object;
    UITableViewCell *selectorCell = (UITableViewCell *)[[textField superview] superview];
    if (selectorCell.tag == 200)
    {
        cellOne.selected = YES;
        cellTwo.selected = NO;
        cellThree.selected = NO;
    }else if (selectorCell.tag == 201)
    {
        cellOne.selected = NO ;
        cellTwo.selected = YES;
        cellThree.selected = NO;
    }else
    {
        cellOne.selected = NO;
        cellTwo.selected = NO;
        cellThree.selected = YES;
    }
    
    }



- (void)changeEndValue:(NSNotification *)notification
{
    UITextField *textFiledOne = [_textFiledArray objectAtIndex:0];
    UITextField *textFiledTwo = [_textFiledArray objectAtIndex:1];
    UITextField *textFiledThree = [_textFiledArray objectAtIndex:2];
    
    //获得textfield
    textFiledTwo.keyboardType = UIKeyboardTypeNumberPad;

    NSString *phoneNum = textFiledTwo.text;
    NSString *regex = @"^((17[0-9])|(13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:phoneNum];
    if (!isMatch) {
        [self showTotasViewWithMes:@"请输入正确的手机号"];
        return;
    }

    
    _didClickBtn.enabled =  textFiledOne.text.length != 0 && textFiledTwo.text.length != 0 && textFiledThree.text.length != 0 ;
    if ( _didClickBtn.enabled == 1) {
        [ _didClickBtn setBackgroundColor:[UIColor colorWithHexString:@"ff5d35"]];
        [ _didClickBtn addTarget:self action:@selector(pushFinshView:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [ _didClickBtn setBackgroundColor:[UIColor grayColor]];
    }
}
- (void)pushFinshView:(UIButton *)btn
{
    UITextField *textFiledOne = [_textFiledArray objectAtIndex:0];
    UITextField *textFiledTwo = [_textFiledArray objectAtIndex:1];
    UITextField *textFiledThree = [_textFiledArray objectAtIndex:2];

    NSString *urlString = [NSString stringWithFormat:BASEURL,kBuyproduct];
    NSLog(@"urlString = %@",urlString);
    
    // 当点击购买时向后台传送数据
    NSString *useId = [AcountManager manager].userid;
    NSString *productId =  _shopId;
    NSDictionary *dic = @{@"usertype":@"1",
                          @"userid":useId,
                          @"productid":productId,
                          @"name":textFiledOne.text,
                          @"mobile":textFiledTwo.text,
                          @"address":textFiledThree.text};

    
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:dic WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        //刷新数据
        for (UIViewController *viewCon in self.navigationController.viewControllers) {
            if ([viewCon isKindOfClass:[MyWalletViewController class]]) {
                MyWalletViewController *myWalletVC = (MyWalletViewController *)viewCon;
                [myWalletVC refreshWalletData];
            }
            
        }
        
    }  withFailure:^(id data) {
        NSLog(@"errorData = %@",data);
    }];
    
    
    
    

 _finishView =  [finishMessageView instanceBottomView];
    
    CGFloat kW = self.tableView.bounds.size.width;
    CGFloat kH = self.tableView.bounds.size.height;
    _finishView.frame = CGRectMake(0, 0, kW, kH);
    _finishView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.85];
  UIButton *button =   [_finishView viewWithTag:100];
    self.navigationController.navigationBar.hidden = YES;
    [button addTarget:self action:@selector(backMainView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_finishView];
    
}


// 使Cell的分割线靠近最左边
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
#pragma mark --- Lazy加载
- (UITableView *)tableView
{
    if (!_tableView) {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 114) style:UITableViewStylePlain];
    }
    return _tableView;
}

@end
