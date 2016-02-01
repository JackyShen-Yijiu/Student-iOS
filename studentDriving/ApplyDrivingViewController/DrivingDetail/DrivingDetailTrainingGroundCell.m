//
//  DrivingDetailTrainingGroundCell.m
//  studentDriving
//
//  Created by 大威 on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DrivingDetailTrainingGroundCell.h"

#define IMAGE_WIDTH (([UIScreen mainScreen].bounds.size.width - 8 * 2 - 10 * 2) / 3.f)
#define IMAGE_HEIGHT IMAGE_WIDTH * 0.7

@implementation DrivingDetailTrainingGroundCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"DrivingDetailTrainingGroundCell" owner:self options:nil];
        DrivingDetailTrainingGroundCell *cell = xibArray.firstObject;
        
        [cell setRestorationIdentifier:reuseIdentifier];
        self = cell;
        [self addSubview:self.scrollImagesView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _scrollImagesView.frame = CGRectMake(8, 8 + 21 + 8, self.bounds.size.width - 8 * 2, IMAGE_HEIGHT);
}

- (void)refreshData:(DrivingDetailDMData *)dmData {
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *string in dmData.pictures) {
        
        [array addObject:string];
        
//        // 测试时使用
//        for (int i = 0; i < 5; i++) {
//            [array addObject:string];
//        }
    }
    if (array && array.count) {
        [_scrollImagesView refreshData:array];
    }else {
        [_scrollImagesView refreshData:@[ @"", @"", @"" ]];
    }
}

- (DVVHorizontalScrollImagesView *)scrollImagesView {
    if (!_scrollImagesView) {
        _scrollImagesView = [DVVHorizontalScrollImagesView new];
        _scrollImagesView.defaultImage = [UIImage imageNamed:@"cycleshowimages_icon"];
        _scrollImagesView.imageHeight = IMAGE_HEIGHT;
        _scrollImagesView.imageWidth = IMAGE_WIDTH;
    }
    return _scrollImagesView;
}

+ (CGFloat)defaultHeight {
    
    return 8 + 21 + 8 + IMAGE_HEIGHT + 8;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
