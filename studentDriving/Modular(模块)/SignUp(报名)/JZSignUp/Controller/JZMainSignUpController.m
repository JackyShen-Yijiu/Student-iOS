//
//  JZMainSignUpController.m
//  studentDriving
//
//  Created by ytzhang on 16/3/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZMainSignUpController.h"
#import "JZSignUpCell.h"
#import "JZSignUpTopCell.h"
#import "JZShowTitleCell.h"
#import "JZSignUpFooterView.h"
#import "JZYListController.h"
#import "YBCoachListViewController.h"
#import "CoachModel.h"
#import "JZPayWayController.h"
#import "JZCoachListController.h"
#import "JZCoachListMoel.h"

@class CoachModel;
@interface JZMainSignUpController ()<UITableViewDataSource,UITableViewDelegate,didCellBackYModelDelegate,JZCoachListViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isShowTitle; // 是否显示班型详细信息

@property (nonatomic, assign) BOOL isCoach; // 用于区分是否是从教练详情里进入的

@property (nonatomic, strong) UIButton *commitButton;

@property (nonatomic, strong) JZSignUpFooterView *footerView;

@property (nonatomic, strong) NSArray *topTitleArray;

@property (nonatomic, strong) NSArray *bottonTitleArray;

@property (nonatomic, strong) NSMutableArray *topDesArray;

@property (nonatomic, strong) NSMutableArray *bottonDesArray;

@property (nonatomic, strong) NSArray *tagArray;

@property (nonatomic, copy) NSString *nameStr;

@property (nonatomic, copy) NSString *phoneStr;

@property (nonatomic, strong) NSString *yStr;

@property (nonatomic, strong) NSString *coachStr;


@property (nonatomic, strong) NSString *coachID;


@end

