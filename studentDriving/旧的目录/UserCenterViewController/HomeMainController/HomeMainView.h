//
//  HomeMainView.h
//  TestCar
//
//  Created by ytzhang on 15/12/14.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,kSearchType) {
    /**
     *  首页
     */
    kSearchMainView = 1,
    /**
     *  科目一
     */
    KSubjectOneView,
    /**
     *  科目二
     */
    KSubjectTwoView,
    /**
     *  科目三
     */
    KSubjectThreeView,
    /**
     *  科目四
     */
    KSubjectFourView
};

typedef void (^didClickBlock) (NSInteger  tag);

@interface HomeMainView : UIView

@property (nonatomic,assign) kSearchType kSearchType;

@property (nonatomic,copy) didClickBlock didClickBlock;
- (instancetype)initWithFrame:(CGRect)frame SearchType:(kSearchType)searchType;

@end
