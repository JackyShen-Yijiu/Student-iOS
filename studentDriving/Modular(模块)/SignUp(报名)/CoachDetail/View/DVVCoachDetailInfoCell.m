//
//  DVVCoachDetailInfoCell.m
//  studentDriving
//
//  Created by 大威 on 16/2/20.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVCoachDetailInfoCell.h"

#define IMAGE_WIDTH (([UIScreen mainScreen].bounds.size.width - 56 - 16 - 10 * 2) / 3.f)
#define IMAGE_HEIGHT IMAGE_WIDTH * 0.7

@implementation DVVCoachDetailInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"DVVCoachDetailInfoCell" owner:self options:nil];
        DVVCoachDetailInfoCell *cell = xibArray.firstObject;
        
        self = cell;
        [self setRestorationIdentifier:reuseIdentifier];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (YBIphone6Plus) {
            self.firstImageView.width = 18 * YB_1_5_Ratio;
            self.firstImageView.height = 18 * YB_1_5_Ratio;
            self.firstLabel.height = 14 * YBRatio;
            self.firstLabel.font = [UIFont systemFontOfSize:14 * YBRatio];
            
            self.secondImageView.width = 18 * YB_1_5_Ratio;
            self.secondImageView.height = 18 * YB_1_5_Ratio;
            self.secondLabel.height = 14 * YBRatio;
            self.secondLabel.font = [UIFont systemFontOfSize:14 * YBRatio];
            
            self.thirdImageView.width = 18 * YB_1_5_Ratio;
            self.thirdImageView.height = 18 * YB_1_5_Ratio;
            self.thirdLabel.height = 14 * YBRatio;
            self.thirdLabel.font = [UIFont systemFontOfSize:14 * YBRatio];
            
        }

        
//        [self.contentView addSubview:self.scrollImagesView];
//        [self.contentView addSubview:self.lineImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    CGFloat minX = CGRectGetMinX(_firstLabel.frame);
//    _scrollImagesView.frame = CGRectMake(56, CGRectGetMinY(_thirdImageView.frame), size.width - 56 - 16, IMAGE_HEIGHT);
//    _lineImageView.frame = CGRectMake(minX, size.height - 0.5, size.width - minX - 16, 0.5);
}

+ (CGFloat)dynamicHeight:(DVVCoachDetailDMData *)dmData type:(NSUInteger)type {
    if (1 == type && dmData.trainfield.pictures && dmData.trainfield.pictures.count) {
        // 训练场地照片
//        return 96 + IMAGE_HEIGHT + 16;
        return 136;
    }else {
        return 136;
    }
}


- (void)refreshAppointMentData:(DVVCoachDetailDMData *)dmData
{
    
    if (0 == self.tag) {
        if (dmData.seniority && dmData.seniority.length) {
            _firstLabel.text = [NSString stringWithFormat:@"教龄 %@年", dmData.seniority];
        }else {
            _firstLabel.text = @"暂无教龄";
        }
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in dmData.subject) {
            
            DVVCoachDetailDMSubject *dmSubject = [DVVCoachDetailDMSubject yy_modelWithDictionary:dict];
            [array addObject:dmSubject.name];
        }
        if (array.count) {
            _secondLabel.text = [array componentsJoinedByString:@"/"];
        }else {
            _secondLabel.text = @"未填写科目信息";
        }
        
        NSMutableArray *carArray = [NSMutableArray array];
        for (NSDictionary *dict in dmData.serverclasslist) {
            
            CoachListDMServerClassList *dmList = [CoachListDMServerClassList yy_modelWithDictionary:dict];
            [carArray addObject:dmList.cartype];
        }
        
        if (carArray.count) {
            _thirdLabel.text = [array componentsJoinedByString:@" "];
        }else {
            _thirdLabel.text = @"未填写授课车型";
        }
        
        _firstImageView.image = [UIImage imageNamed:@"ic_age"];
        _secondImageView.image = [UIImage imageNamed:@"ic_teaching_subjects"];
        _thirdImageView.image = [UIImage imageNamed:@"ic_car_type"];
        
    }else {
        if (dmData.driveschoolinfo.name && dmData.driveschoolinfo.name.length) {
            _firstLabel.text = dmData.driveschoolinfo.name;
        }else {
            _firstLabel.text = @"未填写所属驾校";
        }
        if (dmData.trainfield.fieldname && dmData.trainfield.fieldname.length) {
            _secondLabel.text = dmData.trainfield.fieldname;
        }else {
            _secondLabel.text = @"未填写所属训练场";
        }
        if (dmData.trainfield.pictures && dmData.trainfield.pictures.count) {
            _thirdLabel.text = @"";
            [_scrollImagesView refreshData:dmData.trainfield.pictures];
        }else {
            _thirdLabel.text = @"暂无训练场照片";
        }
        
        _firstImageView.image = [UIImage imageNamed:@"coach_teach_car"];
        _secondImageView.image = [UIImage imageNamed:@"coach_school"];
        _thirdImageView.image = [UIImage imageNamed:@"coach_site"];
    }
}

