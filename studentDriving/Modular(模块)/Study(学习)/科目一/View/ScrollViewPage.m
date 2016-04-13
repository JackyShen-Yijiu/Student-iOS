//
//  ScrollViewPage.m
//  ScollViewPage
//
//  Created by allen on 15/9/18.
//  Copyright (c) 2015年 Allen. All rights reserved.
//

#import "ScrollViewPage.h"
#import "PageTableViewCell.h"
#import "YBSubjectData.h"
#import "YBSubjectQuestionsHeader.h"
#import "YBSubjectQuestionsFooter.h"

@interface ScrollViewPage ()
// key:indexPath.row+1  values:indexPath.row是否是选中状态
@property (nonatomic,strong) NSMutableDictionary *selectnumDict;

@property (nonatomic,strong)YBSubjectQuestionsFooter *leftFooter;
@property (nonatomic,strong)YBSubjectQuestionsFooter *midFooter;
@property (nonatomic,strong)YBSubjectQuestionsFooter *rightFooter;

@end

@implementation ScrollViewPage
{
    UIScrollView *_scrollview;
    UITableView *_lefttableview;
    UITableView *_middletableview;
    UITableView *_righttableview;
    NSMutableArray *_datearry;
    YBSubjectQuestionsHeader *header;
}

- (NSMutableDictionary *)selectnumDict{
    if (_selectnumDict==nil) {
        _selectnumDict = [NSMutableDictionary dictionary];
    }
    return _selectnumDict;
}

-(instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *)array{
    self = [super initWithFrame:frame];
    if (self) {
        
        _scrollview = [[UIScrollView  alloc]initWithFrame:frame];
        _scrollview.directionalLockEnabled = YES;
        _scrollview.backgroundColor = YBMainViewControlerBackgroundColor;

        _lefttableview = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
//        _lefttableview.backgroundColor = [UIColor blueColor];
        
        _middletableview = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
//        _middletableview.backgroundColor = [UIColor yellowColor];

        _righttableview = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
//        _righttableview.backgroundColor = [UIColor redColor];

        _datearry = [[NSMutableArray alloc] initWithArray:array];
        _scrollview.pagingEnabled = YES;
        _scrollview.bounces = NO;
        _scrollview.showsHorizontalScrollIndicator = NO;
        _scrollview.showsVerticalScrollIndicator = NO;
        
        if (_datearry.count>1) {
            _scrollview.contentSize = CGSizeMake(kSystemWide*2, 0);
        }
        
        [self creatUI];
        
    }
    return self;
}

