//
//  SignInViewController.m
//  studentDriving
//
//  Created by yyx on 15/12/31.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "SignInViewController.h"
#import "UIBarButtonItem+JGBarButtonItem.h"
#import "JENetwoking.h"
#import "ToolHeader.h"
#import "SignInHelpViewController.h"

@interface SignInViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *QRCodeImageView;
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;
- (IBAction)completeBtnDidClick:(id)sender;

@end

@implementation SignInViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"签到";
    
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"使用帮助" highTitle:@"使用帮助" target:self action:@selector(helpDidClick) isRightItem:YES];
    
    [self loadQRCodeImg];
    
}


- (void)loadQRCodeImg
{
    
    [self.QRCodeImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://101.200.204.240:8181/api/v1/create_qrcode?text=www.baidu.com&size=10"]]];

}

- (void)helpDidClick
{
    NSLog(@"%s",__func__);
    
    SignInHelpViewController *vc = [[SignInHelpViewController alloc] init];
    vc.url = @"";
    [self.navigationController pushViewController:vc animated:YES];
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

- (IBAction)completeBtnDidClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
