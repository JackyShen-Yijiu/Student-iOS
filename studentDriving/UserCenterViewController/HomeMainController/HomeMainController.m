//
//  HomeMainController.m
//  TestCar
//
//  Created by ytzhang on 15/12/13.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "HomeMainController.h"
#import "HomeMainView.h"
#import "HomeSpotView.h"
#import "UIViewController+SliderMenu.h"
#import "ToolHeader.h"
#import "JENetwoking.h"
#import "DVVSideMenu.h"
#import "DVVUserManager.h"

#import "ChatViewController.h"
#import "SignUpListViewController.h"
// 首页
#import "HomeAdvantageController.h"
#import "HomeFavourableController.h"
#import "HomeRewardController.h"

// 科目一
#import "QuestionBankViewController.h"
#import "QuestionTestViewController.h"
#import "WrongQuestionViewController.h"

// 科目二
#import "BLAVPlayerViewController.h"
#import "BLAVDetailViewController.h"
#import "AppointmentViewController.h"
#import "AppointmentDrivingViewController.h"

#import "NSUserStoreTool.h"

// 科目三
static NSString *kinfomationCheck = @"userinfo/getmyapplystate";

static NSString *kConversationChatter = @"ConversationChatter";

static NSString *const kexamquestionUrl = @"/info/examquestion";

static NSString *const kgetMyProgress = @"/userinfo/getmyprogress";

#define ksubject      @"subject"
#define ksubjectTwo   @"subjecttwo"
#define ksubjectThree @"subjectthree"

#define carOffsetX   ((systemsW - 10) * 0.2)
#define systemsW   self.view.frame.size.width
#define systemsH  [[UIScreen mainScreen] bounds].size.height
#define CARFloat carOffsetX

@interface HomeMainController () <UIScrollViewDelegate,HomeSpotViewDelegate>

@property (nonatomic,strong) HomeSpotView *homeSpotView;
@property (nonatomic,strong) UIScrollView *mainScrollView;
@property (nonatomic,strong) UIImageView *backImage;
@property (nonatomic,strong) HomeMainView  *homeMainView;
@property (nonatomic,strong) HomeMainView *subjectOneView;
@property (nonatomic,strong) HomeMainView *subjectTWoView;
@property (nonatomic,strong) HomeMainView *subjectThreeView;
@property (nonatomic,strong) HomeMainView *subjectFourView;
@property (nonatomic,assign) CGFloat imageX; //用于记录背景图片位置

@property (nonatomic,assign) CGFloat offsetX;

@property (copy, nonatomic) NSString *questionlisturl;
@property (copy, nonatomic) NSString *questiontesturl;
@property (copy, nonatomic) NSString *questionerrorurl;

@property (copy, nonatomic) NSString *questionFourlisturl;
@property (copy, nonatomic) NSString *questionFourtesturl;
@property (copy, nonatomic) NSString *questionFourerrorurl;
@end

@implementation HomeMainController
//- (void)viewWillAppear:(BOOL)animated
//{
//    self.mainScrollView.contentOffset = CGPointMake(0, 0);
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"一步学车";
    _offsetX = 0;
    self.view.backgroundColor = [UIColor clearColor];
    [self addSideMenuButton];
    
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 174)];
    _mainScrollView.backgroundColor = [UIColor clearColor];
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width * 5, 0);
    _mainScrollView.delegate = self;
     _mainScrollView.pagingEnabled = YES;
    [_mainScrollView setShowsHorizontalScrollIndicator:NO];

    // 添加UIImageView,用于当滑动时,背景滑动1/4
    _backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, systemsW * 2, systemsH)];
    _backImage.image = [UIImage imageNamed:@"bg"];
    _imageX = 0;
//    [_backImage addSubview:_mainScrollView];
    
     [self.view addSubview:_backImage];
    [self.view addSubview:_mainScrollView];
   
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 83, self.view.frame.size.width, 83)];
//    view.backgroundColor = [UIColor orangeColor];
    self.homeSpotView.frame = CGRectMake(0,0, systemsW, 83);
