//
//  APCommentViewController.m
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "APCommentViewController.h"
#import "UIDevice+JEsystemVersion.h"
#import "CommentCell.h"
#import "MyAppointmentModel.h"
#import "BCTextView.h"
#import "AppointmentViewController.h"

//static NSString *const kuserCommentAppointment = @"courseinfo/usercomment";

@interface APCommentViewController ()<UITableViewDataSource,UITableViewDelegate,CommentCellDelegate,UITextViewDelegate>{
    BCTextView *bctextView;
    CommentCell *totleCell;
}
@property (strong, nonatomic) UITableView *tableView;

// 总体评论星级
@property (assign, nonatomic) int starProgress;
// 能力
@property (assign, nonatomic) CGFloat abilitylevel;
// 时间
@property (assign, nonatomic) CGFloat timelevel;
// 态度
@property (assign, nonatomic) CGFloat attitudelevel;
// 卫生
@property (assign, nonatomic) CGFloat hygienelevel;

@property (strong, nonatomic) UIButton *submitBtn;

@property (nonatomic , strong) NSMutableArray *commentTitleArray;

@end

@implementation APCommentViewController

- (NSMutableArray *)commentTitleArray
{
    if (_commentTitleArray == nil) {
        
        _commentTitleArray = [NSMutableArray arrayWithObjects:@{@"title":@"守时",@"progress":@5},
                                                                @{@"title":@"态度",@"progress":@5},
                                                                @{@"title":@"能力",@"progress":@5},
                                                                @{@"title":@"卫生",@"progress":@5},
                                                                @{@"title":@"总体评价",@"progress":@5}
                                                                , nil];
    }
    return _commentTitleArray;
}

