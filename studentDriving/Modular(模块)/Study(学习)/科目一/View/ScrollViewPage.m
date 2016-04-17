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
#import "YBSubjectQuestionRightBarView.h"
#import "YBSubjectTool.h"

typedef NS_ENUM(NSInteger,scrollViewPageType){
    
    scrollViewPageLeft,
    scrollViewPageMid,
    scrollViewPageRight
    
};

@interface ScrollViewPage ()<UIAlertViewDelegate>

// key:indexPath.row+1  values:indexPath.row是否是选中状态
@property (nonatomic,strong) NSMutableDictionary *selectnumDict;

@property (nonatomic,strong)YBSubjectQuestionsFooter *footer;
@property (nonatomic,strong)YBSubjectQuestionsHeader *header;

@property (nonatomic,strong) YBSubjectQuestionRightBarView *rightBarView;

// 章节
@property (nonatomic,copy)NSString *chapter;
// 科目
@property (nonatomic,assign) subjectType kemu;

@property (nonatomic,assign) NSInteger trueCount;
@property (nonatomic,assign) NSInteger wrongCount;

@property (nonatomic,assign) scrollViewPageType scrollViewPageType;

@end

@implementation ScrollViewPage
{
    UIScrollView *_scrollview;
    UITableView *_lefttableview;
    UITableView *_middletableview;
    UITableView *_righttableview;
    NSMutableArray *_datearry;
    
}

- (NSMutableDictionary *)selectnumDict{
    if (_selectnumDict==nil) {
        _selectnumDict = [NSMutableDictionary dictionary];
    }
    return _selectnumDict;
}

