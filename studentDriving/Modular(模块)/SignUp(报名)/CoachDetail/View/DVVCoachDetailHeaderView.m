//
//  DVVCoachDetailHeaderView.m
//  studentDriving
//
//  Created by 大威 on 16/2/20.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVCoachDetailHeaderView.h"
#import "UIImageView+DVVWebImage.h"
#import "UIImage+DVVEffects.h"
#import "OLImageView.h"
#import "OLImage.h"

@interface DVVCoachDetailHeaderView ()

@property (nonatomic, strong) UIView *centerView;

@property (nonatomic,strong) OLImageView *Aimv;

@end

@implementation DVVCoachDetailHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bgImageView];
        [self addSubview:self.maskView];
        
        [self addSubview:self.centerView];
        
        [self addSubview:self.alphaView];
        
        [self addSubview:self.collectionImageView];
        
        CGFloat selfWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat bgImagesViewHeight = selfWidth * 0.7;
        _bgImageView.frame = CGRectMake(0, 0, selfWidth, bgImagesViewHeight);
        _maskView.frame = _bgImageView.frame;
        _alphaView.frame = _bgImageView.frame;
        CGFloat collectionWidth = 48;
        CGFloat collectionHeight = 20;
        _collectionImageView.frame = CGRectMake(selfWidth - collectionWidth - 16, bgImagesViewHeight - collectionHeight - 16, collectionWidth, collectionHeight);
        
//        _collectionImageView.layer.masksToBounds = YES;
//        _collectionImageView.layer.cornerRadius = _collectionImageView.frame.size.width/2;

        _centerView.center = CGPointMake(CGRectGetMidX(_bgImageView.frame), CGRectGetMidY(_bgImageView.frame) + 18);

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

+ (CGFloat)defaultHeight {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    return screenWidth * 0.7;
}

- (void)refreshAppointMentData:(YBAppointMentDetailsDataData *)dmData
{
    NSString *iconName = @"coach_man_default_icon";
    _iconImageView.image = [UIImage imageNamed:iconName];
    [_iconImageView dvv_downloadImage:dmData.coachid.headportrait.originalpic];
    
    [_bgImageView dvv_downloadImage:dmData.coachid.headportrait.originalpic completed:^(UIImage *image, NSError *error) {
        if (!error && image) {
            
            _bgImageView.image = [image applyBlurWithRadius:10 tintColor:[UIColor clearColor] saturationDeltaFactor:1 maskImage:nil];
        }
    }];
    
    // 教龄
    if (dmData.coachid.name && dmData.coachid.name.length) {
        _teacherAge.text = [NSString stringWithFormat:@"教龄: %@",dmData.coachid.name];
    }
    // 授课科目
    [_starView displayRating:dmData.coachid.starlevel];
}

- (void)refreshData:(DVVCoachDetailDMData *)dmData {
    
    NSString *iconName = @"coach_man_default_icon";
    if (dmData.gender && dmData.gender.length) {
        if ([dmData.gender isEqualToString:@"女"]) {
            iconName = @"coach_woman_default_icon";
        }
    }
    _iconImageView.image = [UIImage imageNamed:iconName];
    [_iconImageView dvv_downloadImage:dmData.headportrait.originalpic];
    
    [_bgImageView dvv_downloadImage:dmData.trainfield.pictures.firstObject completed:^(UIImage *image, NSError *error) {
        if (!error && image) {
            
            _bgImageView.image = [image applyBlurWithRadius:10 tintColor:[UIColor clearColor] saturationDeltaFactor:1 maskImage:nil];
        }
    }];
    
    if (dmData.name && dmData.name.length) {
        _teacherAge.text = [NSString stringWithFormat:@"教龄: %@",dmData.seniority];
    }
    [_starView displayRating:dmData.starlevel];
}

- (UIView *)alphaView {
    if (!_alphaView) {
        _alphaView = [UIView new];
    }
    return _alphaView;
}

- (UIImageView *)maskView {
    if (!_maskView) {
        _maskView= [UIImageView new];
        _maskView.image = [UIImage imageNamed:@"coach_header_bg"];
    }
    return _maskView;
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.image = [[UIImage imageNamed:@"bg"] applyBlurWithRadius:10 tintColor:[UIColor clearColor] saturationDeltaFactor:1 maskImage:nil];
    }
    return _bgImageView;
}

- (UIImageView *)collectionImageView {
    if (!_collectionImageView) {
        _collectionImageView = [UIImageView new];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collectionClickAction:)];
        [_collectionImageView addGestureRecognizer:tapGesture];
        _collectionImageView.userInteractionEnabled = YES;
        _collectionImageView.image = [UIImage imageNamed:@"coach_collect_off"];
    }
    return _collectionImageView;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        [_iconImageView.layer setMasksToBounds:YES];
        [_iconImageView.layer setCornerRadius:30];
        _iconImageView.image = [UIImage imageNamed:@"coach_man_default_icon"];
    }
    return _iconImageView;
}
- (THLabel *)teacherAge {
    if (!_teacherAge) {
        _teacherAge = [THLabel new];
        _teacherAge.font = [UIFont systemFontOfSize:14];
        _teacherAge.textColor = [UIColor whiteColor];
//        _teacherAge.textAlignment = NSTextAlignmentCenter;
        _teacherAge.text = @"暂无教龄";
    }
    return _teacherAge;
}
- (THLabel *)teacherContentLabel {
    if (!_teacherContentLabel) {
        _teacherContentLabel = [THLabel new];
        _teacherContentLabel.font = [UIFont systemFontOfSize:14];
        _teacherContentLabel.textColor = [UIColor whiteColor];
//        _teacherContentLabel.textAlignment = NSTextAlignmentCenter;
        _teacherContentLabel.text = @"暂无授课科目";
    }
    return _teacherContentLabel;
}

