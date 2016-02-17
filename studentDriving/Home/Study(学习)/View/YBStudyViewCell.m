
//
//  YBStudyViewCell.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/17.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBStudyViewCell.h"

@implementation YBStudyViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"YBStudyViewCell" owner:self options:nil];
        YBStudyViewCell *cell = xibArray.firstObject;
        
        [cell setRestorationIdentifier:reuseIdentifier];
        self = cell;
        
    }
    return self;
}

- (void)setDictModel:(NSDictionary *)dictModel
{
    _dictModel = dictModel;
    
    self.iconImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_dictModel[@"icon"]]];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@",_dictModel[@"title"]];
    
    self.descriptionLabel.text = [NSString stringWithFormat:@"%@",_dictModel[@"description"]];
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
