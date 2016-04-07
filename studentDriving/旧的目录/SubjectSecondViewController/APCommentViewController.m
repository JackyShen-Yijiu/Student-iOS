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
#import "YBTextView.h"

//static NSString *const kuserCommentAppointment = @"courseinfo/usercomment";

@interface APCommentViewController ()<UITableViewDataSource,UITableViewDelegate,CommentCellDelegate,UITextViewDelegate>{
    BCTextView *bctextView;
    CommentCell *totleCell;
}
@property (nonatomic,strong) UIView *bgView; // 全局半透明背景

@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic, strong) UIView *headerView;

// 教练文字
@property (nonatomic, strong) UILabel *coachTitleLabel;

// 头像
@property (nonatomic,strong) UIImageView *iconImgView;

// 教练姓名
@property (nonatomic, strong) UILabel *coachNameLabel;

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

@property (nonatomic, strong) YBTextView *reasonTextView;
@property (nonatomic, strong) UIView *lineView;
// 评价多少字
@property (nonatomic,strong) UILabel *commentCountLabel;
@end

@implementation APCommentViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.bgView];
    
    [self.headerView addSubview:self.coachTitleLabel];
    [self.headerView addSubview:self.iconImgView];
    [self.headerView addSubview:self.coachNameLabel];
    self.tableView.tableHeaderView = self.headerView;

    [self.view addSubview:self.tableView];
    
     [self.submitBtn addSubview:self.lineView];
    [self.tableView addSubview:self.submitBtn];
    
   
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
    
    
}
#pragma mark ---- 手势
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self.view endEditing:YES];
//}
#pragma mark ----- UIbutton
- (void)clickSubmit:(UIButton *)sender {
    if (self.reasonTextView.text.length == 0) {
        [self obj_showTotasViewWithMes:@"请输入评价内容"];
        return ;
    }
    
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
#pragma mark ----- UITableView Delegate方法
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (0 == section) {
        return 0;
    }
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        return 30;
    }
    return 60;
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
            cell.topLabel.textColor = [UIColor blackColor];
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
            [self.reasonTextView addSubview:self.commentCountLabel];
            [cell.contentView addSubview:self.reasonTextView];
        }
        return cell;
    }
    return nil;
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    YBTextView *bcTextView = (YBTextView *)textView;
    bcTextView.placeholderLabel.hidden = YES;
}
#pragma mark ---- UITextView Delegate代理方法
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    if (!textView.text.length) {
        YBTextView *yntextView = (YBTextView *)textView;
        yntextView.placeholderLabel.hidden = NO;
    }
    if ([textView.text length]>40) {
        
        textView.text = [textView.text substringToIndex:40];
        return;
        
    }
    _commentCountLabel.text = [NSString stringWithFormat:@"%lu/40",(unsigned long)[textView.text length]];
}

#pragma mark ---- 代理方法
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
#pragma mark ----- Lazy 加载
- (UIView *)bgView
{
    if (_bgView==nil) {
        _bgView = [[UIView alloc] initWithFrame:self.view.bounds];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.5;
    }
    return _bgView;
}

- (UIView *)headerView{
    if (_headerView == nil) {
        _headerView = [[UIView alloc] init];
        _headerView.backgroundColor = [UIColor clearColor];
        _headerView.frame = CGRectMake(0, 0, kSystemWide - 36, 104);
    }
    
    return _headerView;
}
// 描述文字
- (UILabel *)coachTitleLabel
{
    if (_coachTitleLabel==nil) {
        CGFloat width = 12 * 2;
        CGFloat height = 12;
        _coachTitleLabel = [[UILabel alloc] init];
        _coachTitleLabel.text = @"教练";
        _coachTitleLabel.textColor = [UIColor colorWithHexString:@"b7b7b7"];
        _coachTitleLabel.font = [UIFont systemFontOfSize:12];
        _coachTitleLabel.textAlignment = NSTextAlignmentCenter;
        _coachTitleLabel.frame = CGRectMake(self.headerView.width/2 - width/2, 20, width, height);
        
    }
    return _coachTitleLabel;
}