-(instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *)array rightBarView:(YBSubjectQuestionRightBarView *)rightBarView subjectType:(subjectType)kemu chapter:(NSString *)chapter{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _rightBarView = rightBarView;
        _kemu = kemu;
        _chapter = chapter;
        
        _scrollview = [[UIScrollView  alloc]initWithFrame:frame];
        _scrollview.directionalLockEnabled = YES;
        _scrollview.backgroundColor = YBMainViewControlerBackgroundColor;

        _lefttableview = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _lefttableview.backgroundColor = [UIColor blueColor];
        
        _middletableview = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _middletableview.backgroundColor = [UIColor yellowColor];

        _righttableview = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _righttableview.backgroundColor = [UIColor redColor];

        _datearry = [[NSMutableArray alloc] initWithArray:array];
        _scrollview.pagingEnabled = YES;
        _scrollview.bounces = NO;
        _scrollview.showsHorizontalScrollIndicator = NO;
        _scrollview.showsVerticalScrollIndicator = NO;
        
        _scrollview.frame = CGRectMake(0, 0,kSystemWide, kSystemHeight);

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
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"numberOfRowsInSection self.currentPage:%ld self.selectnumDict:%@",(long)self.currentPage,self.selectnumDict);
    
    YBSubjectData *                data;
    
    if (self.selectnumDict && self.selectnumDict.count !=0) {// 点击了多选
        
        data = _datearry[self.currentPage];
        
    }else{
       
        if (_datearry.count==1) {
           
            if (tableView==_righttableview){
                data = _datearry[self.currentPage];
            }
            
        }else if (_datearry.count==2){
            
            if (tableView==_middletableview){
                data = _datearry[self.currentPage];
            }else if (tableView==_righttableview){
                data = _datearry[self.currentPage+1];
            }
            
        }else{
            
            if (tableView==_lefttableview && self.currentPage > 0) {
                data = _datearry[self.currentPage-1];
            }else if (tableView==_middletableview){
                data = _datearry[self.currentPage];
            }else if (tableView==_righttableview && self.currentPage < _datearry.count-1){
                data = _datearry[self.currentPage+1];
            }else{
                data = _datearry[self.currentPage];
            }
            
        }

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
    
    YBSubjectData *                data;
    NSString *title = @"";

    if (self.selectnumDict && self.selectnumDict.count !=0) {// 点击了多选
        
        data = _datearry[self.currentPage];
        title = [NSString stringWithFormat:@"%d、%@",(int)self.currentPage+1,data.question];

    }else{
        
        if (_datearry.count==1) {
            
            if (tableView==_righttableview){
                data = _datearry[self.currentPage];
                title = [NSString stringWithFormat:@"%d、%@",(int)self.currentPage+1,data.question];
            }
            
        }else if (_datearry.count==2){
            
            if (tableView==_middletableview){
                data = _datearry[self.currentPage];
                title = [NSString stringWithFormat:@"%d、%@",(int)self.currentPage+1,data.question];
            }else if (tableView==_righttableview){
                data = _datearry[self.currentPage+1];
                title = [NSString stringWithFormat:@"%d、%@",(int)self.currentPage+2,data.question];
            }
            
        }else{
            
            if (tableView==_lefttableview && self.currentPage > 0) {
                data = _datearry[self.currentPage-1];
                title = [NSString stringWithFormat:@"%d、%@",(int)self.currentPage,data.question];
                
            }else if (tableView==_middletableview){
                data = _datearry[self.currentPage];
                title = [NSString stringWithFormat:@"%d、%@",(int)self.currentPage+1,data.question];
                
            }else if (tableView==_righttableview && self.currentPage < _datearry.count-1){
                data = _datearry[self.currentPage+1];
                title = [NSString stringWithFormat:@"%d、%@",(int)self.currentPage+2,data.question];
                
            }else{
                data = _datearry[self.currentPage];
                title = [NSString stringWithFormat:@"%d、%@",(int)self.currentPage+1,data.question];
                
            }
            
        }
        
        
    }
    
    self.header = [[YBSubjectQuestionsHeader alloc] init];
    
    self.header.titleLable.text = title;
    
    CGFloat sizeH = [self.header.titleLable.text sizeWithFont:[UIFont boldSystemFontOfSize:14] constrainedToSize:CGSizeMake(kSystemWide - 15 - 24 - 10 - 15, MAXFLOAT)].height + 20;
    NSLog(@"viewForHeaderInSection sizeH:%f",sizeH);
    
    if (data.img_url || data.video_url) {
        sizeH += 185;
    }
    
    self.header.frame = CGRectMake(0, 0, kSystemWide, sizeH);
    
    self.header.currentPage = self.currentPage;
    [self.header reloadData:data];
    
    CGFloat scrollViewPage = _scrollview.contentOffset.x;
    NSLog(@"viewForHeaderInSection scrollViewPage:%f",scrollViewPage);
    
    if (self.selectnumDict && self.selectnumDict.count !=0) {// 点击了多选
        
        [self.header playMovie:data];
        
    }else{
        
        if (_datearry.count==1) {
            if (tableView==_righttableview){
                [self.header playMovie:data];
            }
        }else if (_datearry.count==2){
            if (tableView==_middletableview){
                [self.header playMovie:data];
            }
        }else{
            if (tableView==_middletableview){
                [self.header playMovie:data];
            }
        }
        
    }
    
    return self.header;
}

