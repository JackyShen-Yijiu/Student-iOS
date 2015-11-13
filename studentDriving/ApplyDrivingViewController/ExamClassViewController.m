//
//  ExamClassViewController.m
//  BlackCat
//
//  Created by 董博 on 15/9/17.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "ExamClassViewController.h"
#import "ExamClassCollectionViewCell.h"
#import "SignUpInfoManager.h"
#import "ExamClassModel.h"
#import <SVProgressHUD.h>
#import "ExamClassDetailViewController.h"
static NSString *const kExamClassType = @"driveschool/schoolclasstype/%@";
@interface ExamClassViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIButton *naviBarRightButton;

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) ExamClassModel *examclassmodel;
@end

@implementation ExamClassViewController
- (UIButton *)naviBarRightButton {
    if (_naviBarRightButton == nil) {
        _naviBarRightButton = [WMUITool initWithTitle:@"完成" withTitleColor:MAINCOLOR withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarRightButton.frame = CGRectMake(0, 0, 44, 44);
        [_naviBarRightButton addTarget:self action:@selector(clickRight:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBarRightButton;
}
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
        [_collectionView registerClass:[ExamClassCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
    }
    return _collectionView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"报考班型";
    self.collectionView.backgroundColor = RGBColor(247, 249, 251);
    [self.view addSubview:self.collectionView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightButton];
    DYNSLog(@"right = %@",self.naviBarRightButton);
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self startDownLoad];
}

- (void)startDownLoad {
    
    [SVProgressHUD show];
    [self.dataArray removeAllObjects];
    NSString *classString = [NSString stringWithFormat:kExamClassType,[SignUpInfoManager getSignUpSchoolid]];
    
    NSString *urlString = [NSString stringWithFormat:BASEURL,classString];
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        DYNSLog(@"res = %@",data);
        
        NSArray *param = data[@"data"];
        
        NSError *error = nil;

        
        [self.dataArray addObjectsFromArray:[MTLJSONAdapter modelsOfClass:ExamClassModel.class fromJSONArray:param error:&error]];
        
        DYNSLog(@"error = %@",error);
        [SVProgressHUD dismiss];
        [self.collectionView reloadData];
    }];
}
#pragma mark - 完成
- (void)clickRight:(UIButton *)sender {
    
    if (![[AcountManager manager].userApplystate isEqualToString:@"2"]){
    
    if (self.examclassmodel == nil) {
        [SVProgressHUD showErrorWithStatus:@"请选择班级类型"];
        return;
    }
    
    NSDictionary *classtypeParam = @{kRealClasstypeid:self.examclassmodel.classid,@"name":self.examclassmodel.classname};
    [SignUpInfoManager signUpInfoSaveRealClasstype:classtypeParam];
    [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
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
    ExamClassCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (!cell) {
        DYNSLog(@"创建错误");
    }
    
    ExamClassModel *model = self.dataArray[indexPath.row];
    cell.drivingName.text = model.classname;
    cell.drivingAdress.text = model.classdesc;
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize cellSize = CGSizeMake(kSystemWide-20, 70);
    return cellSize;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 0, 10);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.examclassmodel = self.dataArray[indexPath.row];
    ExamClassDetailViewController *detail = [[ExamClassDetailViewController alloc] init];
    detail.model = self.examclassmodel;
    [self.navigationController pushViewController:detail animated:YES];
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    kShowDismiss
}
@end
