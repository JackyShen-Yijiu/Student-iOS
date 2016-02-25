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
#import "YBCoachListViewController.h"
#import "BLInformationManager.h"
#import "YBAppointMentCoachModel.h"

@interface JGYuYueHeadView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (nonatomic,strong) UIView *footView;

@property (nonatomic,strong) YBAppointMentUserFooter *userFooter;

@property (nonatomic,assign) NSArray *studentArray;

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
- (YBAppointMentUserFooter *)userFooter
{
    if (_userFooter==nil) {
        _userFooter = [[YBAppointMentUserFooter alloc] init];
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
        
        flowLayout.footerReferenceSize = CGSizeMake(kSystemWide-rightFooter, 100);
        
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
    
    view.studentArray = self.studentArray;
    view.appointCoach = self.appointCoach;
    
    view.parentViewController = self.parentViewController;
    
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

//- (void)receiveCoachTimeselectData:(NSDate *)selectDate
//{
//    
//   
//    
//    self.selectDate = selectDate;
//    
//    [self.upDateArray removeAllObjects];
//    
//    [self.dataArray removeAllObjects];
//    [self.dataArray addObjectsFromArray:coachTimeData];
//    
//    [self.collectionView reloadData];
//    
//    self.userFooter.userCount = self.userCount;
//    
//}

- (void)receiveCoachTimeDataWithStudentData:(NSMutableArray *)stuDataArray coachModel:(YBAppointMentCoachModel *)coachModel
{
    self.studentArray = stuDataArray;
    self.appointCoach = coachModel;
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    // 行数
    NSInteger hangshu = stuDataArray.count / 4;
    NSLog(@"hangshu::%ld",(long)hangshu);
    CGFloat footHeight = hangshu * 60 + 45 + 60;
    NSLog(@"receiveCoachTimeData footHeight:%f",footHeight);
    flowLayout.footerReferenceSize = CGSizeMake(kSystemWide-rightFooter, footHeight);
    self.collectionView.collectionViewLayout = flowLayout;
    
    NSLog(@"receiveCoachTimeData self.userCount:%ld",(long)stuDataArray.count);
    
    self.userFooter.appointCoach = self.appointCoach;
    self.userFooter.studentArray = self.studentArray;

    [self.userFooter.userCollectionView reloadData];
    
}

- (void)receiveCoachTimeData:(NSArray *)coachTimeData selectData:(NSDate *)selectDate coachModel:(YBAppointMentCoachModel *)coachModel{
    
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
    
    cell.selectDate = self.selectDate;
    
    if (self.dataArray && self.dataArray.count>0) {
        AppointmentCoachTimeInfoModel *model = self.dataArray[indexPath.row];
        cell.appointInfoModel = model;
    }
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AppointmentCoachTimeInfoModel *model = self.dataArray[indexPath.row];
    
    JGAppointMentCell *cell = (JGAppointMentCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    DYNSLog(@"clickModel = %d",model.is_selected);
    
    DYNSLog(@"self.upDateArray.count:%lu",self.upDateArray.count);
    
    DYNSLog(@"cell.isModify:%d",cell.isModifyCoach);
    
    if (model.is_selected == NO) {
        
        // 判断是否是更换同时段教练
        if (cell.isModifyCoach) {
            NSLog(@"跳转到更多教练列表");
            
            NSString *dateString = [NSString getYearLocalDateFormateUTCDate:cell.appointInfoModel.coursedate];
            
            if ([self.delegate respondsToSelector:@selector(JGYuYueHeadViewWithModifyCoach:dateString:isModifyCoach:timeid:)]) {
                [self.delegate JGYuYueHeadViewWithModifyCoach:self dateString:dateString isModifyCoach:YES timeid:cell.appointInfoModel.coursetime.timeid];
            }
            
//            CoachViewController *coach = [[CoachViewController alloc] init];
//            coach.markNum = 2;
//            coach.isModifyCoach = YES;
//            coach.timeid = cell.coachTimeInfo.coursetime.timeid;
//            coach.coursedate = dateString;
//            [self.parentViewController.navigationController pushViewController:coach animated:YES];
            
//            YBCoachListViewController *coachList = [[YBCoachListViewController alloc] init];
//            coachList.isModifyCoach = YES;
//            coachList.timeid = cell.appointInfoModel.coursetime.timeid;
//            coachList.coursedate = dateString;
//            [self.parentViewController.navigationController pushViewController:coachList animated:YES];
            
            return;
        }
        
        DYNSLog(@"Selected");
        if (self.upDateArray.count>=4) {
            
            ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"您最多可预约4个课时"];
            [alertView show];
            
            return;
            
        }
        
        if (self.upDateArray.count == 0) {
            
            JGAppointMentCell *cell = (JGAppointMentCell *)[collectionView cellForItemAtIndexPath:indexPath];
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
                JGAppointMentCell *cell = (JGAppointMentCell *)[collectionView cellForItemAtIndexPath:indexPath];
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
            
            NSArray *array = self.upDateArray;//[BLInformationManager sharedInstance].appointmentData;
            
            NSArray *resultArray = [array sortedArrayUsingComparator:^NSComparisonResult(AppointmentCoachTimeInfoModel *  _Nonnull obj1, AppointmentCoachTimeInfoModel *  _Nonnull obj2) {
                //obj1.coursetime.numMark < obj2.coursetime.numMark
                return obj1.coursetime.numMark > obj2.coursetime.numMark ;
            }];
            AppointmentCoachTimeInfoModel *fistModel = resultArray.firstObject;
            AppointmentCoachTimeInfoModel *lastModel = resultArray.lastObject;
            if ([fistModel.infoId isEqualToString:model.infoId]||[lastModel.infoId isEqualToString:model.infoId]) {
                DYNSLog(@"unSelected");
                JGAppointMentCell *cell = (JGAppointMentCell *)[collectionView cellForItemAtIndexPath:indexPath];
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
        JGAppointMentCell *cell = (JGAppointMentCell *)[collectionView cellForItemAtIndexPath:indexPath];
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
