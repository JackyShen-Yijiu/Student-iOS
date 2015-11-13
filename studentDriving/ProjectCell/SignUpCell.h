//
//  SignUpOneTableViewCell.h
//  BlackCat
//
//  Created by 董博 on 15/9/17.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SIGNUPCOMPLETION)(NSString *completionString);
@interface SignUpCell : UITableViewCell
@property (copy, nonatomic) SIGNUPCOMPLETION signUpCompletion;
- (void)receiveTitile:(NSString *)titleString andSignUpBlock:(SIGNUPCOMPLETION)signUpCompletion;

- (void)receiveTextContent:(NSString *)content;
@end