#pragma mark ----- 顶部控件高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  
    YBSubjectData *                data;
    NSString *title = @"";
    
    if (self.selectnumDict && self.selectnumDict.count !=0) {// 点击了多选
        
        data = _datearry[self.currentPage];
        title = [NSString stringWithFormat:@"%d、%@",(int)self.currentPage+1,data.question];
        
    }else{
        
        if (_datearry.count==1) {
            
            if (tableView==_righttableview){
                data = _datearry[self.currentPage];
                title = [NSString stringWithFormat:@"%d、%@",(int)self.currentPage+1,data.question];
            }
            
        }else if (_datearry.count==2){
            
            if (tableView==_middletableview){
                data = _datearry[self.currentPage];
                title = [NSString stringWithFormat:@"%d、%@",(int)self.currentPage+1,data.question];
            }else if (tableView==_righttableview){
                data = _datearry[self.currentPage+1];
                title = [NSString stringWithFormat:@"%d、%@",(int)self.currentPage+2,data.question];
            }
            
        }else{
            
            if (tableView==_lefttableview && self.currentPage > 0) {
                data = _datearry[self.currentPage-1];
                title = [NSString stringWithFormat:@"%d、%@",(int)self.currentPage,data.question];
                
            }else if (tableView==_middletableview){
                data = _datearry[self.currentPage];
                title = [NSString stringWithFormat:@"%d、%@",(int)self.currentPage+1,data.question];
                
            }else if (tableView==_righttableview && self.currentPage < _datearry.count-1){
                data = _datearry[self.currentPage+1];
                title = [NSString stringWithFormat:@"%d、%@",(int)self.currentPage+2,data.question];
                
            }else{
                data = _datearry[self.currentPage];
                title = [NSString stringWithFormat:@"%d、%@",(int)self.currentPage+1,data.question];
            }
            
        }
        
        
    }

    CGFloat sizeH = [title sizeWithFont:[UIFont boldSystemFontOfSize:14] constrainedToSize:CGSizeMake(kSystemWide - 15 - 24 - 10 - 15, MAXFLOAT)].height + 20;

    NSLog(@"heightForHeaderInSection sizeH:%f",sizeH);

    if (data.img_url || data.video_url) {
        return sizeH + 185;
    }
    
    return sizeH;
    
}

