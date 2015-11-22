//
//  MainViewController.m
//  BlackCat
//
//  Created by 董博 on 15/9/3.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "MainViewController.h"
#import "BaseContainViewController.h"
#import "UIView+CalculateUIView.h"
#import "UIDevice+JEsystemVersion.h"
#import "SubjectFirstViewController.h"
#import "ApplyDrivingViewController.h"
#import "SubjectSecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
#import "BottomMenu.h"
#import <SVProgressHUD.h>
#import "AcountManager.h"
#import "EMCDDeviceManager.h"
#import "UserProfileManager.h"
#import "ChatViewController.h"
static NSString *kConversationChatter = @"ConversationChatter";

static NSString *const kBnnerImageUrl = @"info/headlinenews";

static const CGFloat kDefaultPlaySoundInterval = 3.0;
static NSString *kMessageType = @"MessageType";


@interface MainViewController ()<BaseContainViewControllerDelegate,BottomMenuDelegate,IChatManagerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) BaseContainViewController *baseContain;
@property (strong, nonatomic) BottomMenu *menu;
@property (strong, nonatomic) NSArray *titleNameArray;
@property (strong, nonatomic) NSDate *lastPlaySoundDate;

@end

@implementation MainViewController
- (NSArray *)titleNameArray {
    if (_titleNameArray == nil) {
        _titleNameArray = @[@"报名",@"科目1",@"科目2"];
    }
    return _titleNameArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:@"kLoginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(quitSuccess) name:@"kQuitSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userapplysuccess) name:@"kuserapplysuccess" object:nil];
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    
    
    self.title = @"一步学车";
    
#pragma mark - 处理聊天
    
    [self registerNotifications];

    [self setupUnreadMessageCount];

    
    
#pragma mark - 控制器处理
    ApplyDrivingViewController *applyVc       = [[ApplyDrivingViewController alloc] init];
    applyVc.title = @"报名";
    SubjectFirstViewController *subjectFirst  = [[SubjectFirstViewController alloc] init];
    subjectFirst.title = @"科目1";
    SubjectSecondViewController *subjectSecond= [[SubjectSecondViewController alloc] init];
    subjectSecond.title = @"科目2";
    
    ThirdViewController *third = [[ThirdViewController alloc] init];
    third.title = @"科目3";
    
    FourViewController *four = [[FourViewController alloc] init];
    four.title = @"科目4";
    
    _baseContain = [[BaseContainViewController
                                                  alloc]initWIthChildViewControllerItems:@[applyVc,subjectFirst,subjectSecond,third,four]];
    _baseContain.delegate                     = self;
    [self addChildViewController:_baseContain];
    [self.view addSubview:_baseContain.view];
    [_baseContain didMoveToParentViewController:self];
    
    _menu  = [[BottomMenu alloc]
                                                 initWithFrame:CGRectMake(0, self.view.calculateFrameWithHeight-44, self.view.calculateFrameWithWide, 44) withItems:@[applyVc,subjectFirst,subjectSecond,third,four]];
    _menu.delegate                            = self;
    [self.view addSubview:_menu];
    
    [self startDownLoad];
    
    
}

#pragma mark - 聊天分界线
-(void)registerNotifications
{
    [self unregisterNotifications];
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications
{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}
// 统计未读消息数
-(void)setupUnreadMessageCount
{
    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
   
    UIApplication *application = [UIApplication sharedApplication];
    [application setApplicationIconBadgeNumber:unreadCount];
}
//聊天回调 消息变化回调
- (void)didUpdateConversationList:(NSArray *)conversationList
{
    [self setupUnreadMessageCount];
//    [_chatListVC refreshDataSource];
}
// 未读消息数量变化回调
-(void)didUnreadMessagesCountChanged
{
    [self setupUnreadMessageCount];
}
- (void)didFinishedReceiveOfflineMessages
{
    [self setupUnreadMessageCount];
}
- (BOOL)needShowNotification:(NSString *)fromChatter
{
    BOOL ret = YES;
    NSArray *igGroupIds = [[EaseMob sharedInstance].chatManager ignoredGroupIds];
    for (NSString *str in igGroupIds) {
        if ([str isEqualToString:fromChatter]) {
            ret = NO;
            break;
        }
    }
    
    return ret;
}
// 收到消息回调
-(void)didReceiveMessage:(EMMessage *)message
{
    BOOL needShowNotification = (message.messageType != eMessageTypeChat) ? [self needShowNotification:message.conversationChatter] : YES;
    if (needShowNotification) {
#if !TARGET_IPHONE_SIMULATOR
        

        UIApplicationState state = [[UIApplication sharedApplication] applicationState];
        switch (state) {
            case UIApplicationStateActive:
                [self playSoundAndVibration];
                break;
            case UIApplicationStateInactive:
                [self playSoundAndVibration];
                break;
            case UIApplicationStateBackground:
                [self showNotificationWithMessage:message];
                break;
            default:
                break;
        }
#endif
    }
}
- (void)playSoundAndVibration{
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    // 收到消息时，播放音频
    [[EMCDDeviceManager sharedInstance] playNewMessageSound];
    // 收到消息时，震动
    [[EMCDDeviceManager sharedInstance] playVibration];
}

- (void)showNotificationWithMessage:(EMMessage *)message
{
    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
    //发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date]; //触发通知的时间
    notification.hasAction = NO;

    if (options.displayStyle == ePushNotificationDisplayStyle_messageSummary) {
        id<IEMMessageBody> messageBody = [message.messageBodies firstObject];
        NSString *messageStr = nil;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Text:
            {
                messageStr = ((EMTextMessageBody *)messageBody).text;
            }
                break;
            case eMessageBodyType_Image:
            {
                messageStr = NSLocalizedString(@"message.image", @"Image");
            }
                break;
            case eMessageBodyType_Location:
            {
                messageStr = NSLocalizedString(@"message.location", @"Location");
            }
                break;
            case eMessageBodyType_Voice:
            {
                messageStr = NSLocalizedString(@"message.voice", @"Voice");
            }
                break;
            case eMessageBodyType_Video:{
                messageStr = NSLocalizedString(@"message.video", @"Video");
            }
                break;
            default:
                break;
        }
        
        NSString *title = [[UserProfileManager sharedInstance] getNickNameWithUsername:message.from];
        if (message.messageType == eMessageTypeGroupChat) {
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:message.conversationChatter]) {
                    title = [NSString stringWithFormat:@"%@(%@)", message.groupSenderName, group.groupSubject];
                    break;
                }
            }
        }
        else if (message.messageType == eMessageTypeChatRoom)
        {
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            NSString *key = [NSString stringWithFormat:@"OnceJoinedChatrooms_%@", [[[EaseMob sharedInstance].chatManager loginInfo] objectForKey:@"username" ]];
            NSMutableDictionary *chatrooms = [NSMutableDictionary dictionaryWithDictionary:[ud objectForKey:key]];
            NSString *chatroomName = [chatrooms objectForKey:message.conversationChatter];
            if (chatroomName)
            {
                title = [NSString stringWithFormat:@"%@(%@)", message.groupSenderName, chatroomName];
            }
        }
        
        notification.alertBody = [NSString stringWithFormat:@"%@:%@", message.ext[@"nickName"], messageStr];
    }
    else{
        notification.alertBody = NSLocalizedString(@"receiveMessage", @"you have a new message");
    }
    
