//
//  DVVShareView.m
//  DVVTestUMSocial
//
//  Created by 大威 on 16/1/18.
//  Copyright © 2016年 DaWei. All rights reserved.
//

#import "DVVShareView.h"
#import <UMSocial.h>
#import <UMSocialDataService.h>
#import <WXApi.h>
#import <WeiboSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "DVVShareCell.h"

#define kShareCell_Identifier @"kShareCellIdentifier"

#define kShareCell_Width 55.f
#define kShareCell_Height 55.f
#define kNumInLine 5
#define kCollectionView_Width (kShareCell_Width * kNumInLine)

@interface DVVShareView()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UMSocialUIDelegate>

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) NSMutableDictionary *shareDict;

@property (nonatomic, copy) DVVShareViewSuccessBlock successBlock;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *titleBackgroundImageView;
@property (nonatomic, strong) UIImageView *walletImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *titleDetailLabel;

@property (nonatomic, strong) UILabel *markLabel;

@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation DVVShareView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.alpha = 0;
        [self addSubview:self.backgroundImageView];
        [self addSubview:self.contentView];
        [_contentView addSubview:self.titleBackgroundImageView];
        [_titleBackgroundImageView addSubview:self.walletImageView];
        [_titleBackgroundImageView addSubview:self.titleLabel];
        [_titleBackgroundImageView addSubview:self.titleDetailLabel];
        [_contentView addSubview:self.markLabel];
        [_contentView addSubview:self.collectionView];
        [self addSubview:self.closeButton];
    }
    return self;
}

- (void)initialProperty {
    
    _shareDict = nil;
    _shareDict = @{ UMShareToSina: @{ @"image": @"UMS_sina_icon", @"title": @"新浪微博" },
                    UMShareToWechatSession: @{ @"image": @"UMS_wechat_session_icon", @"title": @"微信好友" },
                    UMShareToWechatTimeline: @{ @"image": @"UMS_wechat_timeline_icon", @"title": @"朋友圈" },
                    UMShareToQQ: @{ @"image": @"UMS_qq_icon", @"title": @"QQ好友" },
                    UMShareToQzone: @{ @"image": @"UMS_qzone_icon", @"title": @"QQ空间" } }.mutableCopy;
}

- (void)show {
    [self refreshSharePlatform];
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)refreshSharePlatform {
    
    [self initialProperty];
    [self checkUnInstallPlatform];
    [self configLayout];
    [_collectionView reloadData];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _backgroundImageView.backgroundColor = [UIColor blackColor];
    _backgroundImageView.alpha = 0.5;
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    // 配置控件的位置
    [self configLayout];
}

#pragma mark 配置控件的位置
- (void)configLayout {
    
    _backgroundImageView.frame = self.bounds;
    
    NSInteger shareCellCount = _shareDict.count;
    NSInteger lineNum = shareCellCount / kNumInLine;
    if (shareCellCount > kNumInLine && shareCellCount % kNumInLine) {
        lineNum++;
    }
    if (0 == lineNum) {
        lineNum = 1;
    }
    _collectionView.bounds = CGRectMake(0, 0, kCollectionView_Width, lineNum * kShareCell_Height);
    if (shareCellCount < kNumInLine) {
        _collectionView.bounds = CGRectMake(0, 0, kShareCell_Width * shareCellCount, lineNum * kShareCell_Height);
    }
    
    CGFloat titleBackgroundImageViewHeight = kCollectionView_Width * 0.7;
    _titleBackgroundImageView.frame = CGRectMake(0, 0, kCollectionView_Width, titleBackgroundImageViewHeight);
    CGFloat markLabelHeight = 5;
    _markLabel.frame = CGRectMake(0, titleBackgroundImageViewHeight, kCollectionView_Width, markLabelHeight);
    _collectionView.frame = CGRectMake(kCollectionView_Width / 2.f - _collectionView.bounds.size.width / 2.f, titleBackgroundImageViewHeight + markLabelHeight, _collectionView.bounds.size.width, _collectionView.bounds.size.height);
    CGFloat walletImageViewWidth = 100.f;
    CGFloat walletImageViewHeight = walletImageViewWidth * 0.7;
    _walletImageView.bounds = CGRectMake(0, 0, walletImageViewWidth, walletImageViewHeight);
    CGFloat titleLabelHeight = 25.f;
    CGFloat titleDetailLabelHeight = 20.f;
    _titleLabel.bounds = CGRectMake(0, 0, kCollectionView_Width, titleLabelHeight);
    _titleDetailLabel.bounds = CGRectMake(0, 0, kCollectionView_Width, titleDetailLabelHeight);
    
    CGFloat centerX = kCollectionView_Width / 2.f;
    CGFloat centerY = titleBackgroundImageViewHeight / 2.f;
    _walletImageView.center = CGPointMake(centerX, centerY - walletImageViewHeight * 0.35);
    _titleLabel.center = CGPointMake(centerX, centerY + titleLabelHeight);
    _titleDetailLabel.center = CGPointMake(centerX, centerY + titleLabelHeight + titleDetailLabelHeight);
    
    CGFloat contentViewHeight = titleBackgroundImageViewHeight + markLabelHeight + _collectionView.bounds.size.height;
    _contentView.frame = CGRectMake(self.bounds.size.width / 2.f - kCollectionView_Width / 2.f, self.bounds.size.height / 2.f - contentViewHeight / 2.f, kCollectionView_Width, contentViewHeight);
    
    _closeButton.frame = CGRectMake(CGRectGetMaxX(_contentView.frame) - 15, CGRectGetMinY(_contentView.frame) - 15, 30, 30);
    [_closeButton.layer setCornerRadius:15];
}

