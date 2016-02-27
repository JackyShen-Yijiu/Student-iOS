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

@interface DVVCoachDetailHeaderView ()

@property (nonatomic, strong) UIView *centerView;

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
        CGFloat collectionWidth = 63;
        CGFloat collectionHeight = 63;
        _collectionImageView.frame = CGRectMake(selfWidth - collectionWidth - 16, bgImagesViewHeight - collectionHeight/2.f, collectionWidth, collectionHeight);
        
        _centerView.center = CGPointMake(CGRectGetMidX(_bgImageView.frame), CGRectGetMidY(_bgImageView.frame) + 18);
        
//        _nameLabel.backgroundColor = [UIColor redColor];
//        self.backgroundColor = [UIColor redColor];
//        _collectionImageView.backgroundColor = [UIColor orangeColor];
//        _centerView.backgroundColor = [UIColor orangeColor];
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
        _nameLabel.text = dmData.name;
    }
    [_starView dvv_setStar:dmData.starlevel];
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
        _collectionImageView.image = [UIImage imageNamed:@"collection_no_icon"];
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
- (THLabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [THLabel new];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
//        _nameLabel.shadowBlur = 5;
//        _nameLabel.shadowColor = [UIColor colorWithWhite:0 alpha:0.7];
//        _nameLabel.shadowOffset = CGSizeMake(1, 1);
        _nameLabel.text = @"暂无教练名";
    }
    return _nameLabel;
}
- (DVVStarView *)starView {
    if (!_starView) {
        _starView = [DVVStarView new];
        [_starView dvv_setBackgroundImage:@"star_all_default_icon" foregroundImage:@"star_all_icon" width:94 height:14];
    }
    return _starView;
}

- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [UIView new];
        _centerView.frame = CGRectMake(0, 0, 94, 110);
        
        [_centerView addSubview:self.iconImageView];
        [_centerView addSubview:self.nameLabel];
        [_centerView addSubview:self.starView];
        _iconImageView.frame = CGRectMake((94-60) / 2, 0, 60, 60);
        _nameLabel.frame = CGRectMake(0, 60, 94, 10 + 16 + 10);
        _starView.frame = CGRectMake(0, CGRectGetMaxY(_nameLabel.frame), 94, 14);
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
        
        NSDictionary *param = data;
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        if ([type isEqualToString:@"1"]) {
            
            if ([[data objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
                
                NSArray *array = [data objectForKey:@"data"];
                for (int i = 0; i < array.count; i++) {
                    
                    NSString *schoolId = [array[i] objectForKey:@"coachid"];
                    if ([schoolId isEqualToString:_coachID]) {
                        _collectionImageView.image = [UIImage imageNamed:@"collection_yes_icon"];
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
    
    NSString *interface = [NSString stringWithFormat:@"userinfo/favoritecoach/%@",_coachID];
    NSString *urlString = [NSString stringWithFormat:BASEURL,interface];
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodPut withCompletion:^(id data) {
        
        NSDictionary *param = data;
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        if ([type isEqualToString:@"1"]) {
            _collectionImageView.image = [UIImage imageNamed:@"collection_yes_icon"];
//            [self obj_showTotasViewWithMes:@"收藏成功"];
            _collectionImageView.tag = 1;
        }else {
//            [self obj_showTotasViewWithMes:@"收藏失败"];
        }
    }];
    
}
#pragma mark 删除喜欢的驾校
- (void)deleteLoveSchool {
    
    NSString *interface = [NSString stringWithFormat:@"userinfo/favoritecoach/%@",_coachID];
    NSString *urlString = [NSString stringWithFormat:BASEURL,interface];
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodDelete withCompletion:^(id data) {
        
        NSDictionary *param = data;
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        if ([type isEqualToString:@"1"]) {
            _collectionImageView.image = [UIImage imageNamed:@"collection_no_icon"];
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