#pragma mark ----- 底部控件
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    YBSubjectData *                data;
    
    if (self.selectnumDict && self.selectnumDict.count !=0) {// 点击了多选
        
        data = _datearry[self.currentPage];
        
    }else{
        
        if (_datearry.count==1) {
            
            if (tableView==_righttableview){
                data = _datearry[self.currentPage];
            }
            
        }else if (_datearry.count==2){
            
            if (tableView==_middletableview){
                data = _datearry[self.currentPage];
            }else if (tableView==_righttableview){
                data = _datearry[self.currentPage+1];
            }
            
        }else{
            
            if (tableView==_lefttableview && self.currentPage > 0) {
                data = _datearry[self.currentPage-1];
                
            }else if (tableView==_middletableview){
                data = _datearry[self.currentPage];
                
            }else if (tableView==_righttableview && self.currentPage < _datearry.count-1){
                data = _datearry[self.currentPage+1];
                
            }else{
                data = _datearry[self.currentPage];
                
            }
            
        }
        
    }
    
    if (data.isDone == NO && data.type==3) {// 尚未做过，多选确定按钮
        
        self.footer = [[YBSubjectQuestionsFooter alloc] init];
        self.footer.confimBtn.hidden = NO;
        
        NSArray *allValues = [self.selectnumDict allValues];
        NSLog(@"------allValues:%@ [allValues containsObject:@(1)]:%d",allValues,[allValues containsObject:@(1)]);
        
        if (allValues && allValues.count >= 2) {
            
            BOOL iscontainsYES=NO;
            for (NSNumber *x in allValues) {
                if ([x integerValue]) {
                    iscontainsYES=YES;
                }else{
                    iscontainsYES=NO;
                }
            }
            self.footer.confimBtn.enabled = iscontainsYES;//[allValues containsObject:@(1)];
            self.footer.confimBtn.backgroundColor = iscontainsYES ? YBNavigationBarBgColor : [UIColor lightGrayColor];
            
        }else{
            
            self.footer.confimBtn.enabled = NO;
            self.footer.confimBtn.backgroundColor = [UIColor lightGrayColor];
            
        }
        
        [self.footer.confimBtn addTarget:self action:@selector(confimBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        self.footer.contentView.hidden = YES;
        
        self.footer.frame = CGRectMake(0, 0, kSystemWide, 64);
        
        self.footer.currentPage = self.currentPage;
        self.footer.data = data;
        
        return self.footer;
        
    }else if (data.isDone && data.isTrue==NO){// 已经做过、并且做错出现解释、
        
        self.footer = [[YBSubjectQuestionsFooter alloc] init];
        self.footer.backgroundColor = YBMainViewControlerBackgroundColor;
        self.footer.confimBtn.hidden = YES;
        self.footer.contentView.hidden = NO;
        
        NSString *title = [NSString stringWithFormat:@"答案：%@ %@",data.explain,data.answer_trueStr];
        CGFloat sizeH = [title sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(kSystemWide - 15 - 15, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping].height+20;
        
        self.footer.frame = CGRectMake(0, 0, kSystemWide, sizeH+45+10);
        
        self.footer.currentPage = self.currentPage;
        self.footer.data = data;
        
        return self.footer;
       
    }
    
    return nil;
    
}

#pragma mark ----- 底部控件高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    YBSubjectData *                data;
    
    if (self.selectnumDict && self.selectnumDict.count !=0) {// 点击了多选
        
        data = _datearry[self.currentPage];
        
    }else{
        
        if (_datearry.count==1) {
            
            if (tableView==_righttableview){
                data = _datearry[self.currentPage];
            }
            
        }else if (_datearry.count==2){
            
            if (tableView==_middletableview){
                data = _datearry[self.currentPage];
            }else if (tableView==_righttableview){
                data = _datearry[self.currentPage+1];
            }
            
        }else{
            
            if (tableView==_lefttableview && self.currentPage > 0) {
                data = _datearry[self.currentPage-1];
                
            }else if (tableView==_middletableview){
                data = _datearry[self.currentPage];
                
            }else if (tableView==_righttableview && self.currentPage < _datearry.count-1){
                data = _datearry[self.currentPage+1];
                
            }else{
                data = _datearry[self.currentPage];
                
            }
            
        }
        
        
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
    
    YBSubjectData *                data;
    
    if (self.selectnumDict && self.selectnumDict.count !=0) {// 点击了多选
        
        data = _datearry[self.currentPage];
        
    }else{
        
        if (_datearry.count==1) {
            
            if (tableView==_righttableview){
                data = _datearry[self.currentPage];
            }
            
        }else if (_datearry.count==2){
            
            if (tableView==_middletableview){
                data = _datearry[self.currentPage];
            }else if (tableView==_righttableview){
                data = _datearry[self.currentPage+1];
            }
            
        }else{
            
            if (tableView==_lefttableview && self.currentPage > 0) {
                data = _datearry[self.currentPage-1];
                
            }else if (tableView==_middletableview){
                data = _datearry[self.currentPage];
                
            }else if (tableView==_righttableview && self.currentPage < _datearry.count-1){
                data = _datearry[self.currentPage+1];
                
            }else{
                data = _datearry[self.currentPage];
                
            }
            
        }
        
        
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
    
    NSLog(@"data.question:%@",data.question);
    
     NSLog(@"%ld data.answer_true:%ld data.type:%ld",data.ID,(long)data.answer_true,(long)data.type);
    // 1:正确错误 2：单选4个选项 3：4个选项,多选

    CGPoint currentOffset = _scrollview.contentOffset;
    int page = (int)currentOffset.x/kSystemWide;
    NSLog(@"didSelectRowAtIndexPath scrollViewDidEndDecelerating currentOffset.x:%f currentOffset.y:%f page:%d",currentOffset.x,currentOffset.y,page);
    self.currentPage = page;
    
    if (data.type==1) {

        NSString *selectIndex = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
        BOOL isSelectnum = [self.selectnumDict[selectIndex] boolValue];
        [self.selectnumDict setValue:@(!isSelectnum) forKey:selectIndex];
        
        if (data.answer_true == indexPath.row+1) {
            
           // [self obj_showTotasViewWithMes:@"ok"];
            
            data.isDone = YES;
            data.isTrue = YES;
            data.selectNum = indexPath.row;
            [_datearry replaceObjectAtIndex:self.currentPage withObject:data];
            self.trueCount+=1;

            if (_datearry.count==page+1) {
                
                self.isLastQuestion = YES;
//                [_righttableview reloadData];
                
                if(self.isWrongAndQuestion){
                 
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"已经到最后一题啦" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alert show];
                    
                }
                
            }else{
                
                // 滚动到下一步
                [self nextQuestion];
                
                [self changeRightBarState];
                
                [self.selectnumDict removeAllObjects];

            }
            
        }else{
            
            self.wrongCount+=1;
            data.isDone = YES;
            data.isTrue = NO;
            data.selectNum = indexPath.row;
            [_datearry replaceObjectAtIndex:self.currentPage withObject:data];

           // [self obj_showTotasViewWithMes:@"答错了"];
          
            if(self.isWrongVc==NO){
                [YBSubjectTool isExitWrongQuestionWithtype:_kemu webnoteid:data.ID isExitBlock:^(BOOL isExit) {
                    NSLog(@"isExitWrongQuestionWithtype isExit:%d",isExit);
                    if (!isExit) {
                        [YBSubjectTool insertWrongQuestionwithtype:_kemu webnoteid:data.ID];
                    }
                    
                }];
            }
            
            if (_datearry.count==page+1) {
                
                self.isLastQuestion = YES;
//                [_righttableview reloadData];

                if(self.isWrongAndQuestion){
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"已经到最后一题啦" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alert show];
                    
                }
                
            }else{// 错误
                
                [self reloadDate];

                [self changeRightBarState];
                
                [self.selectnumDict removeAllObjects];

            }
            
        }
        
    }else if (data.type==2){
        
        NSString *selectIndex = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
        BOOL isSelectnum = [self.selectnumDict[selectIndex] boolValue];
        [self.selectnumDict setValue:@(!isSelectnum) forKey:selectIndex];
        
        data.isDone = YES;
        data.isTrue = YES;
        data.selectNum = indexPath.row;
        [_datearry replaceObjectAtIndex:self.currentPage withObject:data];
        
        if (data.answer_true == indexPath.row+1) {
            
            self.trueCount+=1;

         //   [self obj_showTotasViewWithMes:@"ok"];
            
            if (_datearry.count==page+1) {
                
                self.isLastQuestion = YES;
//                [_righttableview reloadData];

                if(self.isWrongAndQuestion){
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"已经到最后一题啦" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alert show];
                    
                }
                
            }else{
                
                // 滚动到下一步
                [self nextQuestion];
                
                [self changeRightBarState];
                
                [self.selectnumDict removeAllObjects];

            }
            
        }else{// 错误
            
            self.wrongCount+=1;
            
            data.isDone = YES;
            data.isTrue = NO;
            data.selectNum = indexPath.row;
            NSLog(@"_datearry.count:%lu indexPath.row:%ld self.currentPage:%ld",(unsigned long)_datearry.count,(long)indexPath.row,(long)self.currentPage);
            [_datearry replaceObjectAtIndex:self.currentPage withObject:data];
//
           // [self obj_showTotasViewWithMes:@"答错了"];
            
            if(self.isWrongVc==NO){
                [YBSubjectTool isExitWrongQuestionWithtype:_kemu webnoteid:data.ID isExitBlock:^(BOOL isExit) {
                    NSLog(@"isExitWrongQuestionWithtype isExit:%d",isExit);
                    if (!isExit) {
                        [YBSubjectTool insertWrongQuestionwithtype:_kemu webnoteid:data.ID];
                    }
                }];
            }
           
            if (_datearry.count==page+1) {
                
                self.isLastQuestion = YES;
//                [_righttableview reloadData];

                if(self.isWrongAndQuestion){
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"已经到最后一题啦" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alert show];
                    
                }
                
            }else{
                
                [self reloadDate];

                [self changeRightBarState];
                
                [self.selectnumDict removeAllObjects];

            }
            
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
        
        NSLog(@"tableView:%@ self.currentPage:%ld",tableView,(long)self.currentPage);
        
        [self reloadDate];
        
    }
    
}

