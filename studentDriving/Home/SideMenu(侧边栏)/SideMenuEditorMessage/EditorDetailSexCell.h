//
//  EditorDetailSexCell.h
//  studentDriving
//
//  Created by zyt on 16/2/23.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YBSexBlock)(BOOL sexWay);

@interface EditorDetailSexCell : UITableViewCell
@property (nonatomic, assign) BOOL complaintWay;
@property (nonatomic, assign) YBSexBlock sexWayBlock;
@end
