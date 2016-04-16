//
//  JZMyComplaintCell.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZMyComplaintCell.h"

@implementation JZMyComplaintCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)initUI {
    
    
    UILabel *complaintName = [[UILabel alloc]init];
    complaintName.textColor = RGBColor(110, 110, 110);
    [complaintName setFont:[UIFont systemFontOfSize:14]];
    self.complaintName = complaintName;
    
    
    UILabel *complaintTime = [[UILabel alloc]init];
    complaintTime.textColor = RGBColor(183, 183, 183);
    [complaintTime setFont:[UIFont systemFontOfSize:12]];
    complaintTime.numberOfLines = 0;
    self.complaintTime = complaintTime;
    
    
    UILabel *complaintDetail = [[UILabel alloc]init];
    complaintDetail.textColor = JZ_FONTCOLOR_LIGHT;
    [complaintDetail setFont:[UIFont systemFontOfSize:14]];
    self.complaintDetail = complaintDetail;
    
    UIImageView *complaintFirstImg = [[UIImageView alloc]init];
    self.complaintFirstImg = complaintFirstImg;
    
    UIImageView *complaintSecondImg = [[UIImageView alloc]init];
    self.complaintSecondImg = complaintSecondImg;
    
    
    [self.contentView addSubview:self.complaintName];
    [self.contentView addSubview:self.complaintTime];
    [self.contentView addSubview:self.complaintDetail];
    [self.contentView addSubview:self.complaintFirstImg];
    [self.contentView addSubview:self.complaintSecondImg];
    
    
}


-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.complaintName mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.contentView.mas_top).offset(16);
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.height.equalTo(@14);
        
        
    }];
    [self.complaintTime mas_makeConstraints:^(MASConstraintMaker *make) {
     
        make.top.equalTo(self.contentView.mas_top).offset(16);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.height.equalTo(@12);
        
        
    }];
    
    [self.complaintDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        
       
        make.top.equalTo(self.complaintName.mas_bottom).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
 
      
    }];
    
    [self.complaintFirstImg mas_makeConstraints:^(MASConstraintMaker *make)
    {
    
        make.top.equalTo(self.complaintDetail.mas_bottom).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(16);
//        make.width.equalTo(@73);
//        make.height.equalTo(@73);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-16);
        
    }];
    
    [self.complaintSecondImg mas_makeConstraints:^(MASConstraintMaker *make)
     {
         
         make.top.equalTo(self.complaintDetail.mas_bottom).offset(10);
         make.left.equalTo(self.complaintFirstImg.mas_right).offset(16);
//         make.width.equalTo(@73);
//         make.height.equalTo(@73);
         make.bottom.equalTo(self.contentView.mas_bottom).offset(-16);
         
     }];
    
    
    
}



@end
