//
//  CommentCell.h
//  BlackCat
//
//  Created by bestseller on 15/10/8.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingBar.h"

@protocol CommentCellDelegate <NSObject>

- (void)senderStarProgress:(CGFloat)newProgress withIndex:(NSIndexPath *)indexPath;

@end
@interface CommentCell : UITableViewCell<RatingBarDelegate>
@property (strong, nonatomic) RatingBar *starBar;
@property (strong, nonatomic) UILabel *topLabel;
@property (weak, nonatomic) id<CommentCellDelegate>delegate;
- (void)receiveIndex:(NSIndexPath *)indexPath;
@end