- (RatingBar *)starView {
    if (!_starView) {
        _starView = [RatingBar new];
        [_starView setImageDeselected:@"YBAppointMentDetailsstar.png" halfSelected:nil fullSelected:@"YBAppointMentDetailsstar_fill.png" andDelegate:nil];
    }
    return _starView;
}

- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [UIView new];
        _centerView.frame = CGRectMake(0, 0, kSystemWide, 110);
        _centerView.backgroundColor = [UIColor clearColor];
        [_centerView addSubview:self.iconImageView];
        [_centerView addSubview:self.teacherAge];
        [_centerView addSubview:self.starView];
        [_centerView addSubview:self.teacherContentLabel];
        
        // 教练头像
        _iconImageView.frame = CGRectMake(44, 0, 60, 60);
        _iconImageView.centerY = _centerView.centerY;
        // 星级控件
        _starView.frame = CGRectMake(10, _iconImageView.frame.origin.y, 94, 14);
        _starView.centerX = _centerView.centerX;
        // 教龄
        _teacherAge.frame = CGRectMake(_starView.frame.origin.x, _starView.frame.origin.y + 14  + 10, 94, 14);
        
        // 授课科目
         _teacherContentLabel.frame = CGRectMake(_starView.frame.origin.x, _teacherAge.frame.origin.y + 14  + 10, 94, 14);
        
    }
    return _centerView;
}

- (void)setCoachID:(NSString *)coachID {
    _coachID = coachID;
    [self checkCollection];
}

#pragma mark - 收藏相关
#pragma mark 检测是否收藏
- (void)checkCollection {
    
    NSString *urlString = [NSString stringWithFormat:BASEURL,@"userinfo/favoritecoach"];
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"检测是否收藏data:%@",data);
        
        NSDictionary *param = data;
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        if ([type isEqualToString:@"1"]) {
            
            if ([[data objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
                
                NSArray *array = [data objectForKey:@"data"];
                for (int i = 0; i < array.count; i++) {
                    
                    NSString *schoolId = [array[i] objectForKey:@"coachid"];
                    if ([schoolId isEqualToString:_coachID]) {
                        _collectionImageView.image = [UIImage imageNamed:@"coach_collect_on"];
                        _collectionImageView.tag = 1;
                        return ;
                    }
                }
            }
        }
    }];
}

- (void)collectionClickAction:(UITapGestureRecognizer *)tapGesture {
    
    if (![AcountManager isLogin]) {
        [self obj_showTotasViewWithMes:@"您还没有登录哟"];
        return ;
    }
    
    if (_collectionImageView.tag) {
        [self deleteLoveSchool];
    }else {
        [self addLoveSchool];
    }
}
#pragma mark 添加喜欢的驾校
- (void)addLoveSchool {
    
//    _Aimv = [OLImageView new];
//    _Aimv.backgroundColor = [UIColor clearColor];
//    _Aimv.layer.masksToBounds = YES;
//    _Aimv.layer.cornerRadius = _collectionImageView.frame.size.width/2;
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"collect_on" ofType:@"gif"];
//    NSData *GIFDATA = [NSData dataWithContentsOfFile:filePath];
//    _Aimv.image = [OLImage imageWithData:GIFDATA];
//    [_Aimv setFrame:_collectionImageView.frame];
//    [self addSubview:_Aimv];
//    
//    [self performSelector:@selector(removeAimv) withObject:self afterDelay:0.5];

    NSString *interface = [NSString stringWithFormat:@"userinfo/favoritecoach/%@",_coachID];
    NSString *urlString = [NSString stringWithFormat:BASEURL,interface];
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodPut withCompletion:^(id data) {
        
        NSDictionary *param = data;
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        if ([type isEqualToString:@"1"]) {
            _collectionImageView.image = [UIImage imageNamed:@"coach_collect_off"];
//            [self obj_showTotasViewWithMes:@"收藏成功"];
            _collectionImageView.tag = 1;
        }else {
//            [self obj_showTotasViewWithMes:@"收藏失败"];
        }
    }];
    
}


- (void)removeAimv
{
    [_Aimv removeFromSuperview];
}

#pragma mark 删除喜欢的驾校
- (void)deleteLoveSchool {
    
    
//    _Aimv = [OLImageView new];
//    _Aimv.backgroundColor = [UIColor clearColor];
//    _Aimv.layer.masksToBounds = YES;
//    _Aimv.layer.cornerRadius = _collectionImageView.frame.size.width/2;
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"collect_off" ofType:@"gif"];
//    NSData *GIFDATA = [NSData dataWithContentsOfFile:filePath];
//    _Aimv.image = [OLImage imageWithData:GIFDATA];
//    [_Aimv setFrame:_collectionImageView.frame];
//    [self addSubview:_Aimv];
//    
//    [self performSelector:@selector(removeAimv) withObject:self afterDelay:0.5];

    NSString *interface = [NSString stringWithFormat:@"userinfo/favoritecoach/%@",_coachID];
    NSString *urlString = [NSString stringWithFormat:BASEURL,interface];
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodDelete withCompletion:^(id data) {
        
        NSDictionary *param = data;
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        if ([type isEqualToString:@"1"]) {
            _collectionImageView.image = [UIImage imageNamed:@"coach_collect_on"];
//            [self obj_showTotasViewWithMes:@"已取消收藏"];
            _collectionImageView.tag = 0;
        }else {
//            [self obj_showTotasViewWithMes:@"取消收藏失败"];
        }
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
