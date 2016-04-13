//
//  JZRecordFooterView.h
//  studentDriving
//
//  Created by ytzhang on 16/4/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZRecordOrdrelist.h"
#import "YBIntegralMallModel.h"

@interface JZRecordFooterView : UIView

@property (nonatomic, strong) UILabel *titleLable;

@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UIImageView *codeImageView;

@property (nonatomic, strong) UILabel *stateLable;


- (instancetype)initWithFrame:(CGRect)frame recordOrderModel:(JZRecordOrdrelist *)recordOrderModel;

- (instancetype)initWithFrame:(CGRect)frame integralMallModel:(YBIntegralMallModel *)integralMallModel formMall:(BOOL)formMall codeStr:(NSString *)codeStr;

@end
