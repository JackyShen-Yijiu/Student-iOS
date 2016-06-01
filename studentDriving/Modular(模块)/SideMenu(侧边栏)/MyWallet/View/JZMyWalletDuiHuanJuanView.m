//
//  JZMyWalletDuiHuanJuanView.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZMyWalletDuiHuanJuanView.h"
#import "DVVCreateQRCode.h"
#import <YYModel.h>
#import "NSString+LKString.h"

#define kLKSize [UIScreen mainScreen].bounds.size
static NSString *duiHuanJuanHeaderViewID = @"duiHuanJuanHeaderViewID";
static NSString *duiHuanJuanDetailCellID = @"duiHuanJuanDetailCellID";
static NSString *const knumber = @"create_qrcode";

@interface JZMyWalletDuiHuanJuanView ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,assign) NSInteger selectHeaderViewTag;



@end

@implementation JZMyWalletDuiHuanJuanView
-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBColor(232, 232, 237);
        self.frame = frame;
        
        self.dataSource = self;
        
        self.delegate = self;
        
//        self.rowHeight = 99;
        self.sectionHeaderHeight = 130;
        
        self.separatorStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;

        
        
        [self loadData];
        
    }
    return self;
    
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"self.duiHuanJuanDataArrM.count = %lu",self.duiHuanJuanDataArrM.count);
    
    JZMyWalletDuiHuanJuanData *dataModel = self.duiHuanJuanDataArrM[section];
    
    if (dataModel.openGroup && self.selectHeaderViewTag == section)
        return self.duiHuanJuanDataArrM.count;
    
    return 0;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JZMyWalletDuiHuanJuanCell *duiHuanJuanCell = [tableView dequeueReusableCellWithIdentifier:duiHuanJuanDetailCellID];
    
    if (!duiHuanJuanCell) {
        
        duiHuanJuanCell = [[JZMyWalletDuiHuanJuanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:duiHuanJuanDetailCellID];
        
    }
    duiHuanJuanCell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    if (self.duihuanJuanListArrM.count==1)  {
        JZMyWalletDuiHuanJuanUseproductidlist *list = self.duihuanJuanListArrM[0];

        [duiHuanJuanCell.duiHuanJuanDetailButton setTitle:list.productname forState:UIControlStateNormal];
        duiHuanJuanCell.duiHuanJuanDetailButton01.hidden = YES;
        duiHuanJuanCell.duiHuanJuanDetailButton02.hidden = YES;
        duiHuanJuanCell.duiHuanJuanDetailButton03.hidden = YES;
        duiHuanJuanCell.duiHuanJuanDetailButton04.hidden = YES;
        duiHuanJuanCell.duiHuanJuanDetailButton05.hidden = YES;
        duiHuanJuanCell.duiHuanJuanDetailButton06.hidden = YES;

        
    }
    if (self.duihuanJuanListArrM.count==2) {
        
    JZMyWalletDuiHuanJuanUseproductidlist *list = self.duihuanJuanListArrM[0];
        
    [duiHuanJuanCell.duiHuanJuanDetailButton setTitle:list.productname forState:UIControlStateNormal];
        
    JZMyWalletDuiHuanJuanUseproductidlist *list01 = self.duihuanJuanListArrM[1];
    [duiHuanJuanCell.duiHuanJuanDetailButton01 setTitle:list01.productname forState:UIControlStateNormal];
        
        duiHuanJuanCell.duiHuanJuanDetailButton02.hidden = YES;
        duiHuanJuanCell.duiHuanJuanDetailButton03.hidden = YES;
        duiHuanJuanCell.duiHuanJuanDetailButton04.hidden = YES;
        duiHuanJuanCell.duiHuanJuanDetailButton05.hidden = YES;
        duiHuanJuanCell.duiHuanJuanDetailButton06.hidden = YES;

    }
    if (self.duihuanJuanListArrM.count==3) {
        JZMyWalletDuiHuanJuanUseproductidlist *list = self.duihuanJuanListArrM[0];
        
        [duiHuanJuanCell.duiHuanJuanDetailButton setTitle:list.productname forState:UIControlStateNormal];
        
        JZMyWalletDuiHuanJuanUseproductidlist *list01 = self.duihuanJuanListArrM[1];
        [duiHuanJuanCell.duiHuanJuanDetailButton01 setTitle:list01.productname forState:UIControlStateNormal];
        JZMyWalletDuiHuanJuanUseproductidlist *list02 = self.duihuanJuanListArrM[2];
        
        [duiHuanJuanCell.duiHuanJuanDetailButton02 setTitle:list02.productname forState:UIControlStateNormal];
        duiHuanJuanCell.duiHuanJuanDetailButton03.hidden = YES;
        duiHuanJuanCell.duiHuanJuanDetailButton04.hidden = YES;
        duiHuanJuanCell.duiHuanJuanDetailButton05.hidden = YES;
        duiHuanJuanCell.duiHuanJuanDetailButton06.hidden = YES;
        
        
    }
    if (self.duihuanJuanListArrM.count==4) {
        
        JZMyWalletDuiHuanJuanUseproductidlist *list = self.duihuanJuanListArrM[0];
        
        [duiHuanJuanCell.duiHuanJuanDetailButton setTitle:list.productname forState:UIControlStateNormal];
        
        JZMyWalletDuiHuanJuanUseproductidlist *list01 = self.duihuanJuanListArrM[1];
        [duiHuanJuanCell.duiHuanJuanDetailButton01 setTitle:list01.productname forState:UIControlStateNormal];
        JZMyWalletDuiHuanJuanUseproductidlist *list02 = self.duihuanJuanListArrM[2];
        
        [duiHuanJuanCell.duiHuanJuanDetailButton02 setTitle:list02.productname forState:UIControlStateNormal];

        JZMyWalletDuiHuanJuanUseproductidlist *list03 = self.duihuanJuanListArrM[3];
        
        [duiHuanJuanCell.duiHuanJuanDetailButton03 setTitle:list03.productname forState:UIControlStateNormal];
        duiHuanJuanCell.duiHuanJuanDetailButton04.hidden = YES;
        duiHuanJuanCell.duiHuanJuanDetailButton05.hidden = YES;
        duiHuanJuanCell.duiHuanJuanDetailButton06.hidden = YES;

        
        
    }
    if (self.duihuanJuanListArrM.count==5) {
        JZMyWalletDuiHuanJuanUseproductidlist *list = self.duihuanJuanListArrM[0];
        
        [duiHuanJuanCell.duiHuanJuanDetailButton setTitle:list.productname forState:UIControlStateNormal];
        
        JZMyWalletDuiHuanJuanUseproductidlist *list01 = self.duihuanJuanListArrM[1];
        [duiHuanJuanCell.duiHuanJuanDetailButton01 setTitle:list01.productname forState:UIControlStateNormal];
        JZMyWalletDuiHuanJuanUseproductidlist *list02 = self.duihuanJuanListArrM[2];
        
        [duiHuanJuanCell.duiHuanJuanDetailButton02 setTitle:list02.productname forState:UIControlStateNormal];
        
        JZMyWalletDuiHuanJuanUseproductidlist *list03 = self.duihuanJuanListArrM[3];
        
        [duiHuanJuanCell.duiHuanJuanDetailButton03 setTitle:list03.productname forState:UIControlStateNormal];

        JZMyWalletDuiHuanJuanUseproductidlist *list04 = self.duihuanJuanListArrM[4];
        
        [duiHuanJuanCell.duiHuanJuanDetailButton04 setTitle:list04.productname forState:UIControlStateNormal];
        duiHuanJuanCell.duiHuanJuanDetailButton05.hidden = YES;
        duiHuanJuanCell.duiHuanJuanDetailButton06.hidden = YES;
        
           }
    if (self.duihuanJuanListArrM.count==6) {
        JZMyWalletDuiHuanJuanUseproductidlist *list = self.duihuanJuanListArrM[0];
        
        [duiHuanJuanCell.duiHuanJuanDetailButton setTitle:list.productname forState:UIControlStateNormal];
        
        JZMyWalletDuiHuanJuanUseproductidlist *list01 = self.duihuanJuanListArrM[1];
        [duiHuanJuanCell.duiHuanJuanDetailButton01 setTitle:list01.productname forState:UIControlStateNormal];
        JZMyWalletDuiHuanJuanUseproductidlist *list02 = self.duihuanJuanListArrM[2];
        
        [duiHuanJuanCell.duiHuanJuanDetailButton02 setTitle:list02.productname forState:UIControlStateNormal];
        
        JZMyWalletDuiHuanJuanUseproductidlist *list03 = self.duihuanJuanListArrM[3];
        
        [duiHuanJuanCell.duiHuanJuanDetailButton03 setTitle:list03.productname forState:UIControlStateNormal];
        
        JZMyWalletDuiHuanJuanUseproductidlist *list04 = self.duihuanJuanListArrM[4];
        
        [duiHuanJuanCell.duiHuanJuanDetailButton04 setTitle:list04.productname forState:UIControlStateNormal];
        
        JZMyWalletDuiHuanJuanUseproductidlist *list05 = self.duihuanJuanListArrM[5];
        
        [duiHuanJuanCell.duiHuanJuanDetailButton05 setTitle:list05.productname forState:UIControlStateNormal];
        
        duiHuanJuanCell.duiHuanJuanDetailButton06.hidden = YES;
        
            }
    if (self.duihuanJuanListArrM.count==7)  {
        
        JZMyWalletDuiHuanJuanUseproductidlist *list = self.duihuanJuanListArrM[0];
        
        [duiHuanJuanCell.duiHuanJuanDetailButton setTitle:list.productname forState:UIControlStateNormal];
        
        JZMyWalletDuiHuanJuanUseproductidlist *list01 = self.duihuanJuanListArrM[1];
        [duiHuanJuanCell.duiHuanJuanDetailButton01 setTitle:list01.productname forState:UIControlStateNormal];
        JZMyWalletDuiHuanJuanUseproductidlist *list02 = self.duihuanJuanListArrM[2];
        
        [duiHuanJuanCell.duiHuanJuanDetailButton02 setTitle:list02.productname forState:UIControlStateNormal];
        
        JZMyWalletDuiHuanJuanUseproductidlist *list03 = self.duihuanJuanListArrM[3];
        
        [duiHuanJuanCell.duiHuanJuanDetailButton03 setTitle:list03.productname forState:UIControlStateNormal];
        
        JZMyWalletDuiHuanJuanUseproductidlist *list04 = self.duihuanJuanListArrM[4];
        
        [duiHuanJuanCell.duiHuanJuanDetailButton04 setTitle:list04.productname forState:UIControlStateNormal];
        
        JZMyWalletDuiHuanJuanUseproductidlist *list05 = self.duihuanJuanListArrM[5];
        
        [duiHuanJuanCell.duiHuanJuanDetailButton05 setTitle:list05.productname forState:UIControlStateNormal];
        
        JZMyWalletDuiHuanJuanUseproductidlist *list06 = self.duihuanJuanListArrM[6];
        [duiHuanJuanCell.duiHuanJuanDetailButton06 setTitle:list06.productname forState:UIControlStateNormal];
        
        
    }


    return duiHuanJuanCell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.duiHuanJuanDataArrM.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.duihuanJuanListArrM.count * 14 + 58;
}

