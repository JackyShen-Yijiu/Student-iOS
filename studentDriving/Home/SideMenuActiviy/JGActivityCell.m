//
//  JGActivityCell.m
//  studentDriving
//
//  Created by JiangangYang on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JGActivityCell.h"
#import "JGActivityModel.h"

@implementation JGActivityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"JGActivityCell" owner:self options:nil];
        JGActivityCell *cell = xibArray.firstObject;
        
        [cell setRestorationIdentifier:reuseIdentifier];
        self = cell;
    }
    return self;
}

- (void)setActivityModel:(JGActivityModel *)activityModel
{
    
    _activityModel = activityModel;
    
    switch (_activityModel.activitystate) {
            
        case activitystateRead:
            
            self.activityLabel.text = @"  准备中";
            self.stateImgViww.image = [UIImage imageNamed:@"activityBgState2.png"];
            self.activityTimeLabel.backgroundColor = [UIColor lightGrayColor];
            
        break;
     
        case activitystateIng:
            
            self.activityLabel.text = @"  进行中";
            self.stateImgViww.image = [UIImage imageNamed:@"activityBgState1.png"];
            self.activityTimeLabel.backgroundColor = MAINCOLOR;
            
        break;
        
        case activitystateComplete:
            
            self.activityLabel.text = @"  已结束";
            self.stateImgViww.image = [UIImage imageNamed:@"activityBgState3.png"];
            self.activityTimeLabel.backgroundColor = [UIColor blackColor];
            
        break;
            
        default:
            break;
    }
    

    [self.activityImgView sd_setImageWithURL:[NSURL URLWithString:_activityModel.contenturl] placeholderImage:[UIImage imageNamed:@"baomingBtnNomal.png"]];
    
    self.activityTimeLabel.text = [NSString stringWithFormat:@" %@ ",[self dateFromISO8601String:_activityModel.enddate]];

}

- (NSString *)dateFromISO8601String:(NSString *)string {
    if (!string) return nil;
    
    struct tm tm;
    time_t t;
    
    strptime([string cStringUsingEncoding:NSUTF8StringEncoding], "%Y-%m-%dT%H:%M:%S%z", &tm);
    tm.tm_isdst = -1;
    t = mktime(&tm);
    
    //    return [NSDate dateWithTimeIntervalSince1970:t]; // 零时区
    NSDate * date =  [NSDate dateWithTimeIntervalSince1970:t + [[NSTimeZone localTimeZone] secondsFromGMT]];//东八区
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    
    return currentDateStr;
}

@end
