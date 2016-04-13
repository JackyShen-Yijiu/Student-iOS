//
//  JZMyWalletJiFenView.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZMyWalletJiFenView.h"
#import "JZMyWalletJiFenCell.h"
#define kLKSize [UIScreen mainScreen].bounds.size
static NSString *jiFenCellID = @"jiFenCellID";

@interface JZMyWalletJiFenView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation JZMyWalletJiFenView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = CGRectMake(0, 0, kLKSize.width, kLKSize.height - 238);
        
        self.dataSource = self;
        
        self.delegate = self;
        
        self.rowHeight = 72;

        
    }
    return self;

}


#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JZMyWalletJiFenCell *jiFenCell = [tableView dequeueReusableCellWithIdentifier:jiFenCellID];
    
    if (!jiFenCell) {
        
        jiFenCell = [[JZMyWalletJiFenCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:jiFenCellID];
        
        jiFenCell.jiFenNumLabel.text = @"+10";
        jiFenCell.jiFenDateLabel.text = @"2018/18/18";
        jiFenCell.jiFenSourceLabel.text = @"测试测试测试";
    }
    
    jiFenCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return jiFenCell;
   
}

@end
