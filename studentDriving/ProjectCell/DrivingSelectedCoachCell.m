//
//  DrivingSelectedCoachCell.m
//  BlackCat
//
//  Created by bestseller on 15/9/30.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "DrivingSelectedCoachCell.h"
#import "ToolHeader.h"
#import "DrivingSelectedCoachCollectionCell.h"
#import "CoachModel.h"
@interface DrivingSelectedCoachCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UIView *backGroundView;
@property (strong, nonatomic) UILabel *coachTitle;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *dataArray;
@end
@implementation DrivingSelectedCoachCell
- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 150)];
    }
    return _backGroundView;
}
- (UILabel *)coachTitle {
    
    if (_coachTitle == nil) {
        _coachTitle = [WMUITool initWithTextColor:[UIColor blackColor] withFont:    [UIFont boldSystemFontOfSize:14]];
        _coachTitle.text = @"选择教练";
    }
    return _coachTitle;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 12;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 18+14+14, kSystemWide-30, 90) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[DrivingSelectedCoachCollectionCell class] forCellWithReuseIdentifier:@"collectionCell"];
    }
    return _collectionView;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    
    [self.contentView addSubview:self.backGroundView];
   
    [self.backGroundView addSubview:self.coachTitle];
    
    [self.coachTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(18);
//        make.height.mas_equalTo(@40);
    }];
    
    [self.backGroundView addSubview:self.collectionView];

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"collectionCell";
    DrivingSelectedCoachCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (!cell) {
        DYNSLog(@"创建错误");
    }
    CoachModel *model = self.dataArray[indexPath.row];
    [cell receiveCoachMessage:model];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize cellSize = CGSizeMake(60, 90);
    return cellSize;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CoachModel *model = self.dataArray[indexPath.row];
    if ([_delegate respondsToSelector:@selector(senderCoachModel:)]) {
        [_delegate senderCoachModel:model];
    }
}
- (void)receiveGetCoachMessage:(NSArray *)coachArray {
    self.dataArray = coachArray;
    [self.collectionView reloadData];
}



@end
