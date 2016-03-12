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
        [self.dataArray addObjectsFromArray:coachTimeData];
    }
   
    [self.collectionView reloadData];
        
    NSLog(@"self.dataArray.count:%lu",(unsigned long)self.dataArray.count);
    
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
    cell.backgroundColor = RGBColor(250, 250, 250);
    
    cell.appointCoach = self.appointCoach;
    
    if (self.dataArray && self.dataArray.count>0) {
        NSDictionary *modelDict = self.dataArray[indexPath.row];
        YBAppointData *model = [YBAppointData yy_modelWithDictionary:modelDict];
        cell.appointInfoModel = model;
    }
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *modelDict = self.dataArray[indexPath.row];
    
    YBAppointData *model = [YBAppointData yy_modelWithDictionary:modelDict];

    JGAppointMentCell *cell = (JGAppointMentCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    DYNSLog(@"clickModel = %d",model.is_selected);
    
    DYNSLog(@"self.upDateArray.count:%lu",self.upDateArray.count);
    
    DYNSLog(@"cell.isModify:%d",cell.isModifyCoach);
    
    if (model.is_selected == NO) {
        
        // 判断是否是更换同时段教练
        if (cell.isModifyCoach) {
            
            NSString *dateString = [NSString getYearLocalDateFormateUTCDate:cell.appointInfoModel.coursedata.coursedate];
            
            if ([self.delegate respondsToSelector:@selector(JGYuYueHeadViewWithModifyCoach:dateString:isModifyCoach:timeid:)]) {
                [self.delegate JGYuYueHeadViewWithModifyCoach:self dateString:dateString isModifyCoach:YES timeid:@(cell.appointInfoModel.coursedata.coursetime.timeid)];
            }

            return;
        }
        
        DYNSLog(@"Selected");
        if (self.upDateArray.count>=4) {
            
            ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"您最多可预约4个课时"];
            [alertView show];
            
            [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
            
            return;
            
        }
        
        if (self.upDateArray.count == 0) {
            
            JGAppointMentCell *cell = (JGAppointMentCell *)[collectionView cellForItemAtIndexPath:indexPath];
            cell.contentView.backgroundColor = YBNavigationBarBgColor;
            cell.startTimeLabel.textColor = [UIColor whiteColor];//MAINCOLOR;
            cell.finalTimeLabel.textColor = [UIColor whiteColor];//MAINCOLOR;
            cell.remainingPersonLabel.textColor = [UIColor whiteColor];//MAINCOLOR;
            model.is_selected = YES;
            [self.upDateArray addObject:model];
            [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
            [BLInformationManager sharedInstance].appointmentData = self.upDateArray;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kCellChange" object:nil];
            
            return;
        }
        
        for (YBAppointData *UpDatemodel in self.upDateArray) {
            
            if ((model.indexPath + 1 == UpDatemodel.indexPath )|| (model.indexPath-1 == UpDatemodel.indexPath)) {
                //            [SVProgressHUD showInfoWithStatus:@"请选择相邻的时间段"];
                JGAppointMentCell *cell = (JGAppointMentCell *)[collectionView cellForItemAtIndexPath:indexPath];
                cell.contentView.backgroundColor = YBNavigationBarBgColor;
                cell.startTimeLabel.textColor = [UIColor whiteColor];//MAINCOLOR;
                cell.finalTimeLabel.textColor = [UIColor whiteColor];//MAINCOLOR;
                cell.remainingPersonLabel.textColor = [UIColor whiteColor];//MAINCOLOR;
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
        [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];

    }else if (model.is_selected == YES) {
        
        if (self.upDateArray.count == 4) {
            
            NSArray *array = self.upDateArray;//[BLInformationManager sharedInstance].appointmentData;
            
            NSArray *resultArray = [array sortedArrayUsingComparator:^NSComparisonResult(YBAppointData *  _Nonnull obj1, YBAppointData *  _Nonnull obj2) {
                //obj1.coursetime.numMark < obj2.coursetime.numMark
                return obj1.timeid > obj2.timeid ;
            }];
            YBAppointData *fistModel = resultArray.firstObject;
            YBAppointData *lastModel = resultArray.lastObject;
            
            if ([[NSString stringWithFormat:@"%ld",fistModel.timeid] isEqualToString:[NSString stringWithFormat:@"%ld",model.timeid]]||[[NSString stringWithFormat:@"%ld",lastModel.timeid] isEqualToString:[NSString stringWithFormat:@"%ld",model.timeid]]) {
                
                DYNSLog(@"unSelected");
                JGAppointMentCell *cell = (JGAppointMentCell *)[collectionView cellForItemAtIndexPath:indexPath];
                cell.contentView.backgroundColor = RGBColor(250, 250, 250);
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
                ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"此操作会造成预约时间不连续!"];
                [alertView show];
            }
            return;
        }
        DYNSLog(@"unSelected");
        JGAppointMentCell *cell = (JGAppointMentCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.contentView.backgroundColor = RGBColor(250, 250, 250);
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