//创建ui界面
-(void)creatUI{
  
    _scrollview.frame = CGRectMake(0, 0,kSystemWide, kSystemHeight);
   
    _middletableview.frame = CGRectMake(0,0, kSystemWide, kSystemHeight);
    _lefttableview.frame = CGRectMake(-kSystemWide, 0, kSystemWide, kSystemHeight);
    _righttableview.frame = CGRectMake(kSystemWide, 0, kSystemWide, kSystemHeight);
    
    _scrollview.delegate = self;
    _lefttableview.delegate = self;
    _middletableview.delegate = self;
    _righttableview.delegate = self;
    _lefttableview.dataSource = self;
    _middletableview.dataSource = self;
    _righttableview.dataSource = self;
    
    [_scrollview addSubview:_lefttableview];
    [_scrollview addSubview:_middletableview];
    [_scrollview addSubview:_righttableview];
    
    [self addSubview:_scrollview];
    
    // 设置scrollview滚动区域
    [self setUpScrollViewSize];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    YBSubjectData *                data = _datearry[self.currentPage];
    if (tableView==_lefttableview && self.currentPage > 0) {
        data = _datearry[self.currentPage-1];
    }else if (tableView==_middletableview){
        data = _datearry[self.currentPage];
    }else if (tableView==_righttableview && self.currentPage < _datearry.count-1){
        data = _datearry[self.currentPage+1];
    }
    
// 1:正确错误 2：单选4个选项 3：4个选项,多选
    if (data.type==1) {
        return 2;
    }else if (data.type==2){
        return 4;
    }else if (data.type==3){
        return 4;
    }
    return 0;
}
#pragma mark ----- 顶部控件
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    YBSubjectData *                data = _datearry[self.currentPage];
    if (tableView==_lefttableview && self.currentPage > 0) {
        data = _datearry[self.currentPage-1];
    }else if (tableView==_middletableview){
        data = _datearry[self.currentPage];
    }else if (tableView==_righttableview && self.currentPage < _datearry.count-1){
        data = _datearry[self.currentPage+1];
    }
    
    header = [[YBSubjectQuestionsHeader alloc] init];
    
    NSString *title = [NSString stringWithFormat:@"%d、%@",(int)self.currentPage,data.question];
    CGFloat sizeH = [title sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(kSystemWide - 15 - 24 - 10 - 15, MAXFLOAT)].height + 20;
    
    CGFloat height = 60;
    if (data.img_url || data.video_url) {
        height = sizeH + 185;
    }
    
    header.frame = CGRectMake(0, 0, kSystemWide, height);
    
    if (tableView==_lefttableview && self.currentPage > 0) {
        header.titleLable.text = [NSString stringWithFormat:@"%d、%@",(int)self.currentPage,data.question];
    }else if (tableView==_middletableview){
        header.titleLable.text = [NSString stringWithFormat:@"%d、%@",(int)self.currentPage+1,data.question];
    }else if (tableView==_righttableview && self.currentPage < _datearry.count-1){
        header.titleLable.text = [NSString stringWithFormat:@"%d、%@",(int)self.currentPage+2,data.question];
    }
    
    header.currentPage = self.currentPage;
    header.data = data;
    
    return header;
}
#pragma mark ----- 顶部控件高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  
    YBSubjectData *                data = _datearry[self.currentPage];
    if (tableView==_lefttableview && self.currentPage > 0) {
        data = _datearry[self.currentPage-1];
    }else if (tableView==_middletableview){
        data = _datearry[self.currentPage];
    }else if (tableView==_righttableview && self.currentPage < _datearry.count-1){
        data = _datearry[self.currentPage+1];
    }
    
    NSString *title = [NSString stringWithFormat:@"%d、%@",(int)self.currentPage,data.question];
    CGFloat sizeH = [title sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(kSystemWide - 15 - 24 - 10 - 15, MAXFLOAT)].height + 20;

    if (data.img_url || data.video_url) {
        return sizeH + 185;
    }
    
    return sizeH;
    
}

