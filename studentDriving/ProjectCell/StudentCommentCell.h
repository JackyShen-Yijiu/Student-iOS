//
//  StudentCommentCell.h
//  BlackCat
//
//  Created by bestseller on 15/9/29.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StudentCommentModel;
@interface StudentCommentCell : UITableViewCell
- (void)receiveCommentMessage:(StudentCommentModel *)messageModel;
@end