- (void)confimBtnDidClick
{

    CGPoint currentOffset = _scrollview.contentOffset;
    int page = (int)currentOffset.x/kSystemWide;
    NSLog(@"didSelectRowAtIndexPath scrollViewDidEndDecelerating currentOffset.x:%f currentOffset.y:%f page:%d",currentOffset.x,currentOffset.y,page);
    self.currentPage = page;

    if (_datearry.count==page+1) {
        self.isLastQuestion = YES;
    }
    
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
    [_datearry replaceObjectAtIndex:self.currentPage withObject:data];

    // 取得上次保存的状态
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSInteger currentPage = [user integerForKey:[NSString stringWithFormat:@"currentPage-%ld-%@",(long)self.kemu,self.chapter]];
    
    NSLog(@"取得上次保存的状态 currentPage:%ld trueCount:%ld wrongCount:%ld",(long)currentPage,(long)self.trueCount,(long)self.wrongCount);

    if (isTure) {
        
        self.trueCount+=1;

        //[self obj_showTotasViewWithMes:@"ok"];
        
        if (_datearry.count==page+1) {
            
            currentPage=0;
//            [_righttableview reloadData];
            
            if(self.isWrongAndQuestion){
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"已经到最后一题啦" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
                
            }

        }else{
            
            currentPage=self.currentPage+1;
            [self nextQuestion];
            
            [self changeRightBarState];
            
            [self.selectnumDict removeAllObjects];

        }
        
    }else{// 错误

        if(self.isWrongVc==NO){
            [YBSubjectTool isExitWrongQuestionWithtype:_kemu webnoteid:data.ID isExitBlock:^(BOOL isExit) {
                NSLog(@"isExitWrongQuestionWithtype isExit:%d",isExit);
                if (!isExit) {
                    [YBSubjectTool insertWrongQuestionwithtype:_kemu webnoteid:data.ID];
                }
                
            }];
        }
        
        self.wrongCount+=1;
        
       // [self obj_showTotasViewWithMes:@"答错了"];
        
        if (_datearry.count==page+1) {
            
            self.isLastQuestion = YES;
//            [_righttableview reloadData];
            
            if(self.isWrongAndQuestion){
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"已经到最后一题啦" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
                
            }
            
        }else{
            
            [self reloadDate];
            
            [self changeRightBarState];
            
            [self.selectnumDict removeAllObjects];

        }
        
    }
    
}

