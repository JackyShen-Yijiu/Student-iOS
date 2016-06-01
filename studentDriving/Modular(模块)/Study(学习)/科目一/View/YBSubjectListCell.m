//
//  YBSubjectListCell.m
//  studentDriving
//
//  Created by JiangangYang on 16/4/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBSubjectListCell.h"

@implementation YBSubjectListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"YBSubjectListCell" owner:self options:nil];
        self = xibArray.firstObject;
        [self setRestorationIdentifier:reuseIdentifier];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}


@end
