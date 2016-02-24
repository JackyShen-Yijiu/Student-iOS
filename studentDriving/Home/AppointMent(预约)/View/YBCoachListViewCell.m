//
//  YBCoachListViewCell.m
//  BlackCat
//
//  Created by 董博 on 15/9/9.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "YBCoachListViewCell.h"
#import "ToolHeader.h"
#import <Masonry.h>
#import "CoachModel.h"
#import "RatingBar.h"

@interface YBCoachListViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;

@property (strong, nonatomic) IBOutlet UILabel *coachNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *kemuLabel;

@property (strong, nonatomic) IBOutlet UILabel *pinglunCountLabel;

@property (strong, nonatomic) IBOutlet RatingBar *starBar;

@property (strong, nonatomic) IBOutlet UILabel *tongguolvLabel;

@property (strong, nonatomic) IBOutlet UILabel *jialingLabel;
@end

@implementation YBCoachListViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"YBCoachListViewCell" owner:self options:nil];
        YBCoachListViewCell *cell = xibArray.firstObject;
        [cell setRestorationIdentifier:reuseIdentifier];
        self = cell;
    }
    return self;
}

- (void)receivedCellModelWith:(CoachModel *)coachModel {
    
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = self.headImageView.width/2;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:coachModel.headportrait.originalpic] placeholderImage:[UIImage imageNamed:@"littleImage.png"]];

    self.coachNameLabel.text = coachModel.name;

    NSMutableString *kemuStr = [NSMutableString string];
    for (NSDictionary *subject in coachModel.subject) {
        NSLog(@"subject:%@",subject);
        NSString *name = [NSString stringWithFormat:@"%@ ",subject[@"name"]];
        [kemuStr appendString:name];
    }
    self.kemuLabel.text = kemuStr;
    
    self.pinglunCountLabel.text = [NSString stringWithFormat:@"%@条评论",coachModel.commentcount];
    
    [_starBar setImageDeselected:@"starUnSelected.png" halfSelected:nil fullSelected:@"starSelected.png" andDelegate:nil];
    CGFloat starLevel = 0;
    if (coachModel.starlevel) {
        starLevel = [coachModel.starlevel floatValue];
    }
    NSLog(@"starLevel:%f",starLevel);
    [self.starBar displayRating:starLevel];
    
    if (coachModel.passrate) {
        self.tongguolvLabel.text = [NSString stringWithFormat:@"通过率:%@%@",coachModel.passrate,@"%"];
    }else {
        self.tongguolvLabel.text = [NSString stringWithFormat:@"通过率:暂无"];
    }

    if (coachModel.Seniority) {
        self.jialingLabel.text = [NSString stringWithFormat:@"%@年教龄",coachModel.Seniority] ;
    }else{
        self.jialingLabel.text = [NSString stringWithFormat:@"暂无"];
    }
    
}


@end