- (void)changeRightBarState
{

    if (_datearry && _datearry.count==0) {
        NSLog(@"数据为空");
        return;
    }
    
    CGPoint currentOffset = _scrollview.contentOffset;
    int page = (int)currentOffset.x/kSystemWide;
    NSLog(@"scrollViewDidEndDecelerating currentOffset.x:%f currentOffset.y:%f page:%d",currentOffset.x,currentOffset.y,page);

    NSInteger currentPage = page;//self.currentPage;
    float trueCount = self.trueCount;
    float wrongCount = self.wrongCount;
    
    NSString *proportion = [NSString stringWithFormat:@"%ld/%lu",(long)currentPage+1,(unsigned long)_datearry.count];
    NSString *trueCountStr = [NSString stringWithFormat:@"%.0f",trueCount];
    NSString *wrongCountStr = [NSString stringWithFormat:@"%.0f",wrongCount];

    NSString *correctrate = @"0%";
    if (trueCount != 0 || wrongCount!=0) {
        
        correctrate = [NSString stringWithFormat:@"%.0f%@",(trueCount/(trueCount+wrongCount))*100,@"%"];
        
    }

    self.socre = trueCount;
    
    NSLog(@"changeRightBarState currentPage:%ld trueCount:%ld wrongCount:%ld proportion:%@ trueCountStr:%@ wrongCountStr:%@ correctrate:%@ (unsigned long)_datearry.count:%ld",(long)currentPage,(long)trueCount,(long)wrongCount,proportion,trueCountStr,wrongCountStr,correctrate,(unsigned long)_datearry.count);

    for (UIButton *btn in self.rightBarView.subviews) {
        
        switch (btn.tag) {
           
            case 0:// 比例
                
                [btn setTitle:proportion forState:UIControlStateNormal];
                
                break;
                
            case 1:// 正确多少题
                
                [btn setTitle:trueCountStr forState:UIControlStateNormal];

                break;
                
            case 2:// 错误多少题
                
                [btn setTitle:wrongCountStr forState:UIControlStateNormal];

                break;
                
            case 3:// 正确率
                
                [btn setTitle:correctrate forState:UIControlStateNormal];

                break;
                
            case 4:// 倒计时
                
                break;
                
            default:
                break;
        }
    }
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.parentViewController.navigationController popViewControllerAnimated:YES];
}

