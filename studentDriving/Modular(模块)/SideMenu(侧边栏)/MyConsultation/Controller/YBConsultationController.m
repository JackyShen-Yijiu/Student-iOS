//
//  YBConsultationController.m
//  studentDriving
//
//  Created by JiangangYang on 16/3/1.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBConsultationController.h"
#import "YBTextView.h"

@interface YBConsultationController ()<UITextViewDelegate>
{
    YBTextView *bctextView;
}
@end

@implementation YBConsultationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = YBMainViewControlerBackgroundColor;
    
    self.title = @"我要提问";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(rightBtnDidClick)];

    bctextView = [[YBTextView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 209) withPlaceholder:@"请输入内容"];
    bctextView.delegate = self;
    bctextView.font = [UIFont systemFontOfSize:16];
    bctextView.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:bctextView];
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    YBTextView *bcTextView = (YBTextView *)textView;
    bcTextView.placeholderLabel.hidden = YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)rightBtnDidClick
{
    
    if (bctextView.text && bctextView.text.length!=0) {
        
        NSString *urlString = [NSString stringWithFormat:BASEURL,ksaveuserconsult];
        
        NSDictionary *param = @{@"userid":[AcountManager manager].userid,
                                @"content":bctextView.text,
                                @"name":@"",
                                @"mobile":@"",// 总体评论星级
                                @"licensetype":@"",// 能力
                                };
        
        [JENetwoking startDownLoadWithUrl:urlString postParam:param WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
            
            DYNSLog(@"%s data = %@",__func__,data);
            
            NSDictionary *param = data;
            NSNumber *type = param[@"type"];
            NSString *msg = [NSString stringWithFormat:@"%@", param[@"msg"]];
            
            if (type.integerValue == 1) {
                kShowSuccess(@"发送成功");
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                kShowFail(msg);
            }
        }];
        
    }else{
        
        [self obj_showTotasViewWithMes:@"请填写评价内容"];
        
    }
    
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
