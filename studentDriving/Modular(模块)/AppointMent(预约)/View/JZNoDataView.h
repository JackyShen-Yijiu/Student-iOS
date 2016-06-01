//
//  JZNoDataView.h
//  studentDriving
//
//  Created by 雷凯 on 16/4/15.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZNoDataView : UIView
/// 没有数据时显示的图片
@property (nonatomic, weak) UIImageView *noDataImageView;
/// 没有数据时显示的Label
@property (nonatomic, weak) UILabel *noDataLabel;
@end
