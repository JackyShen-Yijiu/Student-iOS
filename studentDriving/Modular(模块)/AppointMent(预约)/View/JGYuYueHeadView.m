//
//  JGYuYueHeadView.m
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "JGYuYueHeadView.h"

#import "JGAppointMentCell.h"
//#import "AppointmentCoachTimeInfoModel.h"
#import "YBCoachListViewController.h"
#import "BLInformationManager.h"
#import "YBAppointMentCoachModel.h"
#import "YBAppointData.h"
#import "YBAppointCoursedata.h"
#import "YYModel.h"

@interface JGYuYueHeadView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (nonatomic,strong) UIView *footView;

@property (nonatomic,assign) NSArray *studentArray;

// 预约教练
@property (nonatomic,strong) YBAppointMentCoachModel *appointCoach;

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

- (UICollectionView *)collectionView {
    
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.itemSize = CGSizeMake(kSystemWide/3-0.5, 70);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = RGBColor(236, 236, 236);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[JGAppointMentCell class] forCellWithReuseIdentifier:@"JGAppointMentCell"];
        
    }
    
    return _collectionView;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = YBMainViewControlerBackgroundColor;
        
        [self addSubview:self.collectionView];
        
    }
    return self;
}

- (void)receiveCoachTimeData:(NSArray *)coachTimeData selectData:(NSDate *)selectDate coachModel:(YBAppointMentCoachModel *)coachModel{
    
    NSLog(@"coachTimeData:%@",coachTimeData);
    
    self.appointCoach = coachModel;
    
    self.selectDate = selectDate;

    [self.upDateArray removeAllObjects];
    [self.dataArray removeAllObjects];
    
    if (coachTimeData&&coachTimeData.count!=0) {
        
        for (NSDictionary *dict in coachTimeData) {
            
            YBAppointData *model = [YBAppointData yy_modelWithDictionary:dict];

            [self.dataArray addObject:model];

        }
        
    }
   
    [self.collectionView reloadData];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (self.dataArray && self.dataArray.count>0) {
        return self.dataArray.count;
    }
    return 0;
    
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
    
    cell.appointCoach = self.appointCoach;
    cell.isModifyCoach = NO;
    
    if (self.dataArray && self.dataArray.count>0) {
        YBAppointData *model = self.dataArray[indexPath.row];
        model.indexPath = indexPath.row;
        cell.appointInfoModel = model;
    }
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YBAppointData *model = self.dataArray[indexPath.row];

    JGAppointMentCell *cell = (JGAppointMentCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (model.is_selected == NO) {
        
        // 判断是否是更换同时段教练
        if (cell.isModifyCoach) {
            
            if ([self.delegate respondsToSelector:@selector(JGYuYueHeadViewWithModifyCoach:isModifyCoach:timeid:)]) {
                [self.delegate JGYuYueHeadViewWithModifyCoach:self isModifyCoach:YES timeid:@(model.timeid)];
            }

            return;
        }
        
        if (self.upDateArray.count>=4) {
            
            ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"您最多可预约4个课时"];
            [alertView show];
            
            [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
            
            return;
            
        }
        
        if (self.upDateArray.count == 0) {
            
            cell.contentView.backgroundColor = YBNavigationBarBgColor;
            cell.startTimeLabel.textColor = [UIColor whiteColor];//MAINCOLOR;
            cell.finalTimeLabel.textColor = [UIColor whiteColor];//MAINCOLOR;
            cell.remainingPersonLabel.textColor = [UIColor whiteColor];//MAINCOLOR;
            model.is_selected = YES;
            model.indexPath = indexPath.row;
            [self.upDateArray addObject:model];
            [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
            [BLInformationManager sharedInstance].appointmentData = self.upDateArray;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kCellChange" object:nil];

            return;
        }
        
        for (YBAppointData *UpDatemodel in self.upDateArray) {
            
            if ((model.timeid + 1 == UpDatemodel.timeid) || (model.timeid-1 == UpDatemodel.timeid)) {
                
                cell.contentView.backgroundColor = YBNavigationBarBgColor;
                cell.startTimeLabel.textColor = [UIColor whiteColor];//MAINCOLOR;
                cell.finalTimeLabel.textColor = [UIColor whiteColor];//MAINCOLOR;
                cell.remainingPersonLabel.textColor = [UIColor whiteColor];//MAINCOLOR;
                model.is_selected = YES;
                model.indexPath = indexPath.row;
                [self.upDateArray addObject:model];
                [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
                [BLInformationManager sharedInstance].appointmentData = self.upDateArray;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kCellChange" object:nil];
                
                return;

            }
            
            
        }
        
        
        ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"请选择连续的时间"];
        [alertView show];
            
        [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
        
    }else if (model.is_selected == YES) {
        
        if (self.upDateArray.count >= 3) {
            
            NSArray *array = self.upDateArray;//[BLInformationManager sharedInstance].appointmentData;
            
            NSArray *resultArray = [array sortedArrayUsingComparator:^NSComparisonResult(YBAppointData *  _Nonnull obj1, YBAppointData *  _Nonnull obj2) {
                return obj1.timeid < obj2.timeid;
            }];
            YBAppointData *fistModel = resultArray.firstObject;
            YBAppointData *lastModel = resultArray.lastObject;
            
            if (fistModel.timeid == model.timeid || lastModel.timeid == model.timeid) {
                
                model.is_selected = NO;
                [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
                [self.upDateArray removeObject:model];
                [BLInformationManager sharedInstance].appointmentData = self.upDateArray;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kCellChange" object:nil];
                [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];

                return;
                
            }else {
                
                ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"此操作会造成预约时间不连续!"];
                [alertView show];
                
            }
            
            return;
            
        }
        
        model.is_selected = NO;
        [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
        [self.upDateArray removeObject:model];
        [BLInformationManager sharedInstance].appointmentData = self.upDateArray;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kCellChange" object:nil];
        [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];

    }
    
}


@end