- (UIButton *)submitBtn {
    if (_submitBtn == nil) {
        _submitBtn = [WMUITool initWithTitle:@"提交" withTitleColor:[UIColor whiteColor] withTitleFont:[UIFont systemFontOfSize:16]];
        _submitBtn.backgroundColor = MAINCOLOR;
        [_submitBtn addTarget:self action:@selector(clickSubmit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        //_tableView.scrollEnabled = NO;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 默认5颗星
    // 总体评论星级
    _starProgress = 5;
    // 能力
    _abilitylevel = 5;
    // 时间
    _timelevel = 5;
    // 态度
    _attitudelevel = 5;
    // 卫生
    _hygienelevel = 5;

    bctextView.text = @"";
    self.title = @"评论";
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([UIDevice jeSystemVersion] >= 7.0f) {
        //当你的容器是navigation controller时，默认的布局将从navigation bar的顶部开始。这就是为什么所有的UI元素都往上漂移了44pt
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [self tableViewFootView];
 
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)clickSubmit:(UIButton *)sender {
    
    NSLog(@"self.starProgress:%d bctextView.text:%@",self.starProgress ,bctextView.text);
    NSLog(@"bctextView.text.length:%lu",(unsigned long)bctextView.text.length);
    
    if (self.starProgress != 1 || (bctextView.text && bctextView.text.length!=0)) {
     
        NSString *urlString = [NSString stringWithFormat:BASEURL,kuserCommentAppointment];
        
        NSDictionary *param = @{@"userid":[AcountManager manager].userid,
                                @"reservationid":self.model.infoId,
                                @"starlevel":[NSString stringWithFormat:@"%d",self.starProgress],// 总体评论星级
                                @"abilitylevel":[NSString stringWithFormat:@"%f",self.abilitylevel],// 能力
                                @"timelevel":[NSString stringWithFormat:@"%f",self.timelevel],// 时间
                                @"attitudelevel":[NSString stringWithFormat:@"%f",self.attitudelevel],// 态度
                                @"hygienelevel":[NSString stringWithFormat:@"%f",self.hygienelevel],// 卫生
                                @"commentcontent":bctextView.text};
        
        [JENetwoking startDownLoadWithUrl:urlString postParam:param WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
            
            DYNSLog(@"%s data = %@",__func__,data);
            
            NSDictionary *param = data;
            NSNumber *type = param[@"type"];
            NSString *msg = [NSString stringWithFormat:@"%@", param[@"msg"]];
            
            if (type.integerValue == 1) {
                kShowSuccess(@"评论成功");
                
                if (self.isForceComment) {
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                }
                
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    if ([vc isKindOfClass:[AppointmentViewController class]]) {
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
                
            }else {
                kShowFail(msg);
            }
        }];
        
    }else{
        
        [self obj_showTotasViewWithMes:@"请填写评价内容"];
        
    }
    
}

- (UIView *)tableViewFootView {
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 80)];
    [backGroundView addSubview:self.submitBtn];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(backGroundView.mas_top).offset(15);
        make.right.mas_equalTo(backGroundView.mas_right).offset(-15);
        make.height.mas_equalTo(@45);
    }];
    
    return backGroundView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = BACKGROUNDCOLOR;
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 79;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        static NSString *cellId = @"cellOne";
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (!cell) {
            cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
        }
        
        if (indexPath.row==4) {
            cell.userInteractionEnabled = NO;
            totleCell = cell;
            cell.topLabel.textColor = [UIColor orangeColor];
        }else{
            cell.userInteractionEnabled = YES;
            totleCell = nil;
            cell.topLabel.textColor = [UIColor blackColor];
        }
        
        cell.topLabel.text = self.commentTitleArray[indexPath.row][@"title"];
        
        [cell receiveIndex:indexPath];
        
        CGFloat progress = [self.commentTitleArray[indexPath.row][@"progress"] floatValue];
        NSLog(@"创建cell progress:%f",progress);
        
        [cell.starBar setUpRating:progress];
        
        return cell;

    }else if (indexPath.section == 1) {
        
        static NSString *cellId = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            bctextView = [[BCTextView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 79) withPlaceholder:@"写点评论吧,对其他伙伴有帮助"];
            bctextView.delegate = self;
            bctextView.font = [UIFont systemFontOfSize:16];
            bctextView.returnKeyType = UIReturnKeyDone;
            [cell.contentView addSubview:bctextView];
        }
        return cell;
    }
    return nil;
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    BCTextView *bcTextView = (BCTextView *)textView;
    bcTextView.placeholder.hidden = YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)senderStarProgress:(CGFloat)newProgress withIndex:(NSIndexPath *)indexPath
{
    NSLog(@"%s indexPath.section:%ld indexPath.row:%ld",__func__ ,(long)indexPath.section,(long)indexPath.row);
    
    if (newProgress==0) {
        newProgress = 1;
    }
    
    // 上面4个评价
    NSString *title = self.commentTitleArray[indexPath.row][@"title"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"progress"] = [NSString stringWithFormat:@"%f",newProgress];
    dict[@"title"] = title;
    [self.commentTitleArray replaceObjectAtIndex:indexPath.row withObject:dict];
    
    if (indexPath.row == 0) {
        _abilitylevel = newProgress;
    }else if (indexPath.row == 1) {
        _timelevel = newProgress;
    }else if (indexPath.row == 2) {
        _attitudelevel = newProgress;
    }else if (indexPath.row == 3) {
        _hygienelevel = newProgress;
    }

    // 总体评价
    _starProgress = (_abilitylevel + _timelevel + _attitudelevel + _hygienelevel) / 4;
    NSString *totleTitle = self.commentTitleArray[4][@"title"];
    NSMutableDictionary *totleDict = [NSMutableDictionary dictionary];
    totleDict[@"progress"] = [NSString stringWithFormat:@"%d",_starProgress];
    totleDict[@"title"] = totleTitle;
    [self.commentTitleArray replaceObjectAtIndex:4 withObject:totleDict];

    NSLog(@"self.commentTitleArray:%@",self.commentTitleArray);

    [self.tableView reloadData];
    
}
@end
