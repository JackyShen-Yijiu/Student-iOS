//
//  YBAppointMentFootView.m
//  studentDriving
//
//  Created by JiangangYang on 16/3/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBAppointMentFootView.h"
#import "YBAppointMentUserCell.h"
#import "YBAppointMentCoachModel.h"
#import "StudentModel.h"
#import "ChatViewController.h"
#import "DVVCoachDetailController.h"

@interface YBAppointMentFootView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property ( nonatomic,strong) UILabel *appointLabel;

@end

@implementation YBAppointMentFootView

- (UIImageView *)iconImageView
{
    if (_iconImageView==nil) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"coach_man_default_icon"];
    }
    return _iconImageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = YBMainViewControlerBackgroundColor;
        
        // topview
        UIView *topview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 70)];
        topview.backgroundColor = [UIColor whiteColor];
        [self addSubview:topview];
        // 教练头像
        [topview addSubview:self.iconImageView];
        self.iconImageView.frame = CGRectMake(56/2, 22/2, 96/2, 96/2);
        self.iconImageView.layer.masksToBounds = YES;
        self.iconImageView.layer.cornerRadius = self.iconImageView.width/2;
        self.iconImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImageViewDidClick)];
        [self.iconImageView addGestureRecognizer:tap];
        
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
        footView.backgroundColor = [UIColor lightGrayColor];
        footView.alpha = 0.3;
        [topview addSubview:footView];
        
        // 同时段学员collectionview
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.minimumLineSpacing = 10;
        flowLayout.itemSize = CGSizeMake(44, 44);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        _userCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame)+56/2-10,13, topview.width-CGRectGetMaxX(self.iconImageView.frame)-56/2,topview.height-26) collectionViewLayout:flowLayout];
        _userCollectionView.backgroundColor = [UIColor whiteColor];
        _userCollectionView.delegate = self;
        _userCollectionView.dataSource = self;
        [_userCollectionView registerClass:[YBAppointMentUserCell class] forCellWithReuseIdentifier:@"YBAppointMentUserCell"];
        [topview addSubview:_userCollectionView];
        
        // midview
        UIView *midview = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topview.frame)+0.5, self.width, 72/2)];
        midview.backgroundColor = [UIColor whiteColor];
        [self addSubview:midview];
        // 更换教练
        self.changeCoachBtn = [[UIButton alloc] initWithFrame:CGRectMake(midview.width-82-2, 2, 82, 32)];
        self.changeCoachBtn.backgroundColor = [UIColor whiteColor];
        self.changeCoachBtn.layer.masksToBounds = YES;
        self.changeCoachBtn.layer.cornerRadius = 3;
        self.changeCoachBtn.layer.borderWidth = 1;
        self.changeCoachBtn.layer.borderColor = YBNavigationBarBgColor.CGColor;
        [self.changeCoachBtn setTitle:@"更换教练" forState:UIControlStateNormal];
        [self.changeCoachBtn setTitle:@"更换教练" forState:UIControlStateHighlighted];
        self.changeCoachBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.changeCoachBtn setTitleColor:YBNavigationBarBgColor forState:UIControlStateNormal];
        [self.changeCoachBtn setTitleColor:YBNavigationBarBgColor forState:UIControlStateHighlighted];
        [midview addSubview:self.changeCoachBtn];
        // 预约教练、同时段学员
        self.appointLabel = [[UILabel alloc] init];
        self.appointLabel.frame = CGRectMake(0, 0, midview.width-82-20, midview.height);
        self.appointLabel.text = @"       教练刘洋洋    同时段学员";
        self.appointLabel.font = [UIFont systemFontOfSize:12];
        self.appointLabel.textColor = [UIColor grayColor];
        [midview addSubview:self.appointLabel];

        // footview
        UIView *footview = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(midview.frame)+0.5, self.width, 44)];
        [self addSubview:footview];
        // @" 科目二 第20-33课时 已完成44课时"
        self.countLabel = [[UILabel alloc] init];
        self.countLabel.frame = CGRectMake(0, 0, footview.width/2, footview.height);
        self.countLabel.text = @"   科目二 第20-33课时";
        self.countLabel.font = [UIFont systemFontOfSize:14];
        self.countLabel.textColor = [UIColor blackColor];
        self.countLabel.textAlignment = NSTextAlignmentCenter;
        self.countLabel.backgroundColor = RGBColor(247, 247, 247);
        [footview addSubview:self.countLabel];

        // @"预约"
        self.commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(footview.width/2, 0, footview.width/2, 44)];
        self.commitBtn.backgroundColor = YBNavigationBarBgColor;
        [self.commitBtn setTitle:@"预约" forState:UIControlStateNormal];
        [self.commitBtn setTitle:@"预约" forState:UIControlStateHighlighted];
        self.commitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [footview addSubview:self.commitBtn];
        
        
    }
    return self;
}

- (void)setAppointCoach:(YBAppointMentCoachModel *)appointCoach
{
    _appointCoach = appointCoach;
    
    self.appointLabel.text = [NSString stringWithFormat:@"       教练:%@    同时段学员",_appointCoach.name];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_appointCoach.headportrait] placeholderImage:[UIImage imageNamed:@"littleImage.png"]];
    
}

- (void)iconImageViewDidClick
{
    // 跳转到详情界面
    DVVCoachDetailController *vc = [[DVVCoachDetailController alloc] init];
    vc.coachID = self.appointCoach.coachid;
    [self.parentViewController.navigationController pushViewController:vc animated:YES];
   
}

- (void)setStudentArray:(NSArray *)studentArray
{
    _studentArray = studentArray;
    
//    NSInteger hangshu = _studentArray.count % 4;
//    CGFloat footHeight = hangshu * 60 + 60;
    
//    NSLog(@"setUserCount footHeight:%f",footHeight);
    
//    _userCollectionView.frame = CGRectMake(self.userCollectionView.frame.origin.x, self.userCollectionView.frame.origin.y, self.userCollectionView.width, footHeight);
    
    [_userCollectionView reloadData];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSLog(@"numberOfItemsInSection self.userCount:%ld",(long)_studentArray.count);
    if (_studentArray.count==0) {
        return 4;
    }
    return _studentArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"YBAppointMentUserCell";
    YBAppointMentUserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (!cell) {
        DYNSLog(@"创建错误");
    }
   
    if (self.studentArray.count>0) {
        
        StudentModel *model = self.studentArray[indexPath.row];
        
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.userid.headportrait.originalpic] placeholderImage:[UIImage imageNamed:@"littleImage.png"]];
        
    }else{
        
        cell.iconImageView.image = [UIImage imageNamed:@"littleImage.png"];
        
    }
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__func__);
    if (self.studentArray.count>0) {

        StudentModel *model = self.studentArray[indexPath.row];
        
        ChatViewController *chatController = [[ChatViewController alloc] initWithChatter:model.userid.userId
                                                                        conversationType:eConversationTypeChat];
        chatController.title = model.userid.name;
        [self.parentViewController.navigationController pushViewController:chatController animated:YES];
        
    }
}

@end