//    _homeSpotView.backgroundColor = [UIColor whiteColor];
    _homeSpotView.delegate = self;
    [view addSubview:_homeSpotView];
    
    
    [self.view addSubview:view];
    
    // 点击时的回调
    [self addBackBlock];

    [self startSubjectFirstDownLoad];
    [self startSubjectFourDownLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark ---- 
- (void)startSubjectFirstDownLoad {
    NSString *urlString = [NSString stringWithFormat:BASEURL,kexamquestionUrl];
    
    __weak HomeMainController *weakSelf = self;
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSDictionary *param = data[@"data"];
        NSDictionary *subjectOne = param[@"subjectone"];
        if (subjectOne) {
            weakSelf.questiontesturl = subjectOne[@"questiontesturl"];
            weakSelf.questionlisturl = subjectOne[@"questionlisturl"];
            weakSelf.questionerrorurl = subjectOne[@"questionerrorurl"];
        }
    }];
    
    if (![AcountManager isLogin]) {
        return;
    }
    NSString *applyUrlString = [NSString stringWithFormat:BASEURL,kinfomationCheck];
    NSDictionary *param = @{@"userid":[AcountManager manager].userid};
    [JENetwoking startDownLoadWithUrl:applyUrlString postParam:param WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        if (!data) {
            return ;
        }
        NSDictionary *param = data;
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        if ([type isEqualToString:@"1"]) {
            NSDictionary *dataDic = [param objectForKey:@"data"];
            if (!dataDic || ![dataDic isKindOfClass:[NSDictionary class]]) {
                return;
            }
            if ([[dataDic objectForKey:@"applystate"] integerValue] == 0) {
                [AcountManager saveUserApplyState:@"0"];
            }else if ([[dataDic objectForKey:@"applystate"] integerValue] == 1) {
                [AcountManager saveUserApplyState:@"1"];
            }else {
                [AcountManager saveUserApplyState:@"2"];
            }

        }else {
            [self showTotasViewWithMes:[data objectForKey:@"msg"]];
        }
    } withFailure:^(id data) {
         [self showTotasViewWithMes:@"网络错误"];
    }];
    
    NSString *getMyProgress = [NSString stringWithFormat:BASEURL,kgetMyProgress];
    [JENetwoking startDownLoadWithUrl:getMyProgress postParam:param WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        if (!data) {
            return ;
        }
        NSDictionary *param = data;
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        if ([type isEqualToString:@"1"]) {
            NSDictionary *dataDic = [param objectForKey:@"data"];
            if (!dataDic || ![dataDic isKindOfClass:[NSDictionary class]]) {
                return;
            }
            if ([dataDic objectForKey:ksubject]) {
                [NSUserStoreTool storeWithId:[dataDic objectForKey:ksubject] WithKey:ksubject];
            }
            
            if ([dataDic objectForKey:ksubjectTwo]) {
                [NSUserStoreTool storeWithId:[dataDic objectForKey:ksubjectTwo] WithKey:ksubjectTwo];
            }
            
            if ([dataDic objectForKey:ksubjectThree]) {
                [NSUserStoreTool storeWithId:[dataDic objectForKey:ksubjectThree] WithKey:ksubjectThree];
            }
            
        }else {
            [self showTotasViewWithMes:[data objectForKey:@"msg"]];
        }
    } withFailure:^(id data) {
        [self showTotasViewWithMes:@"网络错误"];
    }];
    
}
- (void)startSubjectFourDownLoad
{
    NSString *urlString = [NSString stringWithFormat:BASEURL,kexamquestionUrl];
    
    __weak HomeMainController *weakSelf = self;
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSDictionary *param = data[@"data"];
        NSDictionary *subjectOne = param[@"subjectfour"];
        weakSelf.questionFourtesturl = subjectOne[@"questiontesturl"];
        weakSelf.questionFourlisturl = subjectOne[@"questionlisturl"];
        weakSelf.questionFourerrorurl = subjectOne[@"questionerrorurl"];
        
    }];
 
}




