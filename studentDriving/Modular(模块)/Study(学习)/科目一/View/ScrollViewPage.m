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

@implementation ScrollViewPage
{
    UIScrollView *_scrollview;
    UITableView *_lefttableview;
    UITableView *_middletableview;
    UITableView *_righttableview;
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
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, 60)];
    view.backgroundColor = YBNavigationBarBgColor;
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, SIZE.width, 20)];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.text = [NSString stringWithFormat:@"%d、%@",(int)self.currentPage+1,@"下面哪个题目是正确的"];
    NSLog(@"--%d",(int)self.currentPage);
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

    cell.textcontent.text = [NSString stringWithFormat:@"显示内容:%c",(char)('A'+indexPath.row)];
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *str = _datearry[self.currentPage];
     NSLog(@"%@",str);
    
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