- (void)setUpScrollViewSize
{
    
    // 从数据库中读取上次最后做题记录
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSInteger currentPage = [user integerForKey:[NSString stringWithFormat:@"currentPage-%ld-%@",(long)self.kemu,self.chapter]];
    NSLog(@"setUpScrollViewSize currentPage:%ld _scrollview.contentOffset.x:%f _datearry.count:%lu",(long)currentPage,_scrollview.contentOffset.x,(unsigned long)_datearry.count);
    if (currentPage>0) {
        currentPage-=1;
    }
    if (currentPage>=_datearry.count-1) {
        currentPage=0;
    }
    self.currentPage = 0;//currentPage;

    // 更新右上角状态
    [self changeRightBarState];
    
    NSLog(@"-------_scrollview.contentOffset.x:%f self.currentPage:%ld",_scrollview.contentOffset.x,self.currentPage);
    _scrollview.contentOffset = CGPointMake((self.currentPage)*kSystemWide,0);
    NSLog(@"+++++++_scrollview.contentOffset.x:%f self.currentPage:%ld",_scrollview.contentOffset.x,self.currentPage);
    
    if (self.currentPage < _datearry.count-1) {
        
        _scrollview.contentSize = CGSizeMake(kSystemWide*2+_scrollview.contentOffset.x, 0);
        
        _middletableview.frame = CGRectMake(_scrollview.contentOffset.x,0, kSystemWide, kSystemHeight);
        _lefttableview.frame = CGRectMake(_scrollview.contentOffset.x-kSystemWide, 0, kSystemWide, kSystemHeight);
        _righttableview.frame = CGRectMake(_scrollview.contentOffset.x+kSystemWide, 0, kSystemWide, kSystemHeight);
        
        [self reloadDate];
        
    }else{
        
        _righttableview.frame = CGRectMake(0,0, kSystemWide, kSystemHeight);
        [_righttableview reloadData];
        
    }
    
}