#pragma mark --- 回调方法
- (void)addBackBlock
{
    __weak HomeMainController *mainVC = self;
    
    self.homeMainView.didClickBlock = ^(NSInteger tag){
        switch (tag) {
            case 101:
            {
                HomeAdvantageController *homeAdvantageVC = [[HomeAdvantageController alloc] init];
                [mainVC.navigationController pushViewController:homeAdvantageVC animated:YES];
            }
                break;
                case 102:

            {
                HomeFavourableController *homeAdvantageVC = [[HomeFavourableController alloc] init];
                [mainVC.navigationController pushViewController:homeAdvantageVC animated:YES];

            }
                break;
                case 103:
            {
                HomeRewardController *homeAdvantageVC = [[HomeRewardController alloc] init];
                [mainVC.navigationController pushViewController:homeAdvantageVC animated:YES];

            }
                break;
            default:
                break;
        }
    
        NSLog(@"我被回调了tag = %lu",tag);
        
    };
    // 科目一回调
    self.subjectOneView.didClickBlock = ^(NSInteger tag)
    {
         NSLog(@"我被回调了tag = %lu",tag);
        
        switch (tag) {
            case 101:
            {
                QuestionTestViewController *questionVC = [[QuestionTestViewController alloc] init];
                questionVC.questiontesturl = mainVC.questiontesturl;
                [mainVC.navigationController pushViewController:questionVC animated:YES];
            }
                break;
            case 102:
            {
                WrongQuestionViewController *wrongQuestVC = [[WrongQuestionViewController alloc] init];
                wrongQuestVC.questionerrorurl = mainVC.questionerrorurl;
                NSLog(@"%@",wrongQuestVC.questionerrorurl);
                [mainVC.navigationController pushViewController:wrongQuestVC animated:YES];
            }
                break;
                case 103:
            {
                QuestionBankViewController *questBankVC = [[QuestionBankViewController alloc] init];
                questBankVC.questionlisturl = mainVC.questionlisturl;
                [mainVC.navigationController pushViewController:questBankVC animated:YES];
            }
                break;
                
            default:
                break;
        }
    };
    // 科目二的回调
    self.subjectTWoView.didClickBlock = ^(NSInteger tag)
    {
        switch (tag) {
            case 101:
            {
                BLAVPlayerViewController *bLAVPlayweVC = [[BLAVPlayerViewController alloc] init];
                bLAVPlayweVC.title = @"科二课件";
                bLAVPlayweVC.markNum = [NSNumber numberWithInteger:2];
                [mainVC.navigationController pushViewController:bLAVPlayweVC animated:YES];
            }
                break;
                case 102:
            {
                if ([[AcountManager manager].userApplystate isEqualToString:@"1"]) {
                    [mainVC showTotasViewWithMes:@"报名正在审核中!"];
                    return ;
                    
                } else if ([[AcountManager manager].userApplystate isEqualToString:@"2"])
                {
                    AppointmentDrivingViewController *appointVC = [[AppointmentDrivingViewController alloc] init];
                    [mainVC.navigationController pushViewController:appointVC animated:YES];
                }else
                {
                    [mainVC showTotasViewWithMes:@"你还没有报名"];
                }
                
            }
                break;
                case 103:
            {
                
                AppointmentViewController *appointment = [[AppointmentViewController alloc] init];
                appointment.title = @"科二预约列表";
                appointment.markNum = [NSNumber numberWithInteger:2];
                [mainVC.navigationController pushViewController:appointment animated:YES];
               
            }
                break;
                
            default:
                break;
        }
    };
    // 科目三的回调
    self.subjectThreeView.didClickBlock = ^(NSInteger tag)
    {
        NSLog(@"我被回调了tag = %lu",tag);
        switch (tag) {
            case 101:
            {
                BLAVPlayerViewController *bLAVPlayweVC = [[BLAVPlayerViewController alloc] init];
                bLAVPlayweVC.title = @"科三课件";
                bLAVPlayweVC.markNum = [NSNumber numberWithInteger:3];
                [mainVC.navigationController pushViewController:bLAVPlayweVC animated:YES];
            }
                break;
            case 102:
            {
               
                NSLog(@"%@",[AcountManager manager].userSubject);
                
                
                
                
                if ([[AcountManager manager].userApplystate isEqualToString:@"2"] && [[AcountManager manager].userSubject.name isEqualToString:@"科目三"]) {
                    AppointmentDrivingViewController *appointVC = [[AppointmentDrivingViewController alloc] init];
                    [mainVC.navigationController pushViewController:appointVC animated:YES];

                }else {
                    [mainVC showTotasViewWithMes:@"您未符合预约要求"];
                }
            }
                break;
            case 103:
            {
                if ([[AcountManager manager].userApplystate isEqualToString:@"2"] && [[AcountManager manager].userSubject.name isEqualToString:@"科目三"]) {
                    AppointmentViewController *appointment = [[AppointmentViewController alloc] init];
                    appointment.title = @"科三预约列表";
                    appointment.markNum = [NSNumber numberWithInteger:3];
                    [mainVC.navigationController pushViewController:appointment animated:YES];
                    
                }else {
                    [mainVC showTotasViewWithMes:@"您目前还没到科三进度!"];
                }

                
                
                
                
            }
                break;
                
            default:
                break;
        }

    };
    // 科目四的回调
    self.subjectFourView.didClickBlock = ^(NSInteger tag)
    {
        NSLog(@"我被回调了tag = %lu",tag);
        switch (tag) {
            case 101:
            {
                QuestionBankViewController *questionBank = [[QuestionBankViewController alloc] init];
                questionBank.questionlisturl = mainVC.questionFourlisturl;
                if ([AcountManager isLogin]) {
                    NSString *appendString = [NSString stringWithFormat:@"?userid=%@",[AcountManager manager].userid];
                    NSString *finalString = [mainVC.questionFourlisturl stringByAppendingString:appendString];
                    questionBank.questionlisturl = finalString;
                }
                questionBank.title = @"科四题库";
                [mainVC.navigationController pushViewController:questionBank animated:YES];

            }
                break;
                case 102:
            {
                QuestionTestViewController *questionTest = [[QuestionTestViewController alloc] init];
                if ([AcountManager isLogin]) {
                    NSString *appendString = [NSString stringWithFormat:@"?userid=%@",[AcountManager manager].userid];
                    NSString *finalString = [mainVC.questionFourtesturl stringByAppendingString:appendString];
                    questionTest.questiontesturl = finalString;
                }
                questionTest.title = @"科四课件";
                [mainVC.navigationController pushViewController:questionTest animated:YES];

            }
                break;
                case 103:
            {
                WrongQuestionViewController *wrongQuestion = [[WrongQuestionViewController alloc] init];
                if (![AcountManager isLogin]) {
                    DYNSLog(@"islogin = %d",[AcountManager isLogin]);
                    [DVVUserManager userNeedLogin];
                    return;
                }else {
                    NSString *appendString = [NSString stringWithFormat:@"?userid=%@",[AcountManager manager].userid];
                    NSString *finalString = [mainVC.questionFourerrorurl stringByAppendingString:appendString];
                    wrongQuestion.questionerrorurl = finalString;
                }
                
                [mainVC.navigationController pushViewController:wrongQuestion animated:YES];

            }
                break;
                
            default:
                break;
        }
    };
}
#pragma mark - UIScrollViewDelegate method

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self setBackImageOffet:scrollView.contentOffset.x];
    
    if (scrollView.contentOffset.x == 0) {
        [self carMore:scrollView.contentOffset.x];
        [_homeSpotView changLableColor:scrollView.contentOffset.x];
        if (!_homeMainView)
        {
            [_mainScrollView addSubview:self.homeMainView];
        }

    }
    if (0 < scrollView.contentOffset.x && scrollView.contentOffset.x  <= systemsW)
    {
        if (scrollView.contentOffset.x == systemsW) {
            [self carMore:scrollView.contentOffset.x];
            [_homeSpotView changLableColor:scrollView.contentOffset.x];
        }
        
        if (!_homeMainView)
        {
            [_mainScrollView addSubview:self.subjectOneView];
        }
    }
    if (systemsW  < scrollView.contentOffset.x && scrollView.contentOffset.x <= systemsW * 2)
    {
        // 如果没登录,滑到科目2,调到登录页面
        if (![AcountManager isLogin]) {
            [DVVUserManager userNeedLogin];
            self.mainScrollView.contentOffset = CGPointMake(systemsW, 0);
            return;
        }
        
        if ([[[AcountManager manager] userApplystate] isEqualToString:@"0"]) {
            SignUpListViewController *signUpListVC = [[SignUpListViewController alloc] init];
            [self.navigationController pushViewController:signUpListVC animated:YES];
            self.mainScrollView.contentOffset = CGPointMake(systemsW, 0);
            return;
        }
        
        if (scrollView.contentOffset.x == systemsW * 2)
        {
            [self carMore:scrollView.contentOffset.x];
            [_homeSpotView changLableColor:scrollView.contentOffset.x];
        }

        if (!_subjectTWoView)
        {

            [_mainScrollView addSubview:self.subjectTWoView];
        }
    }
    if (systemsW * 2  < scrollView.contentOffset.x && scrollView.contentOffset.x <= systemsW * 3)
    {
        
        if (scrollView.contentOffset.x == systemsW * 3)
        {
            [self carMore:scrollView.contentOffset.x];
            [_homeSpotView changLableColor:scrollView.contentOffset.x];
        }
        if (!_subjectThreeView)
        {
            
            
            if (scrollView.contentOffset.x == systemsW * 3) {
                [self carMore:scrollView.contentOffset.x];
                [_homeSpotView changLableColor:scrollView.contentOffset.x];
            }

            [_mainScrollView addSubview:self.subjectThreeView];
            
        }
    }
    if (systemsW * 3  < scrollView.contentOffset.x  && scrollView.contentOffset.x<= systemsW * 4)
        {
            if (scrollView.contentOffset.x == systemsW *4) {
                [self carMore:scrollView.contentOffset.x];
                [_homeSpotView changLableColor:scrollView.contentOffset.x];
            }

            if (!_subjectFourView)
            {
                
                [_mainScrollView addSubview:self.subjectFourView];
            }
        }
    
}

