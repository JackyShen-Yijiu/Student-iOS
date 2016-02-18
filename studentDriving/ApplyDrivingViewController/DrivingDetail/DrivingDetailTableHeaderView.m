//
//  DrivingDetailTableHeaderView.m
//  studentDriving
//
//  Created by 大威 on 16/2/18.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DrivingDetailTableHeaderView.h"

@implementation DrivingDetailTableHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.cycleShowImagesView];
        [self addSubview:self.collectionImageView];
        self.backgroundColor = [UIColor redColor];
        _collectionImageView.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat selfWidth = self.bounds.size.width;
    CGFloat cycleShowImagesViewHeight = selfWidth * 0.7;
    _cycleShowImagesView.frame = CGRectMake(0, 0, selfWidth, cycleShowImagesViewHeight);
    CGFloat collectionWidth = 88;
    CGFloat collectionHeight = 106;
    _collectionImageView.frame = CGRectMake(selfWidth - collectionWidth, cycleShowImagesViewHeight - collectionHeight/2.f, collectionWidth, collectionHeight);
//    [_collectionImageView.layer setMasksToBounds:YES];
//    [_collectionImageView.layer setCornerRadius:collectionWidth/2.f];
    
    //    _cycleShowImagesView.backgroundColor = [UIColor orangeColor];
    //    _collectionImageView.backgroundColor = [UIColor redColor];
}

+ (CGFloat)defaultHeight {
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    return screenWidth * 0.7 + 106/2.f;
}

- (void)refreshData:(DrivingDetailDMData *)dmData {
    
    // 轮播图数据
    [_cycleShowImagesView reloadDataWithArray:dmData.pictures];
}

- (DVVCycleShowImagesView *)cycleShowImagesView {
    if (!_cycleShowImagesView) {
        _cycleShowImagesView = [DVVCycleShowImagesView new];
        [_cycleShowImagesView setPageControlLocation:0 isCycle:YES];
        _cycleShowImagesView.placeImage = [UIImage imageNamed:@"cycleshowimages_icon"];
    }
    return _cycleShowImagesView;
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

- (void)setSchoolID:(NSString *)schoolID {
    
    _schoolID = schoolID;
    [self checkCollection];
}
#pragma mark - 收藏相关
#pragma mark 检测是否收藏
- (void)checkCollection {
    
    NSString *urlString = [NSString stringWithFormat:BASEURL,@"userinfo/favoriteschool"];
    DYNSLog(@"urlstring = %@",urlString);
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSDictionary *param = data;
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        if ([type isEqualToString:@"1"]) {
            
            if ([[data objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
                
                NSArray *array = [data objectForKey:@"data"];
                for (int i = 0; i < array.count; i++) {
                    
                    NSString *schoolId = [array[i] objectForKey:@"schoolid"];
                    if ([schoolId isEqualToString:_schoolID]) {
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
    
    NSString *interface = [NSString stringWithFormat:@"userinfo/favoriteschool/%@",_schoolID];
    NSString *urlString = [NSString stringWithFormat:BASEURL,interface];
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodPut withCompletion:^(id data) {
        
        NSDictionary *param = data;
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        if ([type isEqualToString:@"1"]) {
            _collectionImageView.image = [UIImage imageNamed:@"collection_yes_icon"];
            [self obj_showTotasViewWithMes:@"收藏成功"];
            _collectionImageView.tag = 1;
        }else {
            [self obj_showTotasViewWithMes:@"收藏失败"];
        }
    }];
    
}
#pragma mark 删除喜欢的驾校
- (void)deleteLoveSchool {
    
    NSString *interface = [NSString stringWithFormat:@"userinfo/favoriteschool/%@",_schoolID];
    NSString *urlString = [NSString stringWithFormat:BASEURL,interface];
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodDelete withCompletion:^(id data) {
        
        NSDictionary *param = data;
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        if ([type isEqualToString:@"1"]) {
            _collectionImageView.image = [UIImage imageNamed:@"collection_no_icon"];
            [self obj_showTotasViewWithMes:@"已取消收藏"];
            _collectionImageView.tag = 0;
        }else {
            [self obj_showTotasViewWithMes:@"取消收藏失败"];
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
