//
//  VirtualViewController.m
//  TestShop
//
//  Created by ytzhang on 15/12/19.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "VirtualViewController.h"
#import "ToolHeader.h"
#import "MyWalletViewController.h"
#import "UIColor+Hex.h"
#import "MagicMainTableViewController.h"

static NSString *const kBuyproduct =  @"userinfo/buyproduct";

static NSString *const knumber = @"create_qrcode";
@interface VirtualViewController ()

@property (nonatomic,strong) UILabel *successLabel;
@property (nonatomic,strong) UILabel *upLabel;
@property (nonatomic,strong) UIImageView *numberImageView;
@property (nonatomic,strong) UILabel *downLabel;
@property (nonatomic,strong) UIButton *finishButton;
@property (nonatomic,strong) NSString *numberStr;

@end

@implementation VirtualViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    [self initData];
    
    
}
// 加载数据
- (void)initData
{
    NSString *urlString = [NSString stringWithFormat:BASEURL,kBuyproduct];
    NSLog(@"urlString = %@",urlString);
    
    // 当点击购买时向后台传送数据
    NSString *useId = [AcountManager manager].userid;
    NSString *productId =  _shopId;
    NSDictionary *dic = @{@"usertype":@"1",
                          @"userid":useId,
                          @"productid":productId
                          };

    
    [JENetwoking startDownLoadWithUrl:urlString postParam:dic WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        if (data == nil) {
            return ;
        }
    NSInteger type = [[data objectForKey:@"type"] integerValue];
    if (type == 1)
        {
            //刷新数据
            for (UIViewController *viewCon in self.navigationController.viewControllers) {
                if ([viewCon isKindOfClass:[MyWalletViewController class]]) {
                    MyWalletViewController *myWalletVC = (MyWalletViewController *)viewCon;
                    [myWalletVC refreshWalletData];
                }
                
            }
            NSDictionary *dic = [data objectForKey:@"extra"];
            NSString *resultStr = [NSString stringWithFormat:BASEURL,knumber];
            NSString *str = @"?text=";
            NSString *lastStr = @"&size=10";
            NSString *finishResultStr = [NSString stringWithFormat:@"%@%@%@%@",resultStr,str,[dic objectForKey:@"orderscanaduiturl"],lastStr];
            self.numberStr = finishResultStr;
             _successLabel.text = @"兑换成功!";
            [self refreshData];
        }
            else
        {
         NSString *messageStr = [data objectForKey:@"msg"];
            
            [self showTotasViewWithMes:messageStr];
            _successLabel.text = @"兑换失败!";
            _numberImageView.image = [UIImage imageNamed:@"cha"];
        }
        
        
        
    }  withFailure:^(id data) {
       [self showTotasViewWithMes:@"订单交易失败"];
        _successLabel.text = @"兑换失败!";
        _numberImageView.image = [UIImage imageNamed:@"cha"];
    }];
 
}
// 初始化视图
-(void)initUI
{
    CGFloat successLabelH = 20;
    CGFloat successLabelW = 70;
    CGFloat successLableX = (self.view.frame.size.width - successLabelW) / 2;
    self.successLabel.frame = CGRectMake(successLableX, 84, successLabelW, successLabelH);
    _successLabel.textColor = [UIColor redColor];
    _successLabel.font = [UIFont systemFontOfSize:15];
    _successLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_successLabel];
    
    CGFloat upLabelH = 10;
    CGFloat uplabelW = 100;
    CGFloat upLabelX = (self.view.frame.size.width - uplabelW) / 2;
    self.upLabel.frame = CGRectMake(upLabelX, _successLabel.frame.origin.y + 10 + successLabelH, uplabelW, upLabelH);
    _upLabel.text = @"您的报名订单二维码";
    _upLabel.textColor = [UIColor redColor];
    _upLabel.font = [UIFont systemFontOfSize:10];
    _upLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_upLabel];
    
    CGFloat  numberImageViewH = 100;
    CGFloat numberImageViewX = (self.view.frame.size.width - numberImageViewH) / 2;
    self.numberImageView.frame = CGRectMake(numberImageViewX, _upLabel.frame.origin.y + 5 + upLabelH, numberImageViewH, numberImageViewH);
    _numberImageView.backgroundColor = [UIColor greenColor];
    _numberImageView.image = [UIImage imageNamed:@""];
    [self.view addSubview:_numberImageView];
    
    CGFloat finishButtonH = 40;
    self.finishButton.frame = CGRectMake(0, self.view.frame.size.height - finishButtonH, self.view.frame.size.width, finishButtonH);
    [_finishButton setBackgroundColor:[UIColor colorWithHexString:@"ff5d35"]];
    [_finishButton setTitle:@"完成" forState:UIControlStateNormal];
    _finishButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [_finishButton addTarget:self action:@selector(didFinishClick:) forControlEvents:UIControlEventTouchUpInside];
    [_finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_finishButton];
  
}

- (void)refreshData
{
    NSURL *url = [NSURL URLWithString:_numberStr];
    [_numberImageView sd_setImageWithURL:url placeholderImage:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma maek -- Action
- (void)didFinishClick:(UIButton *)btn
{
    MagicMainTableViewController  *magicVC = [[MagicMainTableViewController alloc]init];
    [self.navigationController pushViewController:magicVC animated:YES];
}
#pragma mark -- Lazy加载
- (UILabel *)successLabel
{
    if (!_successLabel) {
        _successLabel = [[UILabel alloc] init];
    }
    return _successLabel;
}
- (UILabel *)upLabel
{
    if (!_upLabel) {
        _upLabel = [[UILabel alloc] init];
    }
    return _upLabel;
}
- (UIImageView *)numberImageView
{
    if (!_numberImageView) {
        _numberImageView = [[UIImageView alloc] init];
    }
    return _numberImageView;
}
- (UILabel *)downLabel
{
    if (!_downLabel) {
        _downLabel = [[UILabel alloc] init];
    }
    return _downLabel;
}
- (UIButton *)finishButton
{
    if (!_finishButton) {
        _finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
                         
    }
    return _finishButton;
}
@end