#pragma  mark --- 实现协议方法
- (void)horizontalMenuScrollPageIndex:(CGFloat)offSet
{
    CGFloat contentOffsetX ;
    CGFloat width = self.view.frame.size.width;
    if (offSet == 0 ) {
        contentOffsetX = 0;
    }else if (offSet == CARFloat){
        
        contentOffsetX = width;
    }else if (offSet == 2 * CARFloat){
        
        contentOffsetX = width *2;
    }else if (offSet == 3 * CARFloat ){
        
        contentOffsetX = width *3;
    }else if (offSet == 4 * CARFloat){
        contentOffsetX = width * 4 ;
    }
    [UIView animateWithDuration:0.5 animations:^{
        
        _mainScrollView.contentOffset = CGPointMake(contentOffsetX, 0);
    }];

}
#pragma mark ----

- (void)carMore:(CGFloat )offset
{
    CGFloat width = self.view.frame.size.width;
    CGFloat carX ;
    if (offset == 0 ) {
        carX = 0;
    }else if (offset ==  width){
        carX = CARFloat;
    }else if (offset == 2 * width ){
        carX = 2 * CARFloat;
    }else if (offset  == 3 * width){
        carX = 3 * CARFloat;
    }else if (offset == 4 * width)
    {
        carX = 4 * CARFloat;
    }
    [UIView animateWithDuration:10 animations:^{
        
    } completion:^(BOOL finished) {
    [UIView animateWithDuration:0.3 animations:^{
        _homeSpotView.carView.frame = CGRectMake(carX, _homeSpotView.carView.frame.origin.y, _homeSpotView.carView.frame.size.width,  _homeSpotView.carView.frame.size.height);

    }];
    }];
    
}