// 用来返回每一组的头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    // 1.创建headerView
    JZMyWalletDuiHuanJuanHeaderView *duiHuanJuanHeaerView = [JZMyWalletDuiHuanJuanHeaderView duiHuanJuanHeaderViewWithTableView:tableView withTag:section];
    
    
    // 2.给headerView传递模型
    duiHuanJuanHeaerView.duiHuanJuanDetailView.tag = section;
    duiHuanJuanHeaerView.duiHuanJuanDetailView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(duiHuanJuanHeaerViewDidClick:)];
    [duiHuanJuanHeaerView.duiHuanJuanDetailView addGestureRecognizer:tap];
    
    self.duiHuanJuanHeaerView = duiHuanJuanHeaerView;
    
    JZMyWalletDuiHuanJuanData *data = self.duiHuanJuanDataArrM[section];

    
    duiHuanJuanHeaerView.spendDateLabel.text = [NSString stringWithFormat:@"有效期至：%@",[NSString getYearLocalDateFormateUTCDate:data.createtime style:LKDateStyleNoHaveTime]];
    
    
    
    
    // 生成二维码
    NSString *resultStr = [NSString stringWithFormat:BASEURL,knumber];
    NSString *str = @"?text=";
    NSString *lastStr = @"&size=46";
    
    NSString *finishResultStr = [NSString stringWithFormat:@"%@%@%@%@",resultStr,str,data.orderscanaduiturl,lastStr];

    [duiHuanJuanHeaerView.QRCodeImg sd_setImageWithURL:[NSURL URLWithString:finishResultStr] placeholderImage:[UIImage imageNamed:@"code_null"]];
    
    
    self.duiHuanJuanHeaerView.QRCodeImg.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeBigImg)];
    [self.duiHuanJuanHeaerView.QRCodeImg addGestureRecognizer:tapGesture];
    
    if (data.openGroup == YES) {
        
        // 让按钮中的小图片旋转正的90度
        self.duiHuanJuanHeaerView.seeDetailImg.transform = CGAffineTransformMakeRotation(M_PI);
        
    } else {
        
        // 关闭让图片再还原
        self.duiHuanJuanHeaerView.seeDetailImg.transform = CGAffineTransformMakeRotation(0);
        
    }
    
    if (data.couponcomefrom == 1) {
        
        duiHuanJuanHeaerView.duiHuanJuanName.text = @"报名奖励兑换券";
    }else if(data.couponcomefrom == 2) {
        
        duiHuanJuanHeaerView.duiHuanJuanName.text = @"活动奖励兑换券";

    }


    
    // 3.返回haderView
    return duiHuanJuanHeaerView;
    
    
}
-(void)seeBigImg{
    
    NSLog(@"测试测试测试");
    
    
    JZMyWalletDuiHuanJuanData *data = self.duiHuanJuanDataArrM[self.duiHuanJuanHeaerView.tag];
    
    
    // 生成二维码
    NSString *resultStr = [NSString stringWithFormat:BASEURL,knumber];
    NSString *str = @"?text=";
    NSString *lastStr = @"&size=46";
    
    NSString *finishResultStr = [NSString stringWithFormat:@"%@%@%@%@",resultStr,str,data.orderscanaduiturl,lastStr];

    [self showQRInfoWithImageStr:finishResultStr];

}
- (void)showQRInfoWithImageStr:(NSString *)imagestr {
    
    UIView *bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeQRCodeBgView:)];
    [bgView addGestureRecognizer:tapGes];
    bgView.userInteractionEnabled = YES;
    
    bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    bgView.alpha = 0;
    UIImageView *imageView = [UIImageView new];
    imageView.bounds = CGRectMake(0, 0, 0, 0);
    imageView.center = bgView.center;
    [imageView sd_setImageWithURL:[NSURL URLWithString:imagestr] placeholderImage:nil];
    [bgView addSubview:imageView];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        bgView.alpha = 1;
        imageView.bounds = CGRectMake(0, 0, 188, 188);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)closeQRCodeBgView:(UITapGestureRecognizer *)tagGes {
    
    UIView *view = tagGes.view;
    [UIView animateWithDuration:0.3 animations:^{
        view.alpha = 0;
    } completion:^(BOOL finished) {
        [tagGes.view removeFromSuperview];
    }];
}

