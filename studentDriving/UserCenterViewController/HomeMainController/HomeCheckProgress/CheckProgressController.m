//
//  CheckProgressController.m
//  studentDriving
//
//  Created by ytzhang on 16/1/26.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "CheckProgressController.h"
#import "CheckProgressCell.h"

@interface CheckProgressController ()<UITableViewDataSource,UITableViewDelegate>

//@property (strong, nonatomic)UITextField *phoneTextField;
//@property (strong, nonatomic)UITextField *authCodeTextFild;
//@property (strong, nonatomic)UITextField *schoolTextFild;
//@property (strong, nonatomic)UITextField *classTextFild;
//@property (strong, nonatomic)UITextField *coachTextFild;
//@property (strong, nonatomic)UITextField *nameTextFild;
//@property (strong, nonatomic)UITextField *idCardTextFild;
//@property (strong, nonatomic)UITextField *progressTextFild;@
@property (nonatomic, strong) UITableView *tableView;

@end
@implementation CheckProgressController
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"cellID";
    CheckProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CheckProgressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 2, self.view.frame.size.width,self.view.frame.size.height - 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 109;
}

@end