#warning 去掉注释会显示[本地]开头, 方便在开发中区分是否为本地推送
//    notification.alertBody = [[NSString alloc] initWithFormat:@"[本地]%@", notification.alertBody];
    
//    notification.hasAction = NO;
//    notification.alertAction = NSLocalizedString(@"open", @"Open");
    notification.timeZone = [NSTimeZone defaultTimeZone];
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
    } else {
        notification.soundName = UILocalNotificationDefaultSoundName;
        self.lastPlaySoundDate = [NSDate date];
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[NSNumber numberWithInt:message.messageType] forKey:kMessageType];
    [userInfo setObject:message.conversationChatter forKey:kConversationChatter];
    notification.userInfo = userInfo;

    //发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    //    UIApplication *application = [UIApplication sharedApplication];
    //    application.applicationIconBadgeNumber += 1;
}
- (void)dealInfo:(NSDictionary *)info {
    if (info) {
        NSArray *viewControllers = self.navigationController.viewControllers;
        [viewControllers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            if (obj != self)
            {
                if (![obj isKindOfClass:[ChatViewController class]])
                {
                    [self.navigationController popViewControllerAnimated:NO];
                }
                else
                {
                    NSString *conversationChatter = info[kConversationChatter];
                    ChatViewController *chatViewController = (ChatViewController *)obj;
                    if (![chatViewController.conversation.chatter isEqualToString:conversationChatter])
                    {
                        [self.navigationController popViewControllerAnimated:NO];
//                        EMMessageType messageType = [info[kMessageType] intValue];
                        chatViewController = [[ChatViewController alloc] initWithChatter:conversationChatter conversationType:eConversationTypeChat];
//                       chatViewController.title = conversationChatter;
                        [self.navigationController pushViewController:chatViewController animated:NO];
                        return ;
                    }
                }
            }
            else
            {
                ChatViewController *chatViewController = (ChatViewController *)obj;
                NSString *conversationChatter = info[kConversationChatter];
//                EMMessageType messageType = [info[kMessageType] intValue];
                chatViewController = [[ChatViewController alloc] initWithChatter:conversationChatter conversationType:eConversationTypeChat];
//                chatViewController.title = conversationChatter;
                 [self.navigationController pushViewController:chatViewController animated:NO];
            }
           
        }];

    }
}
#pragma mark - 聊天分解线
- (void)startDownLoad {
    NSString *urlString = [NSString stringWithFormat:BASEURL,kBnnerImageUrl];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
   
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (responseObject) {
            NSDictionary *param = responseObject;
            NSNumber *type = param[@"type"];
            if (type.integerValue == 1) {
                NSArray *dataArray = param[@"data"];
                [AcountManager saveUserBanner:dataArray];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kBannerChange" object:nil];
            }
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
       
    }];
}
- (void)horizontalScrollPageIndex:(NSUInteger)index {

   
    [_menu menuScrollWithIndex:index];
//    self.title = self.titleNameArray[index];
}
- (void)horizontalMenuScrollPageIndex:(NSUInteger)index {
  
    [_baseContain replaceVcWithIndex:index];
//    self.title = self.titleNameArray[index];

}
- (void)userapplysuccess {
    [_menu menuScrollWithIndex:1];
    [_baseContain replaceVcWithIndex:1];
}
- (void)quitSuccess {
    [_menu menuScrollWithIndex:0];
    [_baseContain replaceVcWithIndex:0];
}

- (void)loginSuccess {
    NSUInteger index = [AcountManager manager].userSubject.subjectId.integerValue;
    [_menu menuScrollWithIndex:index];
    [_baseContain replaceVcWithIndex:index];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[EaseMob sharedInstance].chatManager removeDelegate:self];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
@end