#pragma mark ----- 底部控件
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    YBSubjectData *                data = _datearry[self.currentPage];
    if (tableView==_lefttableview && self.currentPage > 0) {
        data = _datearry[self.currentPage-1];
    }else if (tableView==_middletableview){
        data = _datearry[self.currentPage];
    }else if (tableView==_righttableview && self.currentPage < _datearry.count-1){
        data = _datearry[self.currentPage+1];
    }
    
    if (data.isDone == NO && data.type==3) {// 尚未做过，多选确定按钮
        
        if (tableView==_lefttableview && self.currentPage > 0) {

            self.leftFooter = [[YBSubjectQuestionsFooter alloc] init];
            self.leftFooter.confimBtn.hidden = NO;
           
            NSArray *allValues = [self.selectnumDict allValues];
            NSLog(@"------allValues:%@ [allValues containsObject:@(1)]:%d",allValues,[allValues containsObject:@(1)]);
            
            if (allValues && allValues.count != 0) {
                
                if (tableView==_lefttableview && self.currentPage > 0) {
                    self.leftFooter.confimBtn.enabled = [allValues containsObject:@(1)];
                    self.leftFooter.confimBtn.backgroundColor = [allValues containsObject:@(1)] ? YBNavigationBarBgColor : [UIColor lightGrayColor];
                }else if (tableView==_middletableview){
                    self.midFooter.confimBtn.enabled = [allValues containsObject:@(1)];
                    self.midFooter.confimBtn.backgroundColor = YBNavigationBarBgColor;//[allValues containsObject:@(1)] ? YBNavigationBarBgColor : [UIColor lightGrayColor];
                }else if (tableView==_righttableview && self.currentPage < _datearry.count-1){
                    self.rightFooter.confimBtn.enabled = [allValues containsObject:@(1)];
                    self.rightFooter.confimBtn.backgroundColor = [allValues containsObject:@(1)] ? YBNavigationBarBgColor : [UIColor lightGrayColor];
                }
                
            }else{
                
                if (tableView==_lefttableview && self.currentPage > 0) {
                    self.leftFooter.confimBtn.enabled = NO;
                    self.leftFooter.confimBtn.backgroundColor = [UIColor lightGrayColor];
                }else if (tableView==_middletableview){
                    self.midFooter.confimBtn.enabled = NO;
                    self.midFooter.confimBtn.backgroundColor = [UIColor lightGrayColor];
                }else if (tableView==_righttableview && self.currentPage < _datearry.count-1){
                    self.rightFooter.confimBtn.enabled = NO;
                    self.rightFooter.confimBtn.backgroundColor = [UIColor lightGrayColor];
                }
                
            }
            
            [self.leftFooter.confimBtn addTarget:self action:@selector(confimBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
            self.leftFooter.contentView.hidden = YES;
            
            self.leftFooter.frame = CGRectMake(0, 0, kSystemWide, 64);
            
            self.leftFooter.currentPage = self.currentPage;
            self.leftFooter.data = data;
            
            return self.leftFooter;
            
        }else if (tableView==_middletableview){

            self.midFooter = [[YBSubjectQuestionsFooter alloc] init];
            self.midFooter.confimBtn.hidden = NO;
            
            NSArray *allValues = [self.selectnumDict allValues];
            NSLog(@"------allValues:%@ [allValues containsObject:@(1)]:%d",allValues,[allValues containsObject:@(1)]);
            
            if (allValues && allValues.count != 0) {
               
                if (tableView==_lefttableview && self.currentPage > 0) {
                    self.leftFooter.confimBtn.enabled = [allValues containsObject:@(1)];
                    self.leftFooter.confimBtn.backgroundColor = [allValues containsObject:@(1)] ? YBNavigationBarBgColor : [UIColor lightGrayColor];
                }else if (tableView==_middletableview){
                    self.midFooter.confimBtn.enabled = [allValues containsObject:@(1)];
                    self.midFooter.confimBtn.backgroundColor = YBNavigationBarBgColor;//[allValues containsObject:@(1)] ? YBNavigationBarBgColor : [UIColor lightGrayColor];
                }else if (tableView==_righttableview && self.currentPage < _datearry.count-1){
                    self.rightFooter.confimBtn.enabled = [allValues containsObject:@(1)];
                    self.rightFooter.confimBtn.backgroundColor = [allValues containsObject:@(1)] ? YBNavigationBarBgColor : [UIColor lightGrayColor];
                }
                
            }else{
                
                if (tableView==_lefttableview && self.currentPage > 0) {
                    self.leftFooter.confimBtn.enabled = NO;
                    self.leftFooter.confimBtn.backgroundColor = [UIColor lightGrayColor];
                }else if (tableView==_middletableview){
                    self.midFooter.confimBtn.enabled = NO;
                    self.midFooter.confimBtn.backgroundColor = [UIColor lightGrayColor];
                }else if (tableView==_righttableview && self.currentPage < _datearry.count-1){
                    self.rightFooter.confimBtn.enabled = NO;
                    self.rightFooter.confimBtn.backgroundColor = [UIColor lightGrayColor];
                }
                
            }
            
            [self.midFooter.confimBtn addTarget:self action:@selector(confimBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
            self.midFooter.contentView.hidden = YES;
            
            self.midFooter.frame = CGRectMake(0, 0, kSystemWide, 64);
            
            self.midFooter.currentPage = self.currentPage;
            self.midFooter.data = data;
            
            return self.midFooter;
            
        }else if (tableView==_righttableview && self.currentPage < _datearry.count-1){

            self.rightFooter = [[YBSubjectQuestionsFooter alloc] init];
            self.rightFooter.confimBtn.hidden = NO;
          
            NSArray *allValues = [self.selectnumDict allValues];
            NSLog(@"------allValues:%@ [allValues containsObject:@(1)]:%d",allValues,[allValues containsObject:@(1)]);
            
            if (allValues && allValues.count != 0) {
                
                if (tableView==_lefttableview && self.currentPage > 0) {
                    self.leftFooter.confimBtn.enabled = [allValues containsObject:@(1)];
                    self.leftFooter.confimBtn.backgroundColor = [allValues containsObject:@(1)] ? YBNavigationBarBgColor : [UIColor lightGrayColor];
                }else if (tableView==_middletableview){
                    self.midFooter.confimBtn.enabled = [allValues containsObject:@(1)];
                    self.midFooter.confimBtn.backgroundColor = YBNavigationBarBgColor;//[allValues containsObject:@(1)] ? YBNavigationBarBgColor : [UIColor lightGrayColor];
                }else if (tableView==_righttableview && self.currentPage < _datearry.count-1){
                    self.rightFooter.confimBtn.enabled = [allValues containsObject:@(1)];
                    self.rightFooter.confimBtn.backgroundColor = [allValues containsObject:@(1)] ? YBNavigationBarBgColor : [UIColor lightGrayColor];
                }
                
            }else{
                
                if (tableView==_lefttableview && self.currentPage > 0) {
                    self.leftFooter.confimBtn.enabled = NO;
                    self.leftFooter.confimBtn.backgroundColor = [UIColor lightGrayColor];
                }else if (tableView==_middletableview){
                    self.midFooter.confimBtn.enabled = NO;
                    self.midFooter.confimBtn.backgroundColor = [UIColor lightGrayColor];
                }else if (tableView==_righttableview && self.currentPage < _datearry.count-1){
                    self.rightFooter.confimBtn.enabled = NO;
                    self.rightFooter.confimBtn.backgroundColor = [UIColor lightGrayColor];
                }
                
            }
            
            [self.rightFooter.confimBtn addTarget:self action:@selector(confimBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
            self.rightFooter.contentView.hidden = YES;
            
            self.rightFooter.frame = CGRectMake(0, 0, kSystemWide, 64);
            
            self.rightFooter.currentPage = self.currentPage;
            self.rightFooter.data = data;
            
            return self.rightFooter;
            
        }
        
    }else if (data.isDone && data.isTrue==NO){// 已经做过、并且做错出现解释、
        
        if (tableView==_lefttableview && self.currentPage > 0) {
            
            self.leftFooter = [[YBSubjectQuestionsFooter alloc] init];
            self.leftFooter.backgroundColor = YBMainViewControlerBackgroundColor;
            self.leftFooter.confimBtn.hidden = YES;
            self.leftFooter.contentView.hidden = NO;
            
            NSString *title = [NSString stringWithFormat:@"答案：%@ %@",data.explain,data.answer_trueStr];
            CGFloat sizeH = [title sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(kSystemWide - 15 - 15, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping].height+20;
            
            self.leftFooter.frame = CGRectMake(0, 0, kSystemWide, sizeH+45+10);
            
            self.leftFooter.currentPage = self.currentPage;
            self.leftFooter.data = data;
            
            return self.leftFooter;
            
        }else if (tableView==_middletableview){

            self.midFooter = [[YBSubjectQuestionsFooter alloc] init];
            self.midFooter.backgroundColor = YBMainViewControlerBackgroundColor;
            self.midFooter.confimBtn.hidden = YES;
            self.midFooter.contentView.hidden = NO;
            
            NSString *title = [NSString stringWithFormat:@"答案：%@ %@",data.explain,data.answer_trueStr];
            CGFloat sizeH = [title sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(kSystemWide - 15 - 15, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping].height+20;
            
            self.midFooter.frame = CGRectMake(0, 0, kSystemWide, sizeH+45+10);
            
            self.midFooter.currentPage = self.currentPage;
            self.midFooter.data = data;
            
            return self.midFooter;
            
        }else if (tableView==_righttableview && self.currentPage < _datearry.count-1){

            self.rightFooter = [[YBSubjectQuestionsFooter alloc] init];
            self.rightFooter.backgroundColor = YBMainViewControlerBackgroundColor;
            self.rightFooter.confimBtn.hidden = YES;
            self.rightFooter.contentView.hidden = NO;
            
            NSString *title = [NSString stringWithFormat:@"答案：%@ %@",data.explain,data.answer_trueStr];
            CGFloat sizeH = [title sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(kSystemWide - 15 - 15, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping].height+20;
            
            self.rightFooter.frame = CGRectMake(0, 0, kSystemWide, sizeH+45+10);
            
            self.rightFooter.currentPage = self.currentPage;
            self.rightFooter.data = data;
            
            return self.rightFooter;
            
        }
       
        
    }
    
    return nil;
    
}

#pragma mark ----- 底部控件高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    YBSubjectData *                data = _datearry[self.currentPage];
    if (tableView==_lefttableview && self.currentPage > 0) {
        data = _datearry[self.currentPage-1];
    }else if (tableView==_middletableview){
        data = _datearry[self.currentPage];
    }else if (tableView==_righttableview && self.currentPage < _datearry.count-1){
        data = _datearry[self.currentPage+1];
    }
    
    if (data.isDone == NO && data.type==3) {// 尚未做过，多选确定按钮
        
        return 64;
        
    }else if (data.isDone && data.isTrue==NO){// 已经做过、并且做错出现解释、
        
        NSString *title = [NSString stringWithFormat:@"答案：%@ %@",data.explain,data.answer_trueStr];
        CGFloat sizeH = [title sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(kSystemWide - 15 - 15, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping].height+20;
        
        return sizeH+45+10;
        
    }
    
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    NSString *cellID = @"PageTableViewCell";
    PageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PageTableViewCell" owner:self options:nil]lastObject];        
    }
    
    YBSubjectData *                data = _datearry[self.currentPage];
    if (tableView==_lefttableview && self.currentPage > 0) {
        data = _datearry[self.currentPage-1];
    }else if (tableView==_middletableview){
        data = _datearry[self.currentPage];
    }else if (tableView==_righttableview && self.currentPage < _datearry.count-1){
        data = _datearry[self.currentPage+1];
    }
    
    cell.userInteractionEnabled = !data.isDone;
    
// 1:正确错误 2：单选4个选项 3：4个选项,多选
    if (data.type==1) {
        
        NSLog(@"data.selectNum:%ld",data.selectNum);
        
        if (data.isDone) {
            
            if (indexPath.row==0) {
                
                cell.textcontent.text = @"正确";
                cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_A"];
                
            }else if (indexPath.row==1){
                
                cell.textcontent.text = @"错误";
                cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_B"];
                
            }
            
            if (data.isTrue) {// 回答正确
                
                if (indexPath.row==data.selectNum) {
                    cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_right"];
                }
                
            }else{// 回答错误
                
                if (indexPath.row==data.selectNum) {
                    cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_wrong"];
                }
                
            }
            
        }else{
            
            if (indexPath.row==0) {
                
                cell.textcontent.text = @"正确";
                cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_A"];
                
            }else if (indexPath.row==1){
                
                cell.textcontent.text = @"错误";
                cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_B"];
                
            }
            
        }
        
    }else if (data.type==2){

        if (data.isDone) {
            
            NSLog(@"data.selectNum:%ld",data.selectNum);

            if (indexPath.row==0) {
                
                cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer1];
                cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_A"];
                
            }else if (indexPath.row==1){
                
                cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer2];
                cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_B"];
                
            }else if (indexPath.row==2){
                
                cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer3];
                cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_C"];
                
            }else if (indexPath.row==3){
                
                cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer4];
                cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_D"];
                
            }
            
            if (data.isTrue) {// 回答正确
                
                if (indexPath.row==data.selectNum) {
                    cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_right"];
                }
                
            }else{// 回答错误
                
                if (indexPath.row==data.selectNum) {
                    cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_wrong"];
                }
                
            }
            
        }else{
        
            if (indexPath.row==0) {
                
                cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer1];
                cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_A"];
                
            }else if (indexPath.row==1){
                
                cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer2];
                cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_B"];
                
            }else if (indexPath.row==2){
                
                cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer3];
                cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_C"];
                
            }else if (indexPath.row==3){
                
                cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer4];
                cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_D"];
                
            }
            
        }
        
    }else if (data.type==3){

        if (indexPath.row==0) {
            
            cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer1];
            cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_A"];
            
        }else if (indexPath.row==1){
            
            cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer2];
            cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_B"];
            
        }else if (indexPath.row==2){
            
            cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer3];
            cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_C"];
            
        }else if (indexPath.row==3){
            
            cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer4];
            cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_D"];
            
        }
        
        if (data.isDone) {// 已经确认
            
            NSString *answer_true = [NSString stringWithFormat:@"%ld",(long)data.answer_true];
            
            NSArray *asnwer_trueArray = data.answer_trueArray;
            
            NSDictionary *selectnumDict = data.selectnumDict;
            
            NSString *selectnumStr = selectnumDict[[NSString stringWithFormat:@"%lu",indexPath.row+1]];
            
            NSInteger selectnum = [selectnumDict[[NSString stringWithFormat:@"%lu",indexPath.row+1]] integerValue];
            
            NSString *index_row = [NSString stringWithFormat:@"%lu",indexPath.row+1];
            
            NSLog(@"已经确认 answer_true:%@ asnwer_trueArray:%@ selectnumDict:%@ selectnumStr:%@ selectnum:%ld indexPath.row:%ld @(selectnum):%@",answer_true,asnwer_trueArray,selectnumDict,selectnumStr,(long)selectnum,(long)indexPath.row,@(selectnum));
            
            NSLog(@"[data.answer_trueArray containsObject:@(selectnum)]:%d",[data.answer_trueArray containsObject:selectnumStr]);

            if (indexPath.row==0) {
                
                if (data.isTrue) {// 回答正确
                    
                    if (selectnumStr && selectnum == indexPath.row+1) {// 当前row是用户点击的row
                        
                        cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer1];
                        cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_right"];
                        
                    }
                    
                }else{// 回答错误
                    
                    if (selectnumStr && selectnum == indexPath.row+1) {// 当前row是用户点击的row
                        
                        // 判断用户选择的当前row是否在正确答案内
                        if ([data.answer_trueArray containsObject:selectnumStr]) {
                            
                            cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer1];
                            cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_right"];
                            
                        }else{
                            
                            cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer1];
                            cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_wrong"];
                            
                        }
                        
                    }else{// 当前row不是用户点击的row
                        
                        if ([data.answer_trueArray containsObject:index_row]) {// 判断当前row是否在正确答案中
                            
                            cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer1];
                            cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_A_pick"];
                            
                        }
                        
                    }
                    
                }
                
            }
            
            if (indexPath.row==1){
                
                if (data.isTrue) {// 回答正确
                    
                    if (selectnumStr && selectnum == indexPath.row+1) {// 当前row是用户点击的row
                        
                        cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer2];
                        cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_right"];
                    }
                    
                }else{// 回答错误
                    
                    if (selectnumStr && selectnum == indexPath.row+1) {// 当前row是用户点击的row
                        
                        // 判断用户选择的当前row是否在正确答案内
                        if ([data.answer_trueArray containsObject:selectnumStr]) {
                            
                            cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer2];
                            cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_right"];
                            
                        }else{
                            
                            cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer2];
                            cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_wrong"];
                            
                        }
                        
                    }else{// 当前row不是用户点击的row
                        
                        if ([data.answer_trueArray containsObject:index_row]) {// 判断当前row是否在正确答案中
                            
                            cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer2];
                            cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_B_pick"];
                            
                        }
                        
                    }
                    
                }
                
            }
            
            if (indexPath.row==2){
                
                if (data.isTrue) {// 回答正确
                    
                   if (selectnumStr && selectnum == indexPath.row+1) {// 当前row是用户点击的row
                        
                       cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer3];
                       cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_right"];
                       
                    }
                    
                }else{// 回答错误
                    
                    if (selectnumStr && selectnum == indexPath.row+1) {// 当前row是用户点击的row
                        
                        // 判断用户选择的当前row是否在正确答案内
                        if ([data.answer_trueArray containsObject:selectnumStr]) {
                            
                            cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer3];
                            cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_right"];
                            
                        }else{
                            
                            cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer3];
                            cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_wrong"];
                            
                        }
                        
                    }else{// 当前row不是用户点击的row
                        
                        if ([data.answer_trueArray containsObject:index_row]) {// 判断当前row是否在正确答案中
                            
                            cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer3];
                            cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_C_pick"];
                            
                        }
                        
                    }
                    
                }
                
            }
            
            if (indexPath.row==3){
                
                if (data.isTrue) {// 回答正确
                  
                    if (selectnumStr && selectnum == indexPath.row+1) {// 当前row是用户点击的row
                        
                       cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer4];
                       cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_right"];
                       
                    }
                    
                }else{// 回答错误
                    
                    if (selectnumStr && selectnum == indexPath.row+1) {// 当前row是用户点击的row
                        
                        // 判断用户选择的当前row是否在正确答案内
                        if ([data.answer_trueArray containsObject:selectnumStr]) {
                            
                            cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer4];
                            cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_right"];
                            
                        }else{
                            
                            cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer4];
                            cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_wrong"];
                            
                        }
                        
                    }else{// 当前row不是用户点击的row
                        
                        if ([data.answer_trueArray containsObject:index_row]) {// 判断当前row是否在正确答案中
                            
                            cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer4];
                            cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_D_pick"];
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }else{// 尚未确认
            
            if (data.isSelect) {// 已经选择
                
                NSString *selectIndex = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
                BOOL selectnum = [self.selectnumDict[selectIndex] boolValue];
                NSLog(@"selectIndex:%@---selectnum:%d",selectIndex,selectnum);
                
                if (indexPath.row==0 && selectnum) {
                    
                    cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer1];
                    cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_A_pick"];
                    
                }else if (indexPath.row==1 && selectnum){
                    
                    cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer2];
                    cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_B_pick"];
                    
                }else if (indexPath.row==2 && selectnum){
                    
                    cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer3];
                    cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_C_pick"];
                    
                }else if (indexPath.row==3 && selectnum){
                    
                    cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer4];
                    cell.numberImageView.image = [UIImage imageNamed:@"YBStudySubjectchoose_D_pick"];
                    
                }
                
            }else{// 尚未选择、普通状态
                
            }
            
        }
        
    }
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YBSubjectData *                data = _datearry[self.currentPage];
    if (tableView==_lefttableview && self.currentPage > 0) {
        data = _datearry[self.currentPage-1];
    }else if (tableView==_middletableview){
        data = _datearry[self.currentPage];
    }else if (tableView==_righttableview && self.currentPage < _datearry.count-1){
        data = _datearry[self.currentPage+1];
    }
    
     NSLog(@"%ld data.answer_true:%ld",data.ID,(long)data.answer_true);
    // 1:正确错误 2：单选4个选项 3：4个选项,多选

    if (data.type==1) {

        if (data.answer_true == indexPath.row+1) {
            
            [self obj_showTotasViewWithMes:@"ok"];
            
            data.isDone = YES;
            data.isTrue = YES;
            data.selectNum = indexPath.row;

            [_datearry replaceObjectAtIndex:indexPath.row withObject:data];
            
            // 滚动到下一步
            [self nextQuestion];
            
        }else{
            
            data.isDone = YES;
            data.isTrue = NO;
            data.selectNum = indexPath.row;

            [_datearry replaceObjectAtIndex:indexPath.row withObject:data];
            
            [self reloadDate];
            
            [self obj_showTotasViewWithMes:@"答错了"];
            
        }
        
    }else if (data.type==2){
        
        if (data.answer_true == indexPath.row+1) {
            
            [self obj_showTotasViewWithMes:@"ok"];
            
            data.isDone = YES;
            data.isTrue = YES;
            data.selectNum = indexPath.row;

            [_datearry replaceObjectAtIndex:indexPath.row withObject:data];
            
            // 滚动到下一步
            [self nextQuestion];
            
        }else{
            
            data.isDone = YES;
            data.isTrue = NO;
            data.selectNum = indexPath.row;

            [_datearry replaceObjectAtIndex:indexPath.row withObject:data];
        
            [self reloadDate];

            [self obj_showTotasViewWithMes:@"答错了"];
            
        }
        
    }else{
        
        NSString *selectIndex = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];

        BOOL isSelectnum = [self.selectnumDict[selectIndex] boolValue];
       // NSLog(@"-----------isSelectnum:%d",[self.selectnumDict[selectIndex] boolValue]);
        [self.selectnumDict setValue:@(!isSelectnum) forKey:selectIndex];
        //NSLog(@"+++++++++++isSelectnum:%d",[self.selectnumDict[selectIndex] boolValue]);
       
        NSArray *allValues = [self.selectnumDict allValues];
        //NSLog(@"------allValues:%@ [allValues containsObject:@(1)]:%d",allValues,[allValues containsObject:@(1)]);

        if (![allValues containsObject:@(1)]) {
            [self.selectnumDict removeAllObjects];
        }
        //NSLog(@"++++++allValues:%@ [allValues containsObject:@(1)]:%d",allValues,[allValues containsObject:@(1)]);

        data.isSelect = YES;
        [_datearry replaceObjectAtIndex:self.currentPage withObject:data];
        
        [self reloadDate];
        
    }
    
}