#pragma mark 检测未安装平台
- (void)checkUnInstallPlatform {
    
    // 如果没有安装微信，则不显示微信分享信息
    if (![WXApi isWXAppInstalled]) {
        [_shareDict removeObjectsForKeys:@[ UMShareToWechatSession, UMShareToWechatTimeline ]];
    }
    // 如果没有安装QQ，则不显示QQ的分享信息
    if (![QQApiInterface isQQInstalled]) {
        [_shareDict removeObjectsForKeys:@[ UMShareToQQ, UMShareToQzone ]];
    }
//    // 如果没有安装微博，则不显示微博的分享信息
//    if (![WeiboSDK isWeiboAppInstalled]) {
//        [_shareDict removeObjectsForKeys:@[ UMShareToSina ]];
//    }
}

#pragma mark - collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _shareDict.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *shareCellId = kShareCell_Identifier;
    DVVShareCell *shareCell = [collectionView dequeueReusableCellWithReuseIdentifier:shareCellId forIndexPath:indexPath];
    
    NSDictionary *dict = [_shareDict objectForKey:_shareDict.allKeys[indexPath.row]];
    shareCell.label.text = dict[@"title"];
    shareCell.imageView.image = [UIImage imageNamed:[dict objectForKey:@"image"]];
//    NSLog(@"%@", [dict objectForKey:@"image"]);
//    shareCell.imageView.backgroundColor = [UIColor grayColor];
    
    return shareCell;
}

#pragma mark collectionView selected
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSDictionary *dict = [_shareDict objectForKey:_shareDict.allKeys[indexPath.row]];
//    NSLog(@"dict === %@", dict[@"title"]);
    
    NSString *sharePlatformString = _shareDict.allKeys[indexPath.row];
    if ([sharePlatformString isEqualToString:UMShareToSina]) {
        // 新浪微博
        [self shareWithPlatform:UMShareToSina];
        
    }else if ([sharePlatformString isEqualToString:UMShareToTencent]) {
        // 腾讯微博
        [UMSocialData defaultData].extConfig.tencentData.title = _shareTitle;
        [self shareWithPlatform:UMShareToTencent];
        
    }else if ([sharePlatformString isEqualToString:UMShareToWechatSession]) {
        // 微信好友
        [UMSocialData defaultData].extConfig.wechatSessionData.title = _shareTitle;
        [self shareWithPlatform:UMShareToWechatSession];
        
    }else if ([sharePlatformString isEqualToString:UMShareToWechatTimeline]) {
        // 微信朋友圈
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = _shareTitle;
        [self shareWithPlatform:UMShareToWechatTimeline];
        
    }else if ([sharePlatformString isEqualToString:UMShareToQQ]) {
        // QQ好友
        [UMSocialData defaultData].extConfig.qqData.title = _shareTitle;
        [self shareWithPlatform:UMShareToQQ];
        
    }else if ([sharePlatformString isEqualToString:UMShareToQzone]) {
        // QQ空间
        [UMSocialData defaultData].extConfig.qzoneData.title = _shareTitle;
        [self shareWithPlatform:UMShareToQzone];
    }
}

