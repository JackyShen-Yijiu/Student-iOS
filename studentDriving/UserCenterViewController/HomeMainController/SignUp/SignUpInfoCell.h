//
//  SignUpInfoCell.h
//  studentDriving
//
//  Created by ytzhang on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignUpTextField.h"
typedef void(^SIGNUPCOMPLETION)(NSString *completionString);

@interface SignUpInfoCell : UITableViewCell
@property (copy, nonatomic) SIGNUPCOMPLETION signUpCompletion;
@property (strong, nonatomic) SignUpTextField *signUpTextField;
- (void)receiveTitile:(NSString *)titleString andSignUpBlock:(SIGNUPCOMPLETION)signUpCompletion;

- (void)receiveTextContent:(NSString *)content;
@end
