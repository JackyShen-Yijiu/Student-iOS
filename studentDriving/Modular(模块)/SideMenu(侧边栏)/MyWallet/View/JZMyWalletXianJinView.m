//
//  JZMyWalletXianJinView.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZMyWalletXianJinView.h"
#import "JZMyWalletXianJinCell.h"
#define kLKSize [UIScreen mainScreen].bounds.size
static NSString *xianJinCellID = @"xianJinCellID";

@interface JZMyWalletXianJinView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation JZMyWalletXianJinView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = CGRectMake(kLKSize.width * 2, 0, kLKSize.width, kLKSize.height - 238);
        
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
    JZMyWalletXianJinCell *xianJinCell = [tableView dequeueReusableCellWithIdentifier:xianJinCellID];
    
            if (!xianJinCell) {
    
                xianJinCell = [[JZMyWalletXianJinCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:xianJinCellID];
    
                xianJinCell.xianJinNumLabel.text = @"+22";
                xianJinCell.xianJinDateLabel.text = @"2222/22/22";
                xianJinCell.xianJinSourceLabel.text = @"呵呵呵呵";
            }
    
            xianJinCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
            
            return xianJinCell;
    
    
}

@end
