//
//  ExamCarViewController.m
//  BlackCat
//
//  Created by 董博 on 15/9/17.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "ExamCarViewController.h"
#import "ToolHeader.h"
#import "ExamCarCollectionViewCell.h"
#import "ExamCarModel.h"
#import "SignUpInfoManager.h"
#import "BLInformationManager.h"

static NSString *const kexamCar = @"info/carmodel";

@interface ExamCarViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSIndexPath *rememberIndexPath;
@property (strong, nonatomic) UIButton *naviBarRightButton;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (weak, nonatomic) ExamCarModel *carModel;
@end

@implementation ExamCarViewController

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout  = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView =  [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kSystemWide, kSystemHeight-64) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ExamCarCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
    }
    return _collectionView;
}
- (UIButton *)naviBarRightButton {
    if (_naviBarRightButton == nil) {
        _naviBarRightButton = [WMUITool initWithTitle:@"完成" withTitleColor:[UIColor whiteColor] withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarRightButton.frame = CGRectMake(0, 0, 44, 44);
        [_naviBarRightButton addTarget:self action:@selector(clickRight:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBarRightButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.rememberIndexPath = nil;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"报考车型";
    self.collectionView.backgroundColor = RGBColor(247, 249, 251);
    [self.view addSubview:self.collectionView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightButton];
    DYNSLog(@"right = %@",self.naviBarRightButton);
    self.navigationItem.rightBarButtonItem = rightItem;

    
    [self startDownLoad];
    
}
- (void)startDownLoad {
    
    NSString *urlString = [NSString stringWithFormat:BASEURL,kexamCar];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        DYNSLog(@"data = %@",data);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSArray *param = data[@"data"];
        NSError *error = nil;
        
        [self.dataArray addObjectsFromArray: [MTLJSONAdapter modelsOfClass:ExamCarModel.class fromJSONArray:param error:&error]];
        DYNSLog(@"error = %@",error);
        [self.collectionView reloadData];
    }];
    
}
#pragma mark - 完成

- (void)clickRight:(UIButton *)sender {
    
//    if (![[AcountManager manager].userApplystate isEqualToString:@"2"]) {
//        if (self.carModel == nil) {
//            [self showTotasViewWithMes:@"请选择车型"];
//            return;
//        }
    if ([self.carModel.name isEqualToString:@""]|| self.carModel.name == nil) {
        [self obj_showTotasViewWithMes:@"请选择报考车型"];
        return;
    }
    NSDictionary *param = @{@"modelsid":self.carModel.modelsid,@"name":self.carModel.name,@"code":self.carModel.code};
    [SignUpInfoManager  signUpInfoSaveRealCarmodel:param];
    [self.navigationController popViewControllerAnimated:YES];
//    }
  
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    DYNSLog(@"count = %lu",self.dataArray.count);
    collectionView.hidden = YES;
    if (self.dataArray.count > 0) {
        collectionView.hidden = NO;
        return self.dataArray.count;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    ExamCarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.drivingTypeDetailLabel.textColor = TEXTGRAYCOLOR;
    cell.drivingTypeLabel.textColor = [UIColor blackColor];
   
    
    if (!cell) {
        DYNSLog(@"创建错误");
    }
    ExamCarModel *carModel = self.dataArray[indexPath.row];
    DYNSLog(@"carModel = %@",carModel.code);
    cell.drivingTypeLabel.text = carModel.code;
    cell.drivingTypeDetailLabel.text = carModel.name;
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize cellSize = CGSizeMake(kSystemWide-30, 140);
    return cellSize;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 0, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
////    [collectionView reloadData];
//    [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    ExamCarCollectionViewCell *cell = (ExamCarCollectionViewCell *) [collectionView cellForItemAtIndexPath:indexPath];
    if (self.rememberIndexPath != nil && ![self.rememberIndexPath isEqual:indexPath]) {
        [collectionView reloadItemsAtIndexPaths:@[self.rememberIndexPath]];
    }
    cell.drivingTypeLabel.textColor = MAINCOLOR;
    cell.drivingTypeDetailLabel.textColor = MAINCOLOR;
    self.rememberIndexPath = indexPath;
  
    self.carModel = self.dataArray[indexPath.row];
}
@end