- (void)confimBtnDidClick
{
    YBSubjectData *data = _datearry[self.currentPage];
    //NSLog(@"%ld data.answer_true:%ld data.answer_trueArray:%@",data.ID,(long)data.answer_true,data.answer_trueArray);
    // 1：单选4个选项 2：正确错误 3：4个选项,多选

    data.isDone = YES;
    [data.selectnumDict removeAllObjects];
    
    // key:indexPath.row+1  values:indexPath.row是否是选中状态
    NSArray *allkeys = [self.selectnumDict allKeys];
    
    NSMutableString *selectStr = [NSMutableString string];

    BOOL isTure = NO;
    for (int i = 0; i < allkeys.count; i++) {
        
        NSString *keys = allkeys[i];
        BOOL isSelectnum = [self.selectnumDict[keys] boolValue];
       // NSLog(@"keys:%@---values:%d",keys,isSelectnum);
        
        if (isSelectnum) {// 选中的状态
            
            [selectStr appendString:keys];
            
            //NSLog(@"-------回答正确keys:%@",keys);

            [data.selectnumDict setValue:keys forKey:keys];

            if ([data.answer_trueArray containsObject:keys]) {
            //    NSLog(@"++++++回答正确keys:%@",keys);
//                [data.selectnumArray addObject:keys];
                
                // 通过key:indexpath.row 取得value 如果value有值并且value等于indexpath.row的话就表示用户当前选中
                
            }
            
            if (data.answer_trueArray.count == allkeys.count && [data.answer_trueArray containsObject:keys]) {
                
                isTure=YES;
                
            }else{
                
                isTure=NO;
                
            }
            
        }
        
    }
    
    NSLog(@"self.selectnumDict:%@ data.selectnumDict:%@",self.selectnumDict,data.selectnumDict);

    data.isTrue = isTure;

    data.selectNum = [selectStr integerValue];

    [self.selectnumDict removeAllObjects];

    [_datearry replaceObjectAtIndex:self.currentPage withObject:data];

    if (isTure) {
        
        [self obj_showTotasViewWithMes:@"ok"];
        
        [self nextQuestion];
        
    }else{

        [self obj_showTotasViewWithMes:@"答错了"];
        
        [self reloadDate];
        
    }
    
    
}

