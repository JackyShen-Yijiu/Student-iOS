//
//  JZMyComplaintCell.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZMyComplaintCell.h"
#import "JZMyComplaintData.h"

@interface JZMyComplaintCell()

//// 投诉的名称
@property (strong, nonatomic)  UILabel *complaintName;
/// 投诉详情
@property (strong, nonatomic)  UILabel *complaintDetail;
/// 投诉的时间
@property (strong, nonatomic)  UILabel *complaintTime;
/// 投诉的第一张图片
@property (strong, nonatomic)  UIImageView *complaintFirstImg;
/// 投诉的第二张图片
@property (strong, nonatomic)  UIImageView *complaintSecondImg;

@property (nonatomic,strong) UIView *complaintImageView;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation JZMyComplaintCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initUI {
    
    self.complaintName = [[UILabel alloc]init];
    self.complaintName.textAlignment = NSTextAlignmentLeft;
    self.complaintName.textColor = RGBColor(110, 110, 110);
    [self.complaintName setFont:[UIFont systemFontOfSize:14]];
    
    self.complaintTime = [[UILabel alloc]init];
    self.complaintTime.textColor = RGBColor(183, 183, 183);
    self.complaintName.textAlignment = NSTextAlignmentRight;
    [self.complaintTime setFont:[UIFont systemFontOfSize:12]];
    self.complaintTime.numberOfLines = 0;
    
    self.complaintDetail = [[UILabel alloc]init];
    self.complaintDetail.textColor = JZ_FONTCOLOR_LIGHT;
    self.complaintDetail.numberOfLines = 0;
    [self.complaintDetail setFont:[UIFont systemFontOfSize:14]];
    
    self.complaintImageView = [[UIView alloc] init];
    [self.contentView addSubview:self.complaintImageView];
    
    self.complaintFirstImg = [[UIImageView alloc]init];
    [self.complaintImageView addSubview:self.complaintFirstImg];

    self.complaintSecondImg = [[UIImageView alloc]init];
    [self.complaintImageView addSubview:self.complaintSecondImg];

    [self.contentView addSubview:self.complaintName];
    [self.contentView addSubview:self.complaintTime];
    [self.contentView addSubview:self.complaintDetail];
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = JZ_FONTCOLOR_LIGHT;
    [self.contentView addSubview:self.lineView];

    
}


-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.complaintName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);//
        make.left.equalTo(self.contentView.mas_left).offset(16);
    }];
    [self.complaintTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.complaintName.mas_top);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.height.equalTo(@12);
    }];
    [self.complaintDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.complaintName.mas_bottom).offset(10);//
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
    }];
   
    [self.complaintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.complaintName.mas_left);
        make.top.mas_equalTo(self.complaintDetail.mas_bottom).offset(10);//
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(75);
    }];
    [self.complaintFirstImg mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.mas_equalTo(75);
    }];
    [self.complaintSecondImg mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(@0);
        make.left.equalTo(self.complaintFirstImg.mas_right).offset(10);
        make.bottom.equalTo(@0);
        make.width.mas_equalTo(75);
     }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@0.5);
        
    }];
    
    
    
}

- (void)setData:(JZMyComplaintData *)data
{
    _data = data;
    
    self.complaintDetail.text = _data.feedbackmessage;
    
    if (_data.feedbacktype == 1) {
        
        self.complaintName.text = [NSString stringWithFormat:@"投诉教练：%@",_data.becomplainedname];
        
    }else if (_data.feedbacktype == 2){
        
        self.complaintName.text = [NSString stringWithFormat:@"投诉驾校：%@",[AcountManager manager].applyschool.name];
        
        
    }
    
    self.complaintTime.text = [NSString getYearLocalDateFormateUTCDate:_data.createtime];
    NSString *str = @"""";
    
    if (_data.piclist && _data.piclist.count!=0 && ![_data.piclist containsObject:str]) {
        
        self.complaintImageView.hidden = NO;
        
        if ((_data.piclist[0] && [_data.piclist[0] length]!=0)) {
            self.complaintFirstImg.hidden = NO;
            self.complaintSecondImg.hidden = YES;
            [self.complaintFirstImg sd_setImageWithURL:[NSURL URLWithString:_data.piclist[0]]];
        }
        
        if (_data.piclist.count>1 && _data.piclist[1] && [_data.piclist[1] length]!=0) {
            self.complaintFirstImg.hidden = NO;
            self.complaintSecondImg.hidden = NO;
            [self.complaintSecondImg sd_setImageWithURL:[NSURL URLWithString:_data.piclist[1]]];
        }
        
    }else{
        
        self.complaintImageView.hidden = YES;
        
    }

    
}

+ (CGFloat)cellHeightDmData:(JZMyComplaintData *)dmData
{
    
    JZMyComplaintCell *cell = [[JZMyComplaintCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"JZMyComplaintCellID"];
    
    cell.data = dmData;
    
    [cell layoutIfNeeded];
    NSString *str = @"""";
    if (dmData.piclist && dmData.piclist.count!=0 && ![dmData.piclist containsObject:str]) {
        return cell.complaintName.height + cell.complaintDetail.height + cell.complaintImageView.height + 40 + 1.5;
    }
    return cell.complaintName.height + cell.complaintDetail.height + 30 + 1.5;
    
}

@end
