//
//  JGYuYueHeadView.m
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "JGYuYueHeadView.h"
#import "ToolHeader.h"
#import "JGAppointMentCell.h"
#import "AppointmentCoachTimeInfoModel.h"
#import "YBAppointMentUserFooter.h"

@interface JGYuYueHeadView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (nonatomic,strong) UIView *footView;

@property (nonatomic,strong) YBAppointMentUserFooter *userFooter;

@end

@implementation JGYuYueHeadView

- (NSMutableArray *)upDateArray {
    if (_upDateArray == nil) {
        _upDateArray = [[NSMutableArray alloc] init];
    }
    return _upDateArray;
}
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
- (YBAppointMentUserFooter *)userFooter
{
    if (_userFooter==nil) {
        _userFooter = [[YBAppointMentUserFooter alloc] init];
        _userFooter.userCount = _userCount;
    }
    return _userFooter;
}

- (UICollectionView *)collectionView {
    
    if (_collectionView == nil) {
        
        CGFloat height = kSystemHeight-30-35-50;
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.itemSize = CGSizeMake(kSystemWide/3-0.5, 70);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        flowLayout.footerReferenceSize = CGSizeMake(kSystemWide-rightFooter, 200);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,height) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = RGBColor(236, 236, 236);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[JGAppointMentCell class] forCellWithReuseIdentifier:@"JGAppointMentCell"];
       
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
        [_collectionView registerClass:[self.userFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footView"];
       
    }
    
    return _collectionView;
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
          viewForSupplementaryElementOfKind:(NSString *)kind
                                atIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier = @"footView";
    
    YBAppointMentUserFooter *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
    
    view.userCount = self.userCount;
    view.parentViewController = self.parentViewController;
    
//    KFZGoodExamItem *item=[self.mainArray objectAtIndex:indexPath.section];
    
//    NSString *name=[NSString stringWithFormat:@"%@年【%@】优秀试卷",item.year,item.ename];
    
//    view.titleLabel.text=name;
    
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBColor(238, 238, 238);
        
        [self addSubview:self.collectionView];
        
    }
    return self;
}

- (void)receiveCoachTimeData
{
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    // 行数
    NSInteger hangshu = self.userCount / 4;
    NSLog(@"hangshu::%ld",(long)hangshu);
    CGFloat footHeight = hangshu * 60 + 45;
    NSLog(@"receiveCoachTimeData footHeight:%f",footHeight);
    flowLayout.footerReferenceSize = CGSizeMake(kSystemWide-rightFooter, footHeight);
    self.collectionView.collectionViewLayout = flowLayout;
    
    NSLog(@"receiveCoachTimeData self.userCount:%ld",(long)self.userCount);
    
    [self.collectionView reloadData];
    
    self.userFooter.userCount = self.userCount;
    
}

- (void)receiveCoachTimeData:(NSArray *)coachTimeData {
    
    [self.upDateArray removeAllObjects];
    
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:coachTimeData];
   
    [self.collectionView reloadData];
        
    NSLog(@"self.dataArray.count:%lu",(unsigned long)self.dataArray.count);
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 30;
    
    return self.dataArray.count;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *cellId = @"JGAppointMentCell";
    JGAppointMentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (!cell) {
        DYNSLog(@"创建错误");
    }
    cell.backgroundColor = RGBColor(250, 250, 250);
    
    //    AppointmentCoachTimeInfoModel *model = self.dataArray[indexPath.row];
    
    //    cell.coachTimeInfo = model;
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    AppointmentCoachTimeInfoModel *model = self.dataArray[indexPath.row];

    
    
    
}


@end