- (void)nextQuestion
{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        NSLog(@"nextQuestion -------_scrollview.contentOffset.x:%f self.currentPage:%ld",_scrollview.contentOffset.x,self.currentPage);
        self.currentPage+=1;
        _scrollview.contentOffset = CGPointMake((self.currentPage)*kSystemWide, _scrollview.contentOffset.y);
        NSLog(@"+++++++_scrollview.contentOffset.x:%f self.currentPage:%ld",_scrollview.contentOffset.x,self.currentPage);
        
        _scrollview.contentSize = CGSizeMake(kSystemWide*2+_scrollview.contentOffset.x, 0);
        
        _middletableview.frame = CGRectMake(_scrollview.contentOffset.x,0, kSystemWide, kSystemHeight);
        _lefttableview.frame = CGRectMake(_scrollview.contentOffset.x-kSystemWide, 0, kSystemWide, kSystemHeight);
        _righttableview.frame = CGRectMake(_scrollview.contentOffset.x+kSystemWide, 0, kSystemWide, kSystemHeight);
        
        [self.selectnumDict removeAllObjects];
        
        [self reloadDate];

        // 保存本地发生的变化
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setInteger:self.currentPage forKey:[NSString stringWithFormat:@"currentPage-%ld-%@",(long)self.kemu,self.chapter]];
        [user synchronize];
        
        CGPoint currentOffset = _scrollview.contentOffset;
        int page = (int)currentOffset.x/kSystemWide;
        NSLog(@"nextQuestion currentOffset.x:%f currentOffset.y:%f page:%d",currentOffset.x,currentOffset.y,page);

        if (page==0 || page==_datearry.count-1) {
            
            YBSubjectData *data = _datearry[page];
            [self.header playMovie:data];
            
        }
        
    }];
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint currentOffset = _scrollview.contentOffset;
    NSLog(@"scrollViewDidEndDecelerating currentOffset.x:%f currentOffset.y:%f",currentOffset.x,currentOffset.y);
    
    int page = (int)currentOffset.x/kSystemWide;

    NSLog(@"scrollViewDidEndDecelerating scrollViewDidEndDecelerating page:%d",page);
    
    if (_datearry.count==1) {

        NSLog(@"1111111111111 scrollViewDidEndDecelerating scrollViewDidEndDecelerating page:%d",page);

    }else if (_datearry.count==2){
        
        NSLog(@"2222222222222 scrollViewDidEndDecelerating scrollViewDidEndDecelerating page:%d",page);

        if (page==1) {
           
            NSLog(@"++++++++++2222222222222 scrollViewDidEndDecelerating scrollViewDidEndDecelerating page:%d",page);

            YBSubjectData *data = _datearry[page];
            [self.header playMovie:data];
            
        }
        
    }else{
        
        if (page==0 || page==_datearry.count-1) {
            
            YBSubjectData *data = _datearry[page];
            [self.header playMovie:data];
            
        }
        
    }
    
    [self changeRightBarState];
    
    // 8
    if (page < _datearry.count-1 && currentOffset.x!=0) {
        
        self.currentPage = page;
 
        if (page==0) {
            self.scrollViewPageType = scrollViewPageLeft;
        }else if (page==_datearry.count-1){
            self.scrollViewPageType = scrollViewPageRight;
        }else{
            self.scrollViewPageType = scrollViewPageMid;
        }
       
        _scrollview.contentSize = CGSizeMake(kSystemWide*2+currentOffset.x, 0);
        
        _middletableview.frame = CGRectMake(currentOffset.x,0, kSystemWide, kSystemHeight);
        _lefttableview.frame = CGRectMake(currentOffset.x-kSystemWide, 0, kSystemWide, kSystemHeight);
        _righttableview.frame = CGRectMake(currentOffset.x+kSystemWide, 0, kSystemWide, kSystemHeight);
        
        [self reloadDate];
        
        [self.selectnumDict removeAllObjects];
        
        // 保存本地发生的变化
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setInteger:self.currentPage forKey:[NSString stringWithFormat:@"currentPage-%ld-%@",(long)self.kemu,self.chapter]];
        if (self.currentPage==_datearry.count-1) {
            [user setInteger:0 forKey:[NSString stringWithFormat:@"currentPage-%ld-%@",(long)self.kemu,self.chapter]];
        }
        [user synchronize];
        
    }

//    NSLog(@"scrollViewDidEndDecelerating self.currentPage:%ld",(long)self.currentPage);
    
}

-(void)reloadDate{
    [_lefttableview reloadData];
    [_middletableview reloadData];
    [_righttableview reloadData];
}
@end
