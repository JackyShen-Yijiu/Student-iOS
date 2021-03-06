//
//  AppointmentDrivingCell.m
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "AppointmentDrivingCell.h"
#import "ToolHeader.h"
#import "AppointmentCollectionViewCell.h"
#import "AppointmentCoachTimeInfoModel.h"
#import "BLInformationManager.h"
#import "CoachViewController.h"

@interface AppointmentDrivingCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UIScrollView *menuScrollview;
@property (strong, nonatomic) UIView *backGroundView;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) NSIndexPath *firstPath;
@end
@implementation AppointmentDrivingCell

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
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.minimumLineSpacing = 1;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 269-44) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = RGBColor(221, 221, 221);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[AppointmentCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
    }
    return _collectionView;
}


- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kSystemWide , 269)];
    }
    return _backGroundView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    [self.contentView addSubview:self.backGroundView];
    [self.backGroundView addSubview:self.collectionView];
}
- (void)receiveCoachTimeData:(NSArray *)coachTimeData {
    [self.dataArray removeAllObjects];
    [self.upDateArray removeAllObjects];
    [self.dataArray addObjectsFromArray:coachTimeData];
    [self.collectionView reloadData];
    DYNSLog(@"count = %ld",self.dataArray.count);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    self.indexPath = nil;
    return self.dataArray.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"collectionCell";
    AppointmentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
   
    if (!cell) {
        DYNSLog(@"创建错误");
    }
    AppointmentCoachTimeInfoModel *model = self.dataArray[indexPath.row];
    [cell receiveCoachTimeInfoModel:model];
   
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize cellSize = CGSizeMake(kSystemWide/3-1, 75-1);
    return cellSize;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AppointmentCoachTimeInfoModel *model = self.dataArray[indexPath.row];
    
    AppointmentCollectionViewCell *cell = (AppointmentCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];

    DYNSLog(@"clickModel = %d",model.is_selected);
    
    DYNSLog(@"self.upDateArray.count:%lu",self.upDateArray.count);
    
    DYNSLog(@"cell.isModify:%d",cell.isModifyCoach);
    
    if (model.is_selected == NO) {
        
        // 判断是否是更换同时段教练
        if (cell.isModifyCoach) {
            NSLog(@"跳转到更多教练列表");
            
            NSString *dateString = [NSString getYearLocalDateFormateUTCDate:cell.coachTimeInfo.coursedate];
            
            NSLog(@"cell.coachTimeInfo.coursetime.timeid:%@",cell.coachTimeInfo.coursetime.timeid);
            NSLog(@"cell.coachTimeInfo.coursedate:%@ dateString:%@",cell.coachTimeInfo.coursedate,dateString);
            
            CoachViewController *coach = [[CoachViewController alloc] init];
            coach.markNum = 2;
            coach.isModifyCoach = YES;
            coach.timeid = cell.coachTimeInfo.coursetime.timeid;
            coach.coursedate = dateString;
            [self.parentViewController.navigationController pushViewController:coach animated:YES];
            
            return;
        }
        
        DYNSLog(@"Selected");
        if (self.upDateArray.count>=4) {
            
            ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"您最多可预约4个课时"];
            [alertView show];
            
            return;
            
        }
        
        if (self.upDateArray.count == 0) {
            
            AppointmentCollectionViewCell *cell = (AppointmentCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
            cell.startTimeLabel.textColor = MAINCOLOR;
            cell.finalTimeLabel.textColor = MAINCOLOR;
            cell.remainingPersonLabel.textColor = MAINCOLOR;
            model.is_selected = YES;
            [self.upDateArray addObject:model];
            [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
            [BLInformationManager sharedInstance].appointmentData = self.upDateArray;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kCellChange" object:nil];

            return;
        }
        
        for (AppointmentCoachTimeInfoModel *UpDatemodel in self.upDateArray) {
            
            DYNSLog(@"upDateModel = %ld",UpDatemodel.indexPath);
            if ((model.indexPath + 1 == UpDatemodel.indexPath )|| (model.indexPath-1 == UpDatemodel.indexPath)) {
                //            [SVProgressHUD showInfoWithStatus:@"请选择相邻的时间段"];
                AppointmentCollectionViewCell *cell = (AppointmentCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
                cell.startTimeLabel.textColor = MAINCOLOR;
                cell.finalTimeLabel.textColor = MAINCOLOR;
                cell.remainingPersonLabel.textColor = MAINCOLOR;
                model.is_selected = YES;
                [self.upDateArray addObject:model];
                [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
                [BLInformationManager sharedInstance].appointmentData = self.upDateArray;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kCellChange" object:nil];

                return;
            }
        }
        
        
        ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"请选择连续的时间"];
        [alertView show];

    }else if (model.is_selected == YES) {
        
        if (self.upDateArray.count == 4) {
            
            NSArray *array = [BLInformationManager sharedInstance].appointmentData;
            
            NSArray *resultArray = [array sortedArrayUsingComparator:^NSComparisonResult(AppointmentCoachTimeInfoModel *  _Nonnull obj1, AppointmentCoachTimeInfoModel *  _Nonnull obj2) {
                //obj1.coursetime.numMark < obj2.coursetime.numMark
                return obj1.coursetime.numMark > obj2.coursetime.numMark ;
            }];
            AppointmentCoachTimeInfoModel *fistModel = resultArray.firstObject;
            AppointmentCoachTimeInfoModel *lastModel = resultArray.lastObject;
            if ([fistModel.infoId isEqualToString:model.infoId]||[lastModel.infoId isEqualToString:model.infoId]) {
                DYNSLog(@"unSelected");
                AppointmentCollectionViewCell *cell = (AppointmentCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
                cell.startTimeLabel.textColor = [UIColor blackColor];
                cell.finalTimeLabel.textColor = [UIColor blackColor];
                cell.remainingPersonLabel.textColor = TEXTGRAYCOLOR;
                model.is_selected = NO;
                [self.upDateArray removeObject:model];
                [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
                [BLInformationManager sharedInstance].appointmentData = self.upDateArray;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kCellChange" object:nil];
                return;
            }else {
                ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"次操作会造成预约时间不连续!"];
                [alertView show];
            }
            return;
        }
        DYNSLog(@"unSelected");
        AppointmentCollectionViewCell *cell = (AppointmentCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.startTimeLabel.textColor = [UIColor blackColor];
        cell.finalTimeLabel.textColor = [UIColor blackColor];
        cell.remainingPersonLabel.textColor = TEXTGRAYCOLOR;
        model.is_selected = NO;
        [self.upDateArray removeObject:model];
        [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
        [BLInformationManager sharedInstance].appointmentData = self.upDateArray;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kCellChange" object:nil];

    }
   
}


@end