// 头像
- (UIImageView *)iconImgView
{
    if (_iconImgView==nil) {
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.backgroundColor = YBNavigationBarBgColor;
        _iconImgView.frame = CGRectMake(self.headerView.width/2-40/2, CGRectGetMaxY(self.coachTitleLabel.frame)+10, 40, 40);
        _iconImgView.layer.masksToBounds = YES;
        _iconImgView.layer.cornerRadius = 20;
    }
    return _iconImgView;
}
// 教练姓名
- (UILabel *)coachNameLabel
{
    if (_coachNameLabel==nil) {
        CGFloat width = 12 * 8;
        CGFloat height = 12;
        _coachNameLabel = [[UILabel alloc] init];
        _coachNameLabel.text = @"######";
        _coachNameLabel.textColor = [UIColor colorWithHexString:@"b7b7b7"];
        _coachNameLabel.font = [UIFont systemFontOfSize:12];
        _coachNameLabel.textAlignment = NSTextAlignmentCenter;
        _coachNameLabel.frame = CGRectMake(self.headerView.width/2 - width/2, CGRectGetMaxY(self.iconImgView.frame)+10, width, height);
        
    }
    return _coachNameLabel;
}


- (NSMutableArray *)commentTitleArray
{
    if (_commentTitleArray == nil) {
        
        _commentTitleArray = [NSMutableArray arrayWithObjects:@{@"title":@"守时",@"progress":@5},
                              @{@"title":@"态度",@"progress":@5},
                              @{@"title":@"能力",@"progress":@5},
                              @{@"title":@"卫生",@"progress":@5},
                              @{@"title":@"总体",@"progress":@5}
                              , nil];
    }
    return _commentTitleArray;
}

- (UIButton *)submitBtn {
    if (_submitBtn == nil) {
        _submitBtn = [WMUITool initWithTitle:@"提交评价" withTitleColor:YBNavigationBarBgColor withTitleFont:[UIFont systemFontOfSize:14]];
        _submitBtn.backgroundColor = [UIColor whiteColor];
        _submitBtn.frame = CGRectMake(0, kSystemHeight - 64 - 44 - 100 -44 , kSystemWide, 44);
        [_submitBtn addTarget:self action:@selector(clickSubmit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(18, 64, kSystemWide - 18 * 2, kSystemHeight - 44 - 64 - 100) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
//        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}
// 请输入原因
- (YBTextView *)reasonTextView
{
    if (_reasonTextView==nil) {
        CGFloat height = 50;
        CGFloat margin = 18;
        _reasonTextView = [[YBTextView alloc] initWithFrame:CGRectMake(margin, 0, kSystemWide-2*margin, height) withPlaceholder:@"我来说两句"];
        _reasonTextView.placeholderLabel.font = [UIFont systemFontOfSize:12];
        _reasonTextView.textColor = [UIColor blackColor];
        _reasonTextView.font = [UIFont systemFontOfSize:13];
        _reasonTextView.backgroundColor = [UIColor clearColor];
        _reasonTextView.delegate = self;
        _reasonTextView.layer.borderColor = [[UIColor colorWithHexString:@"6e6e6e"]CGColor];
        _reasonTextView.layer.borderWidth = 1.0;
        _reasonTextView.layer.cornerRadius = 4.0f;
        [_reasonTextView.layer setMasksToBounds:YES];
       
        
    }
    return _reasonTextView;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 0.5)];
        _lineView.backgroundColor = HM_LINE_COLOR;
        
    }
    return _lineView;
}
// 评价多少字
- (UILabel *)commentCountLabel
{
    if (_commentCountLabel==nil) {
        _commentCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.reasonTextView.frame)-110, CGRectGetMaxY(self.reasonTextView.frame)-22, 100, 25)];
        _commentCountLabel.text = @"0/40";
        _commentCountLabel.textAlignment = NSTextAlignmentRight;
        _commentCountLabel.font = [UIFont systemFontOfSize:12];
        _commentCountLabel.textColor = [UIColor lightGrayColor];
    }
    return _commentCountLabel;
}

@end
