//
//  ModificationView.h
//  BlackCat
//
//  Created by 董博 on 15/9/5.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ModificationViewDelegate <NSObject>

- (void)modificationComplete:(BOOL)isComplete;

@end
@interface ModificationView : UIView
@property (weak, nonatomic) id<ModificationViewDelegate>delegate;
- (id)initWithFrame:(CGRect)frame With:(id<ModificationViewDelegate>)delegate;

- (id)initWith:(id<ModificationViewDelegate>)delegate;

@end