- (void)shareWithPlatform:(NSString *)platform {
    
//    NSLog(@"_presentedController:%p",_presentedController);
//    NSLog(@"platform:%@",platform);
//    NSLog(@"_shareContent:%@",_shareContent);
//    NSLog(@"_shareImage:%@",_shareImage);
//    NSLog(@"_shareLocation:%@",_shareLocation);
//    NSLog(@"_shareLocation:%@",_shareLocation);
//    NSLog(@"_shareUrlResource.url:%@",_shareUrlResource.url);
    
    // 如果没有安装微博，将会调到网页登录  在这时要把本视图移除，否则本视图会遮盖登录页
    if (![WeiboSDK isWeiboAppInstalled]) {
        [self hide];
    }
    
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[ platform ] content:_shareContent image:_shareImage location:_shareLocation urlResource:_shareUrlResource presentedController:_presentedController completion:^(UMSocialResponseEntity *response) {
        
        if (response.responseCode == UMSResponseCodeSuccess) {
//            NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
            // 处理分享成功
            if (_successBlock) {
                _successBlock([[response.data allKeys] objectAtIndex:0]);
            }
        }else if (response.responseCode == UMSREsponseCodeTokenInvalid){
            
            // 授权用户错误
            [self obj_showTotasViewWithMes:@"授权用户错误"];
            
        }else if (response.responseCode == UMSResponseCodeBaned) {
            
            // 用户被封禁
            [self obj_showTotasViewWithMes:@"用户被封禁"];
            
        }else if (response.responseCode == UMSResponseCodeFaild) {
            
            // 发送失败(由于内容不符合要求或者其他原因)
            [self obj_showTotasViewWithMes:@"发送失败(由于内容不符合要求或者其他原因)"];
            
        }else if (response.responseCode == UMSResponseCodeEmptyContent) {
            
            // 发送内容为空
            [self obj_showTotasViewWithMes:@"发送内容为空"];
            
        }else if (response.responseCode == UMSResponseCodeShareRepeated) {
            
            // 分享内容重复
            [self obj_showTotasViewWithMes:@"分享内容重复"];
            
        }else if (response.responseCode == UMSResponseCodeNetworkError) {
            
            // 网络错误,请检查网络链接
            [self obj_showTotasViewWithMes:@"网络错误,请检查网络链接"];
            
        }else if (response.responseCode == UMSResponseCodeGetProfileFailed) {
            
            // 获取账户失败
            [self obj_showTotasViewWithMes:@"获取账户失败"];
            
        }else if (response.responseCode == UMSResponseCodeCancel) {
            
            // 用户取消授权
            [self obj_showTotasViewWithMes:@"用户取消授权"];
        }
        
    }];
}

#pragma mark - collectionView flowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(kShareCell_Width, kShareCell_Height);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - lazyLoad
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        // 自动布局方式
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
        // 注册Cell
        [_collectionView registerClass:[DVVShareCell class] forCellWithReuseIdentifier:kShareCell_Identifier];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}
- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [UIImageView new];
    }
    return _backgroundImageView;
}
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        [_contentView.layer setMasksToBounds:YES];
        [_contentView.layer setCornerRadius:10];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.userInteractionEnabled = YES;
    }
    return _contentView;
}
- (UIImageView *)titleBackgroundImageView {
    if (!_titleBackgroundImageView) {
        _titleBackgroundImageView = [UIImageView new];
        _titleBackgroundImageView.image = [UIImage imageNamed:@"share_background"];
        _titleBackgroundImageView.backgroundColor = [UIColor redColor];
    }
    return _titleBackgroundImageView;
}
- (UIImageView *)walletImageView {
    if (!_walletImageView) {
        _walletImageView = [UIImageView new];
        _walletImageView.contentMode = UIViewContentModeCenter;
        _walletImageView.image = [UIImage imageNamed:@"share_wallet_icon"];
    }
    return _walletImageView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"分享好友得现金";
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.textAlignment = 1;
    }
    return _titleLabel;
}
- (UILabel *)titleDetailLabel {
    if (!_titleDetailLabel) {
        _titleDetailLabel = [UILabel new];
        _titleDetailLabel.text = @"成功分享月月入利";
        _titleDetailLabel.textColor = [UIColor colorWithHexString:@"#F2F2F2"];
        _titleDetailLabel.font = [UIFont systemFontOfSize:14];
        _titleDetailLabel.textAlignment = 1;
    }
    return _titleDetailLabel;
}
- (UILabel *)markLabel {
    if (!_markLabel) {
        _markLabel = [UILabel new];
        _markLabel.font = [UIFont systemFontOfSize:14];
        _markLabel.textColor = [UIColor blackColor];
        _markLabel.textAlignment = 1;
        _markLabel.text = @"";
    }
    return _markLabel;
}
- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton new];
        [_closeButton setBackgroundImage:[UIImage imageNamed:@"share_close_icon"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [_closeButton.layer setMasksToBounds:YES];
    }
    return _closeButton;
}

- (void)setShareSuccessBlock:(DVVShareViewSuccessBlock)handle {
    _successBlock = handle;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