@implementation JZMainSignUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"报名信息";

    self.view.backgroundColor = RGBColor(226, 226, 233);
    self.tableView.tableFooterView = self.footerView;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.commitButton];
    [self initData];
    
}
- (void)initData{
    self.topTitleArray = @[@"报考驾校",@"报考教练",@"班级类型"];
    self.topDesArray = @[@"报考驾校",@"报考教练",@"班级类型"].mutableCopy;
    
    self.bottonTitleArray = @[@"您的姓名",@"电话号码",@"Y码返现"];
    self.bottonDesArray = @[@"请填写您的真实姓名",@"请填写您的真实号码",@"请选择一张您所领取的Y码"].mutableCopy;
    self.tagArray =  @[@"6000",@"6001",@"6002"];
    [self loadData];

    
}
- (void)loadData {
    // 驾校名
    if (_isFormCoach) {
        NSString *schoolName = _detailDMData.driveschoolinfo.name;
        [_topDesArray replaceObjectAtIndex:0 withObject:schoolName];

    }else{
        NSString *schoolName = _dmData.schoolinfo.name;
        [_topDesArray replaceObjectAtIndex:0 withObject:schoolName];
    }
    
    
    
    
   
    
    
    // 教练名
    NSString *coachName = @"智能匹配";
    
    
    if (_isFormCoach) {
        if (_detailDMData.coachid && _detailDMData.name.length) {
            if (_detailDMData.name && _detailDMData.name.length) {
                coachName = _detailDMData.name;
                _isCoach = YES;
            }
        }

    }
        [_topDesArray replaceObjectAtIndex:1 withObject:coachName];
        
    // 班型
        NSString *classType = [NSString stringWithFormat:@"%@ ￥%lu", _dmData.classname, _dmData.onsaleprice];
        [_topDesArray replaceObjectAtIndex:2 withObject:classType];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isShowTitle)
    {
        if (0 == indexPath.section)
        {
            if (3 == indexPath.row)
            {
                return 50;
            }else{
                return 44;
            }

        } if (1 == indexPath.section) {
            return 44;
        }
    
    }else if (!_isShowTitle) {
        return 44;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isShowTitle) {
        if (0 == section) {
            return 4;
        }else if( 1 == section){
            return 3;
        }
    }else if (!_isShowTitle) {
        return 3;
    }
        return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (1 == section) {
        return 20;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_isShowTitle) {
        // 加载展示班型描述的Cell
        if (0 == indexPath.section) {
            if (3 == indexPath.row) {
                // 展现班型文字描述
                NSString *ID = @"desCell";
                JZShowTitleCell *showTitleCell  = [tableView dequeueReusableCellWithIdentifier:ID];
                if (!showTitleCell) {
                    showTitleCell = [[JZShowTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
                }
                showTitleCell.titleLabel.text = self.dmData.classdesc;
                return showTitleCell;
            }else{
                NSString *topCellID = @"topCell";
                JZSignUpTopCell *signUpTopCell  = [tableView dequeueReusableCellWithIdentifier:topCellID];
                if (!signUpTopCell) {
                    signUpTopCell = [[JZSignUpTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topCellID];
                }
                // 隐藏右侧箭头
                if (0 == indexPath.row) {
                    signUpTopCell.arrowImageView.hidden = YES;
                }
                // 隐藏右侧箭头
                if (_isCoach) {
                    if (0 == indexPath.row || 1 == indexPath.row) {
                        signUpTopCell.arrowImageView.hidden = YES;
                    }
                }
                

                if (2 == indexPath.row) {
                signUpTopCell.lineView.hidden = YES;
                }
                signUpTopCell.titleLabel.text = self.topTitleArray[indexPath.row];
                signUpTopCell.rightLabel.text = self.topDesArray[indexPath.row];
                return signUpTopCell;
            }
            
        }else if(1 == indexPath.section){
            NSString *cellID = @"cellID";
            JZSignUpCell *signUpCell  = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!signUpCell) {
                signUpCell = [[JZSignUpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            signUpCell.titleLabel.text = self.bottonTitleArray[indexPath.row];
            signUpCell.desTextFiled.placeholder = self.bottonDesArray[indexPath.row];
            signUpCell.desTextFiled.tag = [self.tagArray[indexPath.row] integerValue];
            [signUpCell dvvBaseDoubleRowCell_setTextFieldDidEndEditingBlock:^(UITextField *textField, JZSignUpCell *cell) {
                // cell回调
                [self textFieldDidEndEditing:textField cell:cell];
            }];
            // 隐藏右侧箭头
            if (0 == indexPath.row || 1 == indexPath.row) {
                signUpCell.arrowImageView.hidden = YES;
            }
            if (1 == indexPath.row) {
                // 显示数字键盘
                signUpCell.desTextFiled.keyboardType = UIKeyboardTypeNumberPad;
            }
            if (2 == indexPath.row) {
                // UITextFiled 不可编辑
                signUpCell.desTextFiled.enabled = NO;
                signUpCell.lineView.hidden = YES;
            }

            return signUpCell;
        }
        
    } else if (!_isShowTitle){
       //  加载不展示班型描述的Cell
        if (0 == indexPath.section) {
            
                NSString *topCellID = @"topCell";
                JZSignUpTopCell *signUpTopCell  = [tableView dequeueReusableCellWithIdentifier:topCellID];
                if (!signUpTopCell) {
                    signUpTopCell = [[JZSignUpTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topCellID];
                }
            signUpTopCell.titleLabel.text = self.topTitleArray[indexPath.row];
            signUpTopCell.rightLabel.text = self.topDesArray[indexPath.row];
            // 隐藏右侧箭头
            if (0 == indexPath.row) {
                signUpTopCell.arrowImageView.hidden = YES;
            }
            // 隐藏右侧箭头
            if (_isCoach) {
                if (0 == indexPath.row || 1 == indexPath.row) {
                    signUpTopCell.arrowImageView.hidden = YES;
                }
            }

            if (2 == indexPath.row) {
                signUpTopCell.lineView.hidden = YES;
            }

                return signUpTopCell;
            
        }else if(1 == indexPath.section){
            NSString *cellID = @"cellID";
            JZSignUpCell *signUpCell  = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!signUpCell) {
                signUpCell = [[JZSignUpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            signUpCell.titleLabel.text = self.bottonTitleArray[indexPath.row];
            signUpCell.desTextFiled.placeholder = self.bottonDesArray[indexPath.row];
            signUpCell.desTextFiled.tag = [self.tagArray[indexPath.row] integerValue];
            [signUpCell dvvBaseDoubleRowCell_setTextFieldDidEndEditingBlock:^(UITextField *textField, JZSignUpCell *cell) {
                // cell回调
                [self textFieldDidEndEditing:textField cell:cell];
            }];
            // 隐藏右侧箭头
            if (0 == indexPath.row || 1 == indexPath.row) {
                signUpCell.arrowImageView.hidden = YES;
            }
            if (1 == indexPath.row) {
                // 显示数字键盘
                signUpCell.desTextFiled.keyboardType = UIKeyboardTypeNumberPad;
            }
            if (2 == indexPath.row) {
                // UITextFiled 不可编辑
                signUpCell.desTextFiled.enabled = NO;
                signUpCell.lineView.hidden = YES;
            }
            
            return signUpCell;
        }

    }
    
   
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if (0 == indexPath.section) {
       
        if (2 == indexPath.row) {
              // 判断是否显示班型详细详细介绍
            if (_isShowTitle) {
                _isShowTitle = NO;
                JZSignUpTopCell *signUpTopCell = (JZSignUpTopCell *)[tableView cellForRowAtIndexPath:indexPath];
                [ UIView animateWithDuration:0.5 animations:^{
                    signUpTopCell.arrowImageView.transform = CGAffineTransformMakeRotation((M_PI * 2));
                } completion:^(BOOL finished) {
                }];
                [self.tableView reloadData];
            }else if(!_isShowTitle){
                _isShowTitle = YES;
                JZSignUpTopCell *signUpTopCell = (JZSignUpTopCell *)[tableView cellForRowAtIndexPath:indexPath];
               [ UIView animateWithDuration:0.5 animations:^{
                    signUpTopCell.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI / 2);
                } completion:^(BOOL finished) {
                }];
                
                [self.tableView reloadData];
            }
        }
        
        if (1 == indexPath.row) {
            // 报考教练
            if (!_isCoach) {
                JZCoachListController *coachListVC = [[JZCoachListController alloc] init];
                coachListVC.delegate = self;
                coachListVC.dmData = self.dmData;
                coachListVC.schoolid = _detailDMData.driveschoolinfo.ID;
                [self.navigationController pushViewController:coachListVC animated:YES];

            }
                    }
    }
    if (1 == indexPath.section) {
        if (2 == indexPath.row) {
            // Y码选择
            JZYListController *jzListVC = [[JZYListController alloc] init];
            jzListVC.delegate = self;
            [self.navigationController pushViewController:jzListVC animated:YES];
        }
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
#pragma mark ----- UIButton Action
- (void)didCommit:(UIButton *)btn{
    // 提交的点击事件
    
    if (self.nameStr == nil || self.nameStr.length == 0) {
        [self obj_showTotasViewWithMes:@"请输入真实姓名"];
        return;
    }

    if (self.phoneStr == nil || self.phoneStr.length == 0) {
        [self obj_showTotasViewWithMes:@"请输入手机号"];
        return;
    }
    if (![AcountManager isValidateMobile:self.phoneStr]) {
        [self obj_showTotasViewWithMes:@"请输入正确的手机号"];
        return;
    }
    
    NSMutableDictionary *carmodelParams = [NSMutableDictionary dictionary];
    carmodelParams[@"modelsid"] = [NSString stringWithFormat:@"%lu",_dmData.carmodel.modelsid];
    carmodelParams[@"name"] = _dmData.carmodel.name;
    carmodelParams[@"code"] = _dmData.carmodel.code;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"name"] = self.nameStr;
    params[@"idcardnumber"] = @"";
    params[@"telephone"] = _phoneStr;
    params[@"address"] = [AcountManager manager].userAddress;
    params[@"userid"] = [AcountManager manager].userid;
    if (_dmData.schoolinfo.schoolid && _dmData.schoolinfo.schoolid.length) {
        params[@"schoolid"] = _dmData.schoolinfo.schoolid;
    }else{
        params[@"schoolid"] = @"";
    }
    // 如果是从教练进入的，则填写教练ID
    if (_isCoach) {
        params[@"coachid"] = _dmData.coachID;
    }else {
        if ([_coachID isEqualToString:@""] || _coachID == nil) {
            params[@"coachid"] = @"-1";

        }else{
            params[@"coachid"] = _coachID;
        }
        
            }
    
    params[@"classtypeid"] = _dmData.calssid;
    params[@"carmodel"] = [self dictionaryToJson:carmodelParams];
    
    
    NSLog(@"apply params: %@", params);
    
    NSString *applyUrlString = [NSString stringWithFormat:BASEURL,@"userinfo/userapplyschool"];
    
    [JENetwoking startDownLoadWithUrl:applyUrlString postParam:params WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        NSLog(@"报名:data:%@",data);
        
        NSString *type = [NSString stringWithFormat:@"%@",data[@"type"]];
        
        if ([type isEqualToString:@"0"]) {
            [self obj_showTotasViewWithMes:data[@"msg"]];
            return ;
        }
        
        [self obj_showTotasViewWithMes:@"提交成功"];
        
        /*
         
         {
         "type": 1,
         "msg": "",
         "data": "success",
         "extra": {
         "__v": 0,
         "paymoney": 4700,
         //支付金额"payendtime": "2016-02-03T12:29:49.423Z",
         "creattime": "2016-01-31T12:29:49.423Z",
         "userid": "564e1242aa5c58b901e4961a",
         "_id": "56adfe3d323ed17278e71914",
         订单id"discountmoney": 0,
         "applyclasstypeinfo": {
         "onsaleprice": 4700,
         "price": 4700,
         "name": "一步互联网驾校快班",
         "id": "562dd1fd1cdf5c60873625f3"
         },
         "applyschoolinfo": {
         "name": "一步互联网驾校",
         "id": "562dcc3ccb90f25c3bde40da"
         },
         "paychannel": 0,
         userpaystate": 0订单状态//0订单生成1开始支付2支付成功3支付失败4订单取消 //支付方式"
         }
         }
         
         */
        
        NSDictionary *extraDict = data[@"extra"];
        //        NSLog(@"extraDict: %@", extraDict);
        
//        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//        
//        // 存储状态
//        //是否支付失败
//#define isPayErrorKey @"payError"
//        [ud setBool:YES forKey:isPayErrorKey];
//        
//        // 订单信息
//        //#define payErrorWithDictKey @"payErrorWithDict"
//        [ud setObject:extraDict forKey:payErrorWithDictKey];
//        
//        // 支付方式
//        //#define payErrorWithPayType @"payErrorWithPayType"
//        
//        // 手机号码
//        //#define payErrorWithPhone @"payErrorWithPhone"
//        [ud setObject:_phoneStr forKey:payErrorWithPhone];
//        
        
        //使重新报名变为0
//        if ([[ud objectForKey:@"applyAgain"] isEqualToString:@"1"]) {
//            [ud setObject:@"0" forKey:@"applyAgain"];
//        }
//        [ud synchronize];
        JZPayWayController *payWayVC = [[JZPayWayController alloc] init];
        payWayVC.dmData = self.dmData;
        payWayVC.yCodeStr = self.yStr;
        payWayVC.extraDict = extraDict;
        payWayVC.coachName = _coachStr;
        [self.navigationController pushViewController:payWayVC animated:YES];
        
    } withFailure:^(id data) {
    
        [self obj_showTotasViewWithMes:data[@"msg"]];
    }];
}


#pragma mark - UITextField delegate

- (void)textFieldDidEndEditing:(UITextField *)textField cell:(JZSignUpCell *)cell {
    if (6000 == textField.tag) {
        // 姓名回调
        self.nameStr = textField.text;
    }
    if (6001 == textField.tag) {
        // 真实号码回调
        self.phoneStr = textField.text;
    }
}

#pragma mark 将字典转化为JSON字符串
- (NSString*)dictionaryToJson:(NSDictionary *)dict {
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
#pragma mark ---- y码列表点击回调
- (void)initWithYlistModel:(JZYListModel *)ylistModel{
    
    _yStr = ylistModel.Ycode;
    [_bottonDesArray replaceObjectAtIndex:2 withObject:_yStr];
    [self.tableView reloadData];
}
#pragma mark --- 教练列表点击回调
- (void)JZCoachListViewControllerWithCoach:(JZCoachListMoel *)coachModel{
    
    _coachStr = coachModel.name;
    _coachID = coachModel.coachid;
    [_topDesArray replaceObjectAtIndex:1 withObject:_coachStr];
    [self.tableView reloadData];

}
  
#pragma mark ---- Lazy 加载
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight - 64 - 16) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource  = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
- (JZSignUpFooterView *)footerView{
    if (_footerView == nil) {
        _footerView = [[ JZSignUpFooterView alloc] init];
    }
    return _footerView;
}
- (UIButton *)commitButton{
    if (_commitButton == nil) {
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitButton.backgroundColor = YBNavigationBarBgColor;
        CGFloat margin = 18;
        _commitButton.frame = CGRectMake(margin, kSystemHeight - 44 - 64 - 16, kSystemWide - 2 * margin, 44);
        _commitButton.layer.cornerRadius = 5;
        _commitButton.layer.masksToBounds = YES;
        [_commitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(didCommit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitButton;
}
@end
