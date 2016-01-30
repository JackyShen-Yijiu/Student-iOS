//
//  DrivingDetailAddressCell.m
//  studentDriving
//
//  Created by 大威 on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DrivingDetailAddressCell.h"

@implementation DrivingDetailAddressCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"DrivingDetailAddressCell" owner:self options:nil];
        DrivingDetailAddressCell *cell = xibArray.firstObject;
        
        [cell setRestorationIdentifier:reuseIdentifier];
        self = cell;
        
        _priceLabel.textColor = MAINCOLOR;
        [self addSubview:self.cycleShowImagesView];
        [self addSubview:self.collectionImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat selfWidth = self.bounds.size.width;
    CGFloat cycleShowImagesViewHeight = selfWidth * 0.5;
    _cycleShowImagesView.frame = CGRectMake(0, 0, selfWidth, cycleShowImagesViewHeight);
    CGFloat collectionWidth = 50;
    _collectionImageView.frame = CGRectMake(selfWidth - collectionWidth - 8, cycleShowImagesViewHeight - collectionWidth / 2.f, collectionWidth, collectionWidth);
    [_collectionImageView.layer setMasksToBounds:YES];
    [_collectionImageView.layer setCornerRadius:collectionWidth / 2.f];
    
//    _cycleShowImagesView.backgroundColor = [UIColor orangeColor];
//    _collectionImageView.backgroundColor = [UIColor redColor];
}

- (void)refreshData:(DrivingDetailDMData *)dmData {
    
    // 轮播图数据
    [_cycleShowImagesView reloadDataWithArray:dmData.pictures];
    
    _drivingNameLabel.text = dmData.name;
    _addressLabel.text = [NSString stringWithFormat:@"地址：%@", dmData.address];
    _priceLabel.text = [NSString stringWithFormat:@"￥%zi - ￥%zi", dmData.minprice, dmData.maxprice];
}

- (DVVCycleShowImagesView *)cycleShowImagesView {
    if (!_cycleShowImagesView) {
        _cycleShowImagesView = [DVVCycleShowImagesView new];
        [_cycleShowImagesView setPageControlLocation:0 isCycle:YES];
    }
    return _cycleShowImagesView;
}
- (UIImageView *)collectionImageView {
    if (!_collectionImageView) {
        _collectionImageView = [UIImageView new];
    }
    return _collectionImageView;
}

+ (CGFloat)defaultHeight {
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    return screenWidth * 0.5 + 95.f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
