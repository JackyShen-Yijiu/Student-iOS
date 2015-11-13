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

static NSString *const kBnnerImageUrl = @"info/headlinenews";

@interface MainViewController ()<BaseContainViewControllerDelegate,BottomMenuDelegate>
@property (strong, nonatomic) BaseContainViewController *baseContain;
@property (strong, nonatomic) BottomMenu *menu;
@property (strong, nonatomic) NSArray *titleNameArray;
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
}

@end
