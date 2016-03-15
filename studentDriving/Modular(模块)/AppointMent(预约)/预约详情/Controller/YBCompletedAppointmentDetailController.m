//
//  YBCompletedAppointmentDetailController.m
//  studentDriving
//
//  Created by 大威 on 16/3/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBCompletedAppointmentDetailController.h"
#import "YBAppointmentDetailCell.h"
#import "HMCourseModel.h"
#import "ChatViewController.h"
#import "NSString+Helper.h"

#import "DVVStarView.h"


static NSString *kCellIdentifier = @"kCellIdentifier";

@interface YBCompletedAppointmentDetailController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) DVVStarView *starView;


@end

@implementation YBCompletedAppointmentDetailController


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = YBMainViewControlerBackgroundColor;
    self.title = @"预约详情";
    [self.view addSubview:self.tableView];
    
    // 加载评论
    [self requestData];
}


#pragma mark - action

- (void)imButtonAction {
    
    ChatViewController *chatController = [[ChatViewController alloc] initWithChatter:_courseModel.userModel.coachid
                                                                    conversationType:eConversationTypeChat];
    chatController.title = _courseModel.userModel.name;
    [self.navigationController pushViewController:chatController animated:YES];
}

#pragma mark - tableView delegate and data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YBAppointmentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if (indexPath.row==0) {// 科目二 第多少课时
        cell.iconImageView.image = [UIImage imageNamed:@"YBAppointMentDetailsinformation"];
        cell.titleLabel.text = _courseModel.courseprocessdesc;
        
    }else if (indexPath.row==1){//
        cell.iconImageView.image = [UIImage imageNamed:@"YBAppointMentDetailstime"];
        
        NSString *MMString = [self getLocalDateFormateUTCDate:_courseModel.courseBeginTime format:@"MM"];
        NSString *ddString = [self getLocalDateFormateUTCDate:_courseModel.courseBeginTime format:@"dd"];
        // 将后台传回的时间转化为HH:mm格式的
        NSString *format = @"HH:mm";
        NSString *beginString = [self getLocalDateFormateUTCDate:_courseModel.courseBeginTime format:format];
        
        NSString *endString = [self getLocalDateFormateUTCDate:_courseModel.courseEndtime format:format];
        
        cell.titleLabel.text = [NSString stringWithFormat:@"%@/%@ %@-%@", MMString, ddString, beginString, endString];
        
    }else if (indexPath.row==2){// 签到时间
        
        cell.iconImageView.image = [UIImage imageNamed:@"YBAppointMentDetailstime"];
        
        if (_courseModel.sigintime.length) {
            cell.titleLabel.text = [NSString stringWithFormat:@"签到时间:%@", [self getLocalDateFormateUTCDate:_courseModel.sigintime format:@"HH:mm"]];
        }else {
            cell.titleLabel.text = @"";
            
        }
        
    }else if (indexPath.row==3){// 学习内容
        cell.iconImageView.image = [UIImage imageNamed:@"YBAppointMentDetailsmodel"];
        cell.titleLabel.text = _courseModel.learningcontent;
    }else if (indexPath.row==4){// 教练
        cell.iconImageView.image = [UIImage imageNamed:@"YBAppointMentDetailscoach"];
        cell.titleLabel.text = _courseModel.userModel.name;
        
        [cell.button setImage:[UIImage imageNamed:@"YBAppointMentDetailstalk"] forState:UIControlStateNormal];
        [cell.button addTarget:self action:@selector(imButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
    }else if (indexPath.row==5){// 训练场地
        cell.imageView.image = [UIImage imageNamed:@"YBAppointMentDetailslocation"];
        cell.titleLabel.text = _courseModel.courseTrainInfo.address;
    }
    
    if (indexPath.row == 5) {
        cell.lineImageView.hidden = YES;
    }else {
        cell.lineImageView.hidden = NO;
    }
    
    return cell;
}


#pragma mark - network

- (void)requestData {
    
    if (!_courseModel.courseId.length) {
        return ;
    }
    
    NSString *url = [NSString stringWithFormat:BASEURL, @"courseinfo/userreservationinfo/"];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", url, _courseModel.courseId];
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
//    comment:{ starlevel :Number, // 星级
//              attitudelevel:Number, //态度级别
//              timelevel:Number,  //时间观念星级
//              abilitylevel:Number,  // 能力星级
//              commentcontent:String,
//              commenttime:Date } , // 评论内容
        
        
        NSDictionary *dict = data[@"comment"];
        if ([dict isKindOfClass:[NSDictionary class]]) {
    
//    // 测试数据
//    NSDictionary *dict = @{ @"starlevel": @"3",
//                            @"commenttime": @"2016-03-05T12:00:00.000Z",
//                            @"commentcontent": @"fjkldsjflkdsjflksdjfkljdslkfjsdlkfjkdnvdcnvdfvldk;fnv;ldkf" };
    
            NSUInteger star = [dict[@"starlevel"] integerValue];
            NSString *time = dict[@"commenttime"];
            NSString *content = dict[@"commentcontent"];
            
            CGFloat width = [UIScreen mainScreen].bounds.size.width;
            
            UILabel *titleLabel = [UILabel new];
            titleLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
            titleLabel.font = [UIFont systemFontOfSize:14];
            titleLabel.text = @"我的评价";
            
            // 线
            UIView *lineView = [UIView new];
            lineView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
            
            // 星级
            DVVStarView *starView = [DVVStarView new];
            [starView dvv_setBackgroundImage:@"star_all_default_icon" foregroundImage:@"star_all_icon" width:94 height:14];
            [starView dvv_setStar:star];
            
            // 时间
            UILabel *timeLabel = [UILabel new];
            timeLabel.textAlignment = NSTextAlignmentRight;
            timeLabel.textColor = [UIColor colorWithHexString:@"b7b7b7"];
            timeLabel.font = [UIFont systemFontOfSize:12];
            timeLabel.text = [self getLocalDateFormateUTCDate:time format:@"MM/dd HH:mm"];
            
            // 评论内容
            UILabel *contentLabel = [UILabel new];
            contentLabel.textColor = [UIColor colorWithHexString:@"b7b7b7"];
            contentLabel.font = [UIFont systemFontOfSize:12];
            contentLabel.numberOfLines = 0;
            contentLabel.text = content;
            
            UIView *bgView = [UIView new];
            [bgView addSubview:titleLabel];
            [bgView addSubview:starView];
            [bgView addSubview:lineView];
            [bgView addSubview:timeLabel];
            [bgView addSubview:contentLabel];
            
            // 配置frame
            titleLabel.frame = CGRectMake(16, 0, width - 16, 44);
            lineView.frame = CGRectMake(0, 44, width, 0.5);
            starView.frame = CGRectMake(15, 44+15, 94, 14);
            timeLabel.frame = CGRectMake(width/2.0 - 16, 44+15 + 1, width/2.0, 12);
            CGFloat contentHeight = [NSString autoHeightWithString:content width:width-16*2 font:[UIFont systemFontOfSize:12]];
            contentLabel.frame = CGRectMake(16, CGRectGetMaxY(timeLabel.frame) + 15, width - 16*2, contentHeight);
            
            bgView.frame = CGRectMake(0, 10, width, CGRectGetMaxY(contentLabel.frame) + 15);
            
            
            // 分割上下两部分的分割块
            UIView *splitBlockView = [UIView new];
            splitBlockView.backgroundColor = YBMainViewControlerBackgroundColor;
            splitBlockView.frame = CGRectMake(0, 0, width, 10);
            
            UIView *contentView = [UIView new];
            contentView.backgroundColor = [UIColor whiteColor];
            contentView.frame = CGRectMake(0, 0, width, 10 + CGRectGetHeight(bgView.frame));
            
            [contentView addSubview:splitBlockView];
            [contentView addSubview:bgView];
            
            self.tableView.tableFooterView = contentView;
        }
        
        
    } withFailure:^(id data) {
        ;
    }];
}


#pragma mark - lazy load

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.frame = CGRectMake(0, 0, kSystemWide, [UIScreen mainScreen].bounds.size.height - 64);
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[YBAppointmentDetailCell class] forCellReuseIdentifier:kCellIdentifier];
    }
    return _tableView;
}

- (NSString *)dateFromLocalWithFormatString:(NSString *)formatString {
    
    NSDate *localDate = [NSDate new];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:formatString];
    return [dateFormatter stringFromDate:localDate];
}

//将UTC日期字符串转为本地时间字符串
//输入的UTC日期格式2013-08-03T04:53:51+0000
- (NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate format:(NSString *)formatString {
    //    NSLog(@"utc = %@",utcDate);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    [dateFormatter setDateFormat:formatString];
    //    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
