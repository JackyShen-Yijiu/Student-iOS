//
//  JZMyComplaintListCell.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/15.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZMyComplaintListCell.h"
#import "JZMyComplaintData.h"
@interface JZMyComplaintListCell ()
@property (nonatomic, strong) JZMyComplaintData *dataModel;
@end

@implementation JZMyComplaintListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[NSBundle mainBundle]loadNibNamed:@"JZMyComplaintListCell" owner:self options:nil].lastObject;
    }
    
    return self;
}


-(void)awakeFromNib {
    
    self.complaintDetail.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 32;

}


@end