//-(void)setDataModel:(JZMyWalletDuiHuanJuanData *)dataModel {
//    
//    
//    _dataModel = dataModel;
//    
//    // 判断当前组是否打开或关闭,对头上的图片是否旋转做判断
//    // 如果是打开了,让按钮图片旋转
//    if (self.dataModel.openGroup == YES) {
//        
//        // 让按钮中的小图片旋转正的90度
//        self.duiHuanJuanHeaerView.seeDetailImg.transform = CGAffineTransformMakeRotation(M_PI);
//        
//    } else {
//        // 关闭让图片再还原
//        self.duiHuanJuanHeaerView.seeDetailImg.transform = CGAffineTransformMakeRotation(0);
//        
//    }
//
//}
#pragma mark - 点击兑换劵下拉视图方法
-(void)duiHuanJuanHeaerViewDidClick:(UITapGestureRecognizer *)tap {
    
    
    JZMyWalletDuiHuanJuanData *dataModel = self.duiHuanJuanDataArrM[self.selectHeaderViewTag];

    dataModel.openGroup = !dataModel.openGroup;
    
    [self.duiHuanJuanDataArrM replaceObjectAtIndex:self.selectHeaderViewTag withObject:dataModel];
    
    // 打开本分组
    NSInteger selectHeaderViewTag = tap.view.tag;
    NSLog(@"selectHeaderViewTag:%ld",(long)selectHeaderViewTag);
    self.selectHeaderViewTag = selectHeaderViewTag;
    
    [self getDuiHuanJuanDetail:dataModel.openGroup];


}


