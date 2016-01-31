//
//  CoachListCell.m
//  studentDriving
//
//  Created by 大威 on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "CoachListCell.h"

@implementation CoachListCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"CoachListCell" owner:self options:nil];
        CoachListCell *cell = xibArray.firstObject;
        
        [cell setRestorationIdentifier:reuseIdentifier];
        self = cell;
        
        _priceLabel.textColor = MAINCOLOR;
        
        [self.contentView addSubview:self.starBar];
        __weak typeof(self) ws = self;
        [_starBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@75);
            make.height.mas_equalTo(@15);
            make.right.mas_equalTo(-8);
            make.centerY.mas_equalTo(ws.nameLabel.mas_centerY);
        }];
    }
    return self;
}

- (void)refreshData:(CoachListDMData *)dmData {
    
    [_starBar displayRating:dmData.starlevel];
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dmData.headportrait.originalpic]]];
    NSLog(@"%@", dmData.headportrait.originalpic);
    _nameLabel.text = dmData.name;
    _priceLabel.text = [NSString stringWithFormat:@"￥%ld元起", dmData.minprice];
    _seniorityLabel.text = [NSString stringWithFormat:@"教龄：%@年", dmData.seniority];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in dmData.serverclasslist) {
        
        CoachListDMServerClassList *dmList = [CoachListDMServerClassList yy_modelWithDictionary:dict];
        [array addObject:dmList.cartype];
    }
    
    _classTypeLabel.text = [array componentsJoinedByString:@" "];
    if (!array.count) {
        _classTypeLabel.text = @"暂无";
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (RatingBar *)starBar {
    if (_starBar == nil) {
        _starBar = [[RatingBar alloc] init];
        [_starBar setImageDeselected:@"starUnSelected.png" halfSelected:nil fullSelected:@"starSelected.png" andDelegate:nil];
        _starBar.isIndicator = YES;
        [_starBar displayRating:3];
    }
    return _starBar;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
