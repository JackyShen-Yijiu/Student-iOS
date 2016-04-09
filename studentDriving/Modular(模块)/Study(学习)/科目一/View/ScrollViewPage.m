//
//  ScrollViewPage.m
//  ScollViewPage
//
//  Created by allen on 15/9/18.
//  Copyright (c) 2015年 Allen. All rights reserved.
//
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)                        RGBA(r, g, b, 1.0f)

#define SIZE    self.frame.size
#import "ScrollViewPage.h"
#import "PageTableViewCell.h"
#import "YBSubjectData.h"

@implementation ScrollViewPage
{
    UIScrollView *_scrollview;
    UITableView *_lefttableview;
    UITableView *_middletableview;
    UITableView *_righttableview;
    UIButton *confimBtn;
    NSArray *_datearry;

}

-(instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *)array{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollview = [[UIScrollView  alloc]initWithFrame:frame];
        _lefttableview = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _middletableview = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _righttableview = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _datearry = [[NSArray alloc]initWithArray:array];
        _scrollview.pagingEnabled = YES;
        _scrollview.bounces = NO;
        _scrollview.showsHorizontalScrollIndicator = NO;
        _scrollview.showsVerticalScrollIndicator = NO;
        if (_datearry.count>1) {
            _scrollview.contentSize = CGSizeMake(SIZE.width*2, 0);
        }
        
        [self creatUI];
    }
    return self;
}

//创建ui界面

-(void)creatUI{
    _scrollview.frame = CGRectMake(0, 0,SIZE.width, SIZE.height );
    _lefttableview.frame = CGRectMake(0, 0, SIZE.width, SIZE.height);
    _middletableview.frame = CGRectMake(0, 0, SIZE.width, SIZE.height);
    _righttableview.frame = CGRectMake(0, 0, SIZE.width, SIZE.height);
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
    
    confimBtn = [[UIButton alloc] init];
    confimBtn.frame = CGRectMake(20, self.height-20, self.width-40, 40);
    [confimBtn setTitle:@"确认" forState:UIControlStateNormal];
    [confimBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [confimBtn addTarget:self action:@selector(confimBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollview addSubview:confimBtn];
    confimBtn.hidden = YES;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    YBSubjectData *data = _datearry[self.currentPage];
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, 60)];
    view.backgroundColor = YBNavigationBarBgColor;
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SIZE.width-30, 60)];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.numberOfLines = 0;
    
    YBSubjectData *data = _datearry[self.currentPage];
    NSLog(@"viewForHeaderInSection data.type:%ld data.ID:%ld",(long)data.type,data.ID);
    
    confimBtn.hidden = data.type == 3 ? NO : YES;
    
    lable.text = [NSString stringWithFormat:@"%d、%@",(int)self.currentPage+1,data.question];
    
    [view addSubview:lable];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellID = @"PageTableViewCell";
    PageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PageTableViewCell" owner:self options:nil]lastObject];
        cell.numberlable.layer.masksToBounds = YES;
        cell.numberlable.layer.cornerRadius = 5;
    }
    
    cell.numberlable.text = [NSString stringWithFormat:@"%c",(char)('A'+indexPath.row)];

    YBSubjectData *data = _datearry[self.currentPage];

// 1:正确错误 2：单选4个选项 3：4个选项,多选
    if (data.type==1) {
        if (indexPath.row==0) {
            
            cell.textcontent.text = @"正确";
            
        }else if (indexPath.row==1){
            
            cell.textcontent.text = @"错误";
            
        }
        
    }else if (data.type==2){

        if (indexPath.row==0) {
            
            cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer1];
            
        }else if (indexPath.row==1){
            
            cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer2];
            
        }else if (indexPath.row==2){
            
            cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer3];
            
        }else if (indexPath.row==3){
            
            cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer4];
            
        }
        
    }else if (data.type==3){

        if (indexPath.row==0) {
            
            cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer1];
            
        }else if (indexPath.row==1){
            
            cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer2];
            
        }else if (indexPath.row==2){
            
            cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer3];
            
        }else if (indexPath.row==3){
            
            cell.textcontent.text = [NSString stringWithFormat:@"%@",data.answer4];
            
        }
        
    }
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     YBSubjectData *data = _datearry[self.currentPage];
     NSLog(@"%ld data.answer_true:%ld",data.ID,(long)data.answer_true);
    // 1:正确错误 2：单选4个选项 3：4个选项,多选

    if (data.type==1) {

        
        if (data.answer_true == indexPath.row+1) {
            
            [self obj_showTotasViewWithMes:@"ok"];
            
            // 滚动到下一步
            [self scrollviewNext:_scrollview];
            
        }else{
            
            [self obj_showTotasViewWithMes:@"答错了"];
            
        }
        
    }else if (data.type==2){
        
        if (data.answer_true == indexPath.row+1) {
            
            [self obj_showTotasViewWithMes:@"ok"];
            
            // 滚动到下一步
            [self scrollviewNext:_scrollview];
            
        }else{
            
            [self obj_showTotasViewWithMes:@"答错了"];
            
        }
        
    }else if (data.type==3){

        
        
    }
    
   
    
}

- (void)confimBtnDidClick
{
    YBSubjectData *data = _datearry[self.currentPage];
    NSLog(@"%ld data.answer_true:%ld",data.ID,(long)data.answer_true);
    // 1：单选4个选项 2：正确错误 3：4个选项,多选

    NSString *type = [NSString stringWithFormat:@"%ld",(long)data.type];

    
}

- (void)scrollviewNext:(UIScrollView *)scrollView
{
    NSLog(@"-----之前--------%d",(int)self.currentPage);
    [UIView animateWithDuration:0.1 animations:^{
        
        CGPoint currentOffset = scrollView.contentOffset;
        int page = (int)currentOffset.x/SIZE.width + 1;
        if (page < _datearry.count-1) {
            _scrollview.contentSize = CGSizeMake(SIZE.width*2+currentOffset.x, 0);
            _middletableview.frame = CGRectMake(currentOffset.x,0, SIZE.width, SIZE.height);
            _lefttableview.frame = CGRectMake(currentOffset.x-SIZE.width, 0, SIZE.width, SIZE.height);
            _righttableview.frame = CGRectMake(currentOffset.x+SIZE.width, 0, SIZE.width, SIZE.height);
        }
        self.currentPage = page;
        [self reloadDate];
        
    }];
    NSLog(@"------之后-------%d",(int)self.currentPage);

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    CGPoint currentOffset = scrollView.contentOffset;
    int page = (int)currentOffset.x/SIZE.width;
    if (page < _datearry.count-1) {
        _scrollview.contentSize = CGSizeMake(SIZE.width*2+currentOffset.x, 0);
        _middletableview.frame = CGRectMake(currentOffset.x,0, SIZE.width, SIZE.height);
        _lefttableview.frame = CGRectMake(currentOffset.x-SIZE.width, 0, SIZE.width, SIZE.height);
        _righttableview.frame = CGRectMake(currentOffset.x+SIZE.width, 0, SIZE.width, SIZE.height);
    }
    self.currentPage = page;
    NSLog(@"-------------%d",(int)self.currentPage);
    [self reloadDate];
}

-(void)reloadDate{
    [_middletableview reloadData];
    [_lefttableview reloadData];
    [_righttableview reloadData];

}
@end
