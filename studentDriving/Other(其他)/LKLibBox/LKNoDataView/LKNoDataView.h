//
//  LKNoDataView.h
//  Headmaster
//
//  Created by 雷凯 on 16/5/18.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
/// 没有数据时候显示的大View

@interface LKNoDataView : UIView
/// 没有数据时显示的图片
@property (nonatomic, strong) UIImageView *noDataImageView;
/// 没有数据时显示的Label
@property (nonatomic, strong) UILabel *noDataLabel;


-(instancetype)initWithFrame:(CGRect)frame andNoDataLabelText:(NSString *)noDataLabelText andNoDataImgName:(NSString *)noDataImgName;
@end
