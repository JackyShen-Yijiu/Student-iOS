//
//  LKNoDataView.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/18.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "LKNoDataView.h"
@implementation LKNoDataView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {

        self.backgroundColor = [UIColor lightGrayColor];
    }
    
    return self;
    
}
-(instancetype)initWithFrame:(CGRect)frame andNoDataLabelText:(NSString *)noDataLabelText andNoDataImgName:(NSString *)noDataImgName {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor lightGrayColor];

        self.noDataLabel.text = noDataLabelText;
        self.noDataImageView.image = [UIImage imageNamed:noDataImgName];

    }
    
    return self;
}


-(void)layoutSubviews {
    
    [super layoutSubviews];
    [self.noDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_centerY).offset(-60-28);
        make.centerX.equalTo(self.mas_centerX);
        
    }];
    
    NSInteger noDataLabelH = 14;
    if (YBIphone6Plus) {
        
        noDataLabelH = 14 * YBRatio;
    }
    
    [self.noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.noDataImageView.mas_bottom).offset(14);
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@(noDataLabelH));
        make.width.equalTo(@(kSystemWide));
        
    }];

}
-(UILabel *)noDataLabel {
    if (!_noDataLabel) {
        
        self.noDataLabel = [[UILabel alloc]init];
        self.noDataLabel.textAlignment = NSTextAlignmentCenter;

        if (YBIphone6Plus) {
            self.noDataLabel.font = [UIFont systemFontOfSize:14*YBRatio];
        }else {
            self.noDataLabel.font = [UIFont systemFontOfSize:14];

        }
        self.noDataLabel.textColor = [UIColor grayColor];
        [self addSubview:self.noDataLabel];

    }
    
    return _noDataLabel;
}

-(UIImageView *)noDataImageView {
    if (!_noDataImageView) {
        
        self.noDataImageView = [[UIImageView alloc]init];
        
        [self addSubview:self.noDataImageView];
        
    }
    return _noDataImageView;
}

@end
