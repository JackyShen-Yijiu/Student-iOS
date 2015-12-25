//
//  DVVSideMenuBlockView.h
//  studentDriving
//
//  Created by 大威 on 15/12/24.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DVVSideMenuBlockViewSelectedBlock)(UIButton *button);

@interface DVVSideMenuBlockView : UIView

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *iconNormalArray;

- (instancetype)initWithTitleArray:(NSArray *)array;

- (void)dvvSideMenuBlockViewItemSelected:(DVVSideMenuBlockViewSelectedBlock)handle;

@end
