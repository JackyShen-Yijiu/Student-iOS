//
//  YBSubjectData.m
//  studentDriving
//
//  Created by JiangangYang on 16/4/9.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBSubjectData.h"

@implementation YBSubjectData
- (NSMutableDictionary *)selectnumDict
{
    if (_selectnumDict==nil) {
        _selectnumDict = [NSMutableDictionary dictionary];
    }
    return _selectnumDict;
}

- (NSMutableArray *)answer_trueArray
{
    NSMutableArray *tempArray = [NSMutableArray array];
    
    NSString *answer_truestr = [NSString stringWithFormat:@"%ld",(long)_answer_true];
   // NSLog(@"answer_truestr:%@",answer_truestr);
    
    for(int i =0; i < [answer_truestr length]; i++)
    {

        NSString *str = [answer_truestr substringWithRange:NSMakeRange(i, 1)];

        [tempArray addObject:str];
        
    }
   // NSLog(@"tempArray:%@",tempArray);
    
    return tempArray;
}

- (NSString *)answer_trueStr{
    
    __block NSMutableString *tempStr = [NSMutableString string];
    
    [self.answer_trueArray enumerateObjectsUsingBlock:^(NSString *answerStr, NSUInteger index, BOOL * _Nonnull stop) {
        
        if ([answerStr isEqualToString:@"1"]) {
            answerStr = @"A";
        }
        if ([answerStr isEqualToString:@"2"]) {
            answerStr = @"B";
        }
        if ([answerStr isEqualToString:@"3"]) {
            answerStr = @"C";
        }
        if ([answerStr isEqualToString:@"4"]) {
            answerStr = @"D";
        }
        
        if (index==self.answer_trueArray.count-1) {
            [tempStr appendString:[NSString stringWithFormat:@"%@",answerStr]];
        }else{
            [tempStr appendString:[NSString stringWithFormat:@"%@、",answerStr]];
        }
        
    }];
   // NSLog(@"-----------answer_trueStr:%@",tempStr);
    
    return tempStr;
}

@end
