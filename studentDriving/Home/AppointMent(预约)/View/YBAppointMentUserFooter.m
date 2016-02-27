//
//  YBAppointMentUserFooter.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/18.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBAppointMentUserFooter.h"
#import "YBAppointMentUserCell.h"
#import "StudentModel.h"
#import "YBAppointMentCoachModel.h"
#import "ChatViewController.h"

#define rightFooter 80

@interface YBAppointMentUserFooter ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *userTitleLabel;

@end

@implementation YBAppointMentUserFooter

- (UIImageView *)iconImageView
{
    if (_iconImageView==nil) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"loginLogo"];
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 25;
    }
    return _iconImageView;
}
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:13]];
        _titleLabel.text = @"教练于淼";
    }
    return _titleLabel;
}
- (UILabel *)userTitleLabel {
    if (_userTitleLabel == nil) {
        _userTitleLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:13]];
        _userTitleLabel.text = @"相领时段学员";
    }
    return _userTitleLabel;
}
- (UICollectionView *)userCollectionView
{
    if (_userCollectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.minimumLineSpacing = 5;
        flowLayout.itemSize = CGSizeMake(50, 50);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        _userCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10,40, [UIScreen mainScreen].bounds.size.width-rightFooter,100) collectionViewLayout:flowLayout];
        _userCollectionView.backgroundColor = RGBColor(238, 238, 238);
        _userCollectionView.delegate = self;
        _userCollectionView.dataSource = self;
        [_userCollectionView registerClass:[YBAppointMentUserCell class] forCellWithReuseIdentifier:@"YBAppointMentUserCell"];
        
    }
    return _userCollectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
                
        self.backgroundColor = RGBColor(238, 238, 238);
        
        [self addSubview:self.userTitleLabel];
        [self addSubview:self.titleLabel];
        [self addSubview:self.iconImageView];
        [self addSubview:self.userCollectionView];

        [self.userTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(10);
            make.top.mas_equalTo(@20);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-10);
            make.top.mas_equalTo(@20);
        }];
        
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.titleLabel.mas_centerX);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
            make.width.equalTo(@50);
            make.height.equalTo(@50);
        }];
      
    }
    return self;
}

- (void)setAppointCoach:(YBAppointMentCoachModel *)appointCoach
{
    _appointCoach = appointCoach;
    
    self.titleLabel.text = [NSString stringWithFormat:@"教练:%@",self.appointCoach.name];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.appointCoach.headportrait] placeholderImage:[UIImage imageNamed:@"littleImage.png"]];

}

- (void)setStudentArray:(NSArray *)studentArray
{
    _studentArray = studentArray;
    
    NSInteger hangshu = _studentArray.count % 4;
    CGFloat footHeight = hangshu * 60 + 60;
    
    NSLog(@"setUserCount footHeight:%f",footHeight);
    
    _userCollectionView.frame = CGRectMake(self.userCollectionView.frame.origin.x, self.userCollectionView.frame.origin.y, self.userCollectionView.width, footHeight);
    
    [_userCollectionView reloadData];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSLog(@"numberOfItemsInSection self.userCount:%ld",(long)_studentArray.count);
    return _studentArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"YBAppointMentUserCell";
    YBAppointMentUserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (!cell) {
        DYNSLog(@"创建错误");
    }

    cell.backgroundColor = [UIColor clearColor];
    
    StudentModel *model = self.studentArray[indexPath.row];

    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.userid.headportrait.originalpic] placeholderImage:[UIImage imageNamed:@"littleImage.png"]];

    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__func__);
    StudentModel *model = self.studentArray[indexPath.row];
        
    ChatViewController *chatController = [[ChatViewController alloc] initWithChatter:model.userid.userId
                                                                    conversationType:eConversationTypeChat];
    chatController.title = model.userid.name;
    [self.parentViewController.navigationController pushViewController:chatController animated:YES];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
