//
//  BottomMenu.h
//  BlackCat
//
//  Created by bestseller on 15/9/15.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BottomMenuDelegate <NSObject>
- (void)horizontalMenuScrollPageIndex:(NSUInteger)index;
@end
@interface BottomMenu : UIView
@property (weak, nonatomic) id<BottomMenuDelegate>delegate;
- (id)initWithFrame:(CGRect)frame withItems:(NSArray *)items;
- (void)menuScrollWithIndex:(NSUInteger)index;
@end
