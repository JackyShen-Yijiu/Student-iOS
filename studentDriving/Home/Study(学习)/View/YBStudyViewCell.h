//
//  YBStudyViewCell.h
//  studentDriving
//
//  Created by JiangangYang on 16/2/17.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBStudyViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (nonatomic,strong) NSDictionary *dictModel;

@end