#pragma mark ---- 背景图片偏移
- (void)setBackImageOffet:(CGFloat)offSetImageX
{
       CGFloat width = self.view.frame.size.width;
    int i = (offSetImageX - _imageX) > 0 ? 1 : -1;
    CGFloat offX = _backImage.frame.size.width * 0.125 - 8;
    CGFloat resultX =  offX * offSetImageX / width  * i;
    _backImage.frame = CGRectMake(-resultX, _backImage.frame.origin.y, _backImage.frame.size.width, _backImage.frame.size.height);
    
    _imageX = _backImage.frame.origin.x;
    
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


#pragma mark ---- Lazy加载
- (HomeSpotView *)homeSpotView
{
    if (!_homeSpotView) {
        _homeSpotView = [[HomeSpotView alloc] init];
    }
    return _homeSpotView;
}
- (HomeMainView *)homeMainView {
    
    if (!_homeMainView) {
        _homeMainView = [[HomeMainView alloc] initWithFrame:CGRectMake(0, 0, systemsW, systemsH) SearchType:kSearchMainView];
        _homeMainView.backgroundColor = [UIColor clearColor];
        [_mainScrollView addSubview:_homeMainView];
    }
    return _homeMainView;
}
- (HomeMainView *)subjectOneView
{
    if (!_subjectOneView) {
        _subjectOneView = [[HomeMainView alloc] initWithFrame:CGRectMake(systemsW, 0, systemsW, systemsH) SearchType:KSubjectOneView];
        _subjectOneView.backgroundColor = [UIColor clearColor];
        [_mainScrollView addSubview:_subjectOneView];
    }
    return _subjectOneView;
}
- (HomeMainView *)subjectTWoView {
    
    if (!_subjectTWoView) {
        _subjectTWoView = [[HomeMainView alloc] initWithFrame:CGRectMake(systemsW * 2, 0, systemsW, systemsH) SearchType:KSubjectTwoView];
        _subjectTWoView.backgroundColor = [UIColor clearColor];
        [_mainScrollView addSubview:_subjectTWoView];
    }
    return _subjectTWoView;
}

- (HomeMainView *)subjectThreeView {
    
    if (!_subjectThreeView) {
        _subjectThreeView = [[HomeMainView alloc] initWithFrame:CGRectMake(systemsW * 3, 0, systemsW, systemsH) SearchType:KSubjectThreeView];
        _subjectThreeView.backgroundColor = [UIColor clearColor];
        [_mainScrollView addSubview:_subjectThreeView];
    }
    return _subjectThreeView;
}

- (HomeMainView *)subjectFourView {
    
    if (!_subjectFourView) {
        _subjectFourView = [[HomeMainView alloc] initWithFrame:CGRectMake(systemsW * 4, 0, systemsW, systemsH) SearchType:KSubjectFourView];
        _subjectFourView.backgroundColor = [UIColor clearColor];
        [_mainScrollView addSubview:_subjectFourView];
    }
    return _subjectFourView;
}

@end
