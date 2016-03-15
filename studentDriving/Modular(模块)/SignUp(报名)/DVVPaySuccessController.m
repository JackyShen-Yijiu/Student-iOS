//
//  DVVPaySuccessController.m
//  studentDriving
//
//  Created by 大威 on 16/3/2.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVPaySuccessController.h"
#import "DVVPaySuccessView.h"
#import "DVVPaySuccessViewModel.h"
#import "UIImageView+DVVWebImage.h"
#import "NSString+Helper.h"
#import "DVVToast.h"
#import "DVVNoDataPromptView.h"

@interface DVVPaySuccessController ()

@property (nonatomic, strong) DVVPaySuccessView *successView;
@property (nonatomic, strong) DVVPaySuccessViewModel *viewModel;
@property (nonatomic, strong) DVVNoDataPromptView *promptView;

@end

@implementation DVVPaySuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"报名信息";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.successView];
//    _successView.hidden = YES;
    [self configViewModel];
    
    
    if (self.isPaySuccess) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    }
    
}

-  (void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [DVVToast hide];
}

- (void)configViewModel {
    
    _viewModel = [DVVPaySuccessViewModel new];
    _viewModel.userID = [AcountManager manager].userid;
    
    __weak typeof(self) ws = self;
    [_viewModel dvv_setRefreshSuccessBlock:^{
        ws.successView.hidden = NO;
        [ws.successView.iconImageView dvv_downloadImage:_viewModel.dmData.schoollogoimg];
        ws.successView.schoolNameLabel.text = _viewModel.dmData.applyschoolinfo.name;
        if ([UIScreen mainScreen].bounds.size.width > 320) {
            ws.successView.classTypeLabel.text = [NSString stringWithFormat:@"报考班型:%@", _viewModel.dmData.applyclasstypeinfo.name];
            ws.successView.timeLabel.text = [NSString stringWithFormat:@"报考时间:%@", _viewModel.dmData.applytime];
        }else {
            ws.successView.classTypeLabel.text = [NSString stringWithFormat:@"%@", _viewModel.dmData.applyclasstypeinfo.name];
            ws.successView.timeLabel.text = [NSString stringWithFormat:@"%@", _viewModel.dmData.applytime];
        }
        ws.successView.actualPaymentLabel.text = [NSString stringWithFormat:@"实付款:￥%lu", _viewModel.dmData.applyclasstypeinfo.onsaleprice];
        ws.successView.havePayLabel.text = [NSString stringWithFormat:@"已付款:￥%lu", _viewModel.dmData.applyclasstypeinfo.price];
        ws.successView.numberLabel.text = [NSString stringWithFormat:@"报名编号:%@", _viewModel.dmData.applyorderid];
        NSString *descString = [NSString stringWithFormat:@"请您于%@日前携带资料前往您所报名的驾校确认报名信息，并支付报名费用。", _viewModel.dmData.endtime];
        ws.successView.descLabel.text = descString;
//        CGFloat height = [NSString autoHeightWithString:descString width:[UIScreen mainScreen].bounds.size.width - 16*2 font:[UIFont systemFontOfSize:14]];
//        
//        [ws.successView.descLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(height);
//        }];
    }];
    
    [_viewModel dvv_setNilResponseObjectBlock:^{
        [ws.view addSubview:ws.promptView];
    }];
    
    [_viewModel dvv_setNetworkCallBackBlock:^{
        [DVVToast hide];
    }];
    
    [_viewModel dvv_setNetworkErrorBlock:^{
        [ws.view addSubview:ws.promptView];
//        [ws obj_showTotasViewWithMes:@"网络错误"];
    }];
    
    
    [DVVToast show];
    [_viewModel dvv_networkRequestRefresh];
}

- (DVVPaySuccessView *)successView {
    if (!_successView) {
        _successView = [DVVPaySuccessView new];
        _successView.frame = self.view.bounds;
    }
    return _successView;
}

- (DVVNoDataPromptView *)promptView {
    if (!_promptView) {
        _promptView = [[DVVNoDataPromptView alloc] initWithTitle:@"加载失败" image:[UIImage imageNamed:@"app_error_robot"]];
    }
    return _promptView;
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

@end