-(void)loadData {
    
    NSString *urlString = [NSString stringWithFormat:BASEURL, @"userinfo/getmycupon"];
    NSDictionary *paramsDict = @{@"userid": [AcountManager manager].userid};
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:paramsDict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        if ([[data objectForKey:@"type"] integerValue]) {
            
            NSArray *array = data[@"data"];
            
            NSLog(@"%@",array);
            if (array.count) {
                NSArray *duiHuanJuanDataArr = data[@"data"];
                for (NSDictionary *dict in duiHuanJuanDataArr) {
                    
                    JZMyWalletDuiHuanJuanData *data = [JZMyWalletDuiHuanJuanData yy_modelWithDictionary:dict];
                    
                    if(data.state == 0 || data.state == 1){
                    
                    [self.duiHuanJuanDataArrM addObject:data];
                    }
                }
                
                [self reloadData];
                
            }
            
  
        }
        
    } withFailure:^(id data) {
        
        
    }];

}

-(void)getDuiHuanJuanDetail:(BOOL)openGroup {
    
    
    if (openGroup==NO) {
    
        [self reloadData];
        
        return;
    }
    
    JZMyWalletDuiHuanJuanData *dataModel = self.duiHuanJuanDataArrM[self.selectHeaderViewTag];
    

    NSString *urlString = [NSString stringWithFormat:BASEURL, @"userinfo/getmycupon"];
    NSDictionary *paramsDict = @{@"userid": [AcountManager manager].userid};
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:paramsDict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        if ([[data objectForKey:@"type"] integerValue]) {
            
            NSArray *array = data[@"data"];
            
            NSLog(@"%@",array);
            if (array.count) {
                
                 dataModel.openGroup = YES;
                
                [self.duiHuanJuanDataArrM replaceObjectAtIndex:self.selectHeaderViewTag withObject:dataModel];
                
                [self.duihuanJuanListArrM removeAllObjects];
                
                NSArray *duiHuanJuanDataArr = data[@"data"];
                
            
                for (NSDictionary *dict in duiHuanJuanDataArr) {
                    
                    JZMyWalletDuiHuanJuanData *data = [JZMyWalletDuiHuanJuanData yy_modelWithDictionary:dict];
                    
                    NSArray *listArr = data.useproductidlist;
                    
                    if(data.state == 0 || data.state == 1){

                    
                    for (NSDictionary *dict in listArr) {
                        
                        
                        JZMyWalletDuiHuanJuanUseproductidlist *list = [JZMyWalletDuiHuanJuanUseproductidlist yy_modelWithDictionary:dict];
                        
                        [self.duihuanJuanListArrM addObject:list];
  
                    }
                        
                    }
                    
                    //[self reloadData];
                }
                
                [self reloadData];
                
            }
            
            
        }
        
    } withFailure:^(id data) {
        
        [self obj_showTotasViewWithMes:@"网络错误"];
        
    }];
    

    
}



-(NSMutableArray *)duiHuanJuanDataArrM {
    
    if (_duiHuanJuanDataArrM ==  nil) {
        
        _duiHuanJuanDataArrM = [[NSMutableArray alloc]init];
    }
    return _duiHuanJuanDataArrM;
}
-(NSMutableArray *)duihuanJuanListArrM {
    
    if (_duihuanJuanListArrM==  nil) {
        
        _duihuanJuanListArrM = [[NSMutableArray alloc]init];
    }
    return _duihuanJuanListArrM;
}

@end