- (void)setUpScrollViewSize
{
    // 从数据库中读取上次最后做题记录
    self.currentPage = 10;

//    NSLog(@"-------_scrollview.contentOffset.x:%f self.currentPage:%ld",_scrollview.contentOffset.x,self.currentPage);
    _scrollview.contentOffset = CGPointMake((self.currentPage)*kSystemWide,0);
//    NSLog(@"+++++++_scrollview.contentOffset.x:%f self.currentPage:%ld",_scrollview.contentOffset.x,self.currentPage);
    
    if (self.currentPage < _datearry.count-1) {
        
        _scrollview.contentSize = CGSizeMake(kSystemWide*2+_scrollview.contentOffset.x, 0);
        
        _middletableview.frame = CGRectMake(_scrollview.contentOffset.x,0, kSystemWide, kSystemHeight);
        _lefttableview.frame = CGRectMake(_scrollview.contentOffset.x-kSystemWide, 0, kSystemWide, kSystemHeight);
        _righttableview.frame = CGRectMake(_scrollview.contentOffset.x+kSystemWide, 0, kSystemWide, kSystemHeight);
        
        [self reloadDate];
        
    }
    
}

- (void)nextQuestion
{
    
//    NSLog(@"-------_scrollview.contentOffset.x:%f self.currentPage:%ld",_scrollview.contentOffset.x,self.currentPage);
    self.currentPage++;
    _scrollview.contentOffset = CGPointMake((self.currentPage)*kSystemWide, _scrollview.contentOffset.y);
//    NSLog(@"+++++++_scrollview.contentOffset.x:%f self.currentPage:%ld",_scrollview.contentOffset.x,self.currentPage);

    if (self.currentPage < _datearry.count-1) {
        
        _scrollview.contentSize = CGSizeMake(kSystemWide*2+_scrollview.contentOffset.x, 0);
        
        _middletableview.frame = CGRectMake(_scrollview.contentOffset.x,0, kSystemWide, kSystemHeight);
        _lefttableview.frame = CGRectMake(_scrollview.contentOffset.x-kSystemWide, 0, kSystemWide, kSystemHeight);
        _righttableview.frame = CGRectMake(_scrollview.contentOffset.x+kSystemWide, 0, kSystemWide, kSystemHeight);
        
        [self reloadDate];
        
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint currentOffset = scrollView.contentOffset;
//    NSLog(@"currentOffset.x:%f currentOffset.y:%f",currentOffset.x,currentOffset.y);
    
    int page = (int)currentOffset.x/kSystemWide;
//    NSLog(@"-----------------scrollViewDidEndDecelerating page:%d",page);
    self.currentPage = page;

    if (page < _datearry.count-1 && currentOffset.x!=0) {
        
        _scrollview.contentSize = CGSizeMake(kSystemWide*2+currentOffset.x, 0);
        
        _middletableview.frame = CGRectMake(currentOffset.x,0, kSystemWide, kSystemHeight);
        _lefttableview.frame = CGRectMake(currentOffset.x-kSystemWide, 0, kSystemWide, kSystemHeight);
        _righttableview.frame = CGRectMake(currentOffset.x+kSystemWide, 0, kSystemWide, kSystemHeight);
        
        [self reloadDate];
        
        [self.selectnumDict removeAllObjects];

    }
    
//    NSLog(@"scrollViewDidEndDecelerating self.currentPage:%ld",(long)self.currentPage);
    
}



-(void)reloadDate{
    [_lefttableview reloadData];
    [_middletableview reloadData];
    [_righttableview reloadData];
}
@end
