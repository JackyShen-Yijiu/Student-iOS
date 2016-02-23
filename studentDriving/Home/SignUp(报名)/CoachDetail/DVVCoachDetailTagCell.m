//
//  DVVCoachDetailTagCell.m
//  studentDriving
//
//  Created by 大威 on 16/2/20.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVCoachDetailTagCell.h"
#import "NSString+Helper.h"
#import "DVVCoachDetailDMTagslist.h"

@implementation DVVCoachDetailTagCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"DVVCoachDetailTagCell" owner:self options:nil];
        DVVCoachDetailTagCell *cell = xibArray.firstObject;
        self = cell;
        [self setRestorationIdentifier:reuseIdentifier];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        _tagLabel.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)refreshData:(DVVCoachDetailDMData *)dmData {
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in dmData.tagslist) {
        DVVCoachDetailDMTagslist *dmTag = [DVVCoachDetailDMTagslist yy_modelWithDictionary:dict];
        if (dmTag.tagname && dmTag.tagname.length) {
            [array addObject:dmTag.tagname];
        }
    }
    if (array.count) {
        _tagLabel.text = [array componentsJoinedByString:@"、"];
    }else {
        _tagLabel.text = @"暂无个性标签";
    }
}

+ (CGFloat)dynamicHeight:(DVVCoachDetailDMData *)dmData {
    
    NSString *string = @"暂无个性标签";
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in dmData.tagslist) {
        DVVCoachDetailDMTagslist *dmTag = [DVVCoachDetailDMTagslist yy_modelWithDictionary:dict];
        if (dmTag.tagname && dmTag.tagname.length) {
            [array addObject:dmTag.tagname];
        }
    }
    if (array.count) {
        string = [array componentsJoinedByString:@"、"];
    }

    CGFloat height = [NSString autoHeightWithString:string width:[UIScreen mainScreen].bounds.size.width - 56 - 16 font:[UIFont systemFontOfSize:14]];
    if (height < 24) {
        return 56;
    }else {
        return 16 +height + 16;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