- (void)refreshData:(DVVCoachDetailDMData *)dmData {
    
    if (0 == self.tag) {
        if (dmData.seniority && dmData.seniority.length) {
            _firstLabel.text = [NSString stringWithFormat:@"教龄 %@年", dmData.seniority];
        }else {
            _firstLabel.text = @"暂无教龄";
        }
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in dmData.subject) {
            
            DVVCoachDetailDMSubject *dmSubject = [DVVCoachDetailDMSubject yy_modelWithDictionary:dict];
            [array addObject:dmSubject.name];
        }
        if (array.count) {
            _secondLabel.text = [array componentsJoinedByString:@"/"];
        }else {
            _secondLabel.text = @"未填写科目信息";
        }
        
        NSMutableArray *carArray = [NSMutableArray array];
        for (NSDictionary *dict in dmData.serverclasslist) {
            
            CoachListDMServerClassList *dmList = [CoachListDMServerClassList yy_modelWithDictionary:dict];
            [carArray addObject:dmList.cartype];
        }
        
        if (carArray.count) {
            _thirdLabel.text = [array componentsJoinedByString:@" "];
        }else {
            _thirdLabel.text = @"未填写授课车型";
        }
        
        _firstImageView.image = [UIImage imageNamed:@"ic_age"];
        _secondImageView.image = [UIImage imageNamed:@"ic_teaching_subjects"];
        _thirdImageView.image = [UIImage imageNamed:@"ic_car_type"];
        
    }else {
        if (dmData.carmodel.name && dmData.carmodel.name.length) {
            _firstLabel.text = [NSString stringWithFormat:@"教学车型: %@",dmData.carmodel.name];
        }else {
            _firstLabel.text = [NSString stringWithFormat:@"教学车型: 暂无车型信息"];
        }
        if (dmData.driveschoolinfo.name && dmData.driveschoolinfo.name.length) {
            _secondLabel.text = [NSString stringWithFormat:@"所属驾校: %@",dmData.driveschoolinfo.name];;
        }else {
            _secondLabel.text = [NSString stringWithFormat:@"所属驾校: 暂无信息"];
        }
        if (dmData.trainfield.fieldname && dmData.trainfield.fieldname.length) {
            _thirdLabel.text = [NSString stringWithFormat:@"训练场地: %@",dmData.trainfield.fieldname];
            //            [_scrollImagesView refreshData:dmData.trainfield.pictures];
        }else {
            _thirdLabel.text = [NSString stringWithFormat:@"训练场地: 暂无信息"];
        }
        
        _firstImageView.image = [UIImage imageNamed:@"coach_teach_car"];
        _secondImageView.image = [UIImage imageNamed:@"coach_school"];
        _thirdImageView.image = [UIImage imageNamed:@"coach_site"];
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

- (UIImageView *)lineImageView {
    if (!_lineImageView) {
        _lineImageView = [UIImageView new];
        _lineImageView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    }
    return _lineImageView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
