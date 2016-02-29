//
//  CityListViewController.m
//  ChinaCityList
//
//  Created by zjq on 15/10/27.
//  Copyright © 2015年 zhengjq. All rights reserved.
//

#import "CityListViewController.h"
#import "ZYPinYinSearch.h"
#import "ButtonGroupView.h"
#import "PinYinForObjc.h"
#import "DVVSearchView.h"
#import "DVVLocation.h"
#import "DrivingCityListDMRootClass.h"
#import "DVVToast.h"
#import "DVVSubCityView.h"
#import "DVVCityListDMRootClass.h"
#import "YYModel.h"

#define KSectionIndexBackgroundColor  [UIColor clearColor] //索引试图未选中时的背景颜色
#define kSectionIndexTrackingBackgroundColor [UIColor lightGrayColor]//索引试图选中时的背景
#define kSectionIndexColor [UIColor grayColor]//索引试图字体颜色
#define HotBtnColumns 3 //每行显示的热门城市数
//#define BGCOLOR [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]
#define BGCOLOR [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]
@interface CityListViewController ()<UIGestureRecognizerDelegate,UISearchBarDelegate,UITextFieldDelegate,ButtonGroupViewDelegate, DVVSubCityViewDelegate>
{
    UIImageView   *_bgImageView;
    UIView        *_tipsView;
    UILabel       *_tipsLab;
    NSTimer       *_timer;
}
@property (strong, nonatomic) UITextField *searchText;

@property (strong, nonatomic) NSMutableDictionary *searchResultDic;

@property (strong, nonatomic) ButtonGroupView *locatingCityGroupView;//定位城市试图

@property (strong, nonatomic) ButtonGroupView *hotCityGroupView;//热门城市

@property (strong, nonatomic) ButtonGroupView *historicalCityGroupView; //历史使用城市/常用城市

@property (strong, nonatomic) UIView *tableHeaderView;

@property (strong, nonatomic) NSMutableArray *arrayCitys;   //城市数据

@property (strong, nonatomic) NSMutableDictionary *cities;

@property (strong, nonatomic) NSMutableArray *keys; //城市首字母

// 搜索框
@property (nonatomic, strong) DVVSearchView *searchView;
@property (nonatomic, strong) UIView *searchContentView;

// 定位城市是否请求成功
@property (nonatomic, assign) BOOL locationCitySuccess;
// 合作城市是否请求成功
@property (nonatomic, assign) BOOL hotCitySuccess;

@end

@implementation CityListViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.arrayHotCity = [NSMutableArray array];
        
//        self.arrayHistoricalCity = [NSMutableArray array];
        
        self.arrayLocatingCity   = [NSMutableArray array];
        self.keys = [NSMutableArray array];
        self.arrayCitys = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = NO;
    
//    self.view.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"选择城市";
//    [self setNavigationWithTitle:@"选择城市"];
    
    _searchView = [DVVSearchView new];
    _searchView.placeholder = @"请输入您想要搜索的城市";
    _searchView.backgroundImageView.backgroundColor = [UIColor whiteColor];
    _searchView.frame = CGRectMake(16, 7, self.view.bounds.size.width - 16 * 2, _searchView.defaultHeight);
    __weak typeof(self) ws = self;
    [_searchView dvv_setTextFieldDidEndEditingBlock:^(UITextField *textField) {
        [ws dvvTextFieldDidEndEditingAction:textField];
    }];
    [_searchView dvv_setTextFieldTextChangeBlock:^(UITextField *textField) {
        [ws dvvTextFieldTextChangeAction:textField];
    }];

    _searchContentView = [UIView new];
    _searchContentView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    _searchContentView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
    [_searchContentView addSubview:_searchView];
    
    _searchContentView.layer.shadowColor = [UIColor blackColor].CGColor;
    _searchContentView.layer.shadowOffset = CGSizeMake(0, 2);
    _searchContentView.layer.shadowOpacity = 0.3;
    _searchContentView.layer.shadowRadius = 2;
    
	// Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.frame           = CGRectMake(0,_searchContentView.frame.origin.y+_searchContentView.frame.size.height, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - 64 - 40);
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate        = self;
    _tableView.dataSource      = self;
    
    
    [self.view addSubview:_tableView];
    [self.view addSubview:_searchContentView];
    
    // 在加载出来数据之前，先隐藏控件
    _tableView.alpha = 0;
    _searchContentView.alpha = 0;
    // 在加载出来数据之前先不能让用户点击搜索，否则就会有个小问题
    _searchContentView.userInteractionEnabled = NO;

    [DVVToast showFromView:self.view OffSetY:-64];
    // 开始定位用户所在的城市
    [DVVLocation reverseGeoCode:^(BMKReverseGeoCodeResult *result, CLLocationCoordinate2D coordinate, NSString *city, NSString *address) {
        
        _arrayLocatingCity = @[ city ].mutableCopy;
        _locationCitySuccess = YES;
        if (_hotCitySuccess) {
            [self ininHeaderView];
        }
        
    } error:^{
        _arrayLocatingCity = @[ @"定位失败" ].mutableCopy;
        _locationCitySuccess = YES;
        if (_hotCitySuccess) {
            [self ininHeaderView];
        }
    }];
    
    // 开始请求合作的城市
    [JENetwoking startDownLoadWithUrl:[NSString stringWithFormat:BASEURL, @"getopencity"] postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"%@",data);
        DrivingCityListDMRootClass *rootClass = [[DrivingCityListDMRootClass alloc] initWithDictionary:data];
        if (rootClass.type == 1) {
            
            [self.arrayHotCity removeAllObjects];
            
            for (DrivingCityListDMData *item in rootClass.data) {
                [self.arrayHotCity addObject:item.name];
                _openCityArray = rootClass.data;
            }
        }
        //    for (int i = 0; i < 3; i++) {
        //        DrivingCityListDMData *dmData = [DrivingCityListDMData new];
        //        dmData.name = @"测试";
        //        dmData.idField = 123456;
        //        [self.dataList addObject:dmData];
        //    }
        
        _hotCitySuccess = YES;
        if (_locationCitySuccess) {
            [self ininHeaderView];
        }
        
    } withFailure:^(id data) {
        [self obj_showTotasViewWithMes:@"网络错误"];
    }];
    
    
    //添加单击事件 取消键盘第一响应
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignFirstResponder:)];
//    tap.delegate = self;
//    [self.view addGestureRecognizer:tap];
    
}
- (void)resignFirstResponder:(UITapGestureRecognizer*)tap
{
    [_searchText resignFirstResponder];
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch

{
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//如果当前是tableView
  
        return NO;
        
    }
    
    return YES;
    
}

#pragma mark 搜索
- (void)dvvTextFieldTextChangeAction:(UITextField *)textField {
    [self filterContentForSearchText:textField.text];
}

- (void)dvvTextFieldDidEndEditingAction:(UITextField *)textField {
    [self filterContentForSearchText:textField.text];
}

- (void)setNavigationWithTitle:(NSString *)title
{
    //自定义导航栏
    UIView *customNavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    customNavView.backgroundColor = YBNavigationBarBgColor;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"navi_back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(16, 27, 30, 30);
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [customNavView addSubview:backBtn];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, customNavView.frame.size.width, customNavView.frame.size.height-20)];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text          = title;
    titleLab.textColor = [UIColor whiteColor];
    [customNavView addSubview:titleLab];
    
    
    [self.view addSubview:customNavView];
}

- (void)back:(UIButton*)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)ininHeaderView
{
    
    
    _tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 250)];
    _tableHeaderView.backgroundColor = [UIColor clearColor];
    
    
    //定位城市
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(16, 10, 160, 21)];
    title1.text = @"定位城市";
    title1.font = [UIFont systemFontOfSize:12];
    title1.textColor = [UIColor lightGrayColor];
    [_tableHeaderView addSubview:title1];
    
    _locatingCityGroupView = [[ButtonGroupView alloc]initWithFrame:CGRectMake(0, title1.frame.origin.y+title1.frame.size.height+10, _tableHeaderView.frame.size.width, 60)];
    _locatingCityGroupView.delegate = self;
    _locatingCityGroupView.columns = 3;
    _locatingCityGroupView.items = [self GetCityDataSoucre:_arrayLocatingCity];
    [_tableHeaderView addSubview:_locatingCityGroupView];
    
    
//    //常用城市
//
//    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(10, _locatingCityGroupView.frame.origin.y+_locatingCityGroupView.frame.size.height+10, 160, 21)];
//    title2.text = @"常用城市";
//    title2.font = [UIFont systemFontOfSize:15];
//    [_tableHeaderView addSubview:title2];
//    
//    
//    long rowHistorical = _arrayHistoricalCity.count/3;
//    if (_arrayHistoricalCity.count%3 > 0) {
//        rowHistorical += 1;
//    }
//    CGFloat hisViewHight = 45*rowHistorical;
//    _historicalCityGroupView = [[ButtonGroupView alloc]initWithFrame:CGRectMake(0, title2.frame.origin.y+title2.frame.size.height+10, _tableHeaderView.frame.size.width, hisViewHight)];
//    _historicalCityGroupView.backgroundColor = [UIColor clearColor];
//    _historicalCityGroupView.delegate = self;
//    _historicalCityGroupView.columns = 3;
//    _historicalCityGroupView.items = [self GetCityDataSoucre:_arrayHistoricalCity];
//    [_tableHeaderView addSubview:_historicalCityGroupView];
    
    //热门城市
    UILabel *title3 = [[UILabel alloc]initWithFrame:CGRectMake(16, _locatingCityGroupView.frame.origin.y+_locatingCityGroupView.frame.size.height+10, 160, 21)];
    title3.text = @"热门城市";
    title3.font = [UIFont systemFontOfSize:12];
    title3.textColor = [UIColor lightGrayColor];
    [_tableHeaderView addSubview:title3];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    lineView.frame = CGRectMake(16, CGRectGetMaxY(_locatingCityGroupView.frame) + 0, [UIScreen mainScreen].bounds.size.width - 16*2, 0.5);
    [_tableHeaderView addSubview:lineView];
    
    long row = _arrayHotCity.count/3;
    if (_arrayHotCity.count%3 > 0) {
        row += 1;
    }
    CGFloat hotViewHight = 60*row;
    _hotCityGroupView = [[ButtonGroupView alloc]initWithFrame:CGRectMake(0, title3.frame.origin.y+title3.frame.size.height+10, _tableHeaderView.frame.size.width, hotViewHight)];
    _hotCityGroupView.backgroundColor = [UIColor clearColor];
    _hotCityGroupView.delegate = self;
    _hotCityGroupView.columns = 3;
    _hotCityGroupView.items = [self GetCityDataSoucre:_arrayHotCity];
    [_tableHeaderView addSubview:_hotCityGroupView];
    
    
    _tableHeaderView.frame = CGRectMake(0, 0, _tableView.frame.size.width, _hotCityGroupView.frame.origin.y+_hotCityGroupView.frame.size.height);
    
    [DVVToast hideFromView:self.view];
    [self getCityData];
    [_tableView reloadData];
    // 显示出来控件
    _searchContentView.userInteractionEnabled = YES;
    [UIView animateWithDuration:0.3 animations:^{
        _tableView.alpha = 1;
        _searchContentView.alpha = 1;
    }];
//    [UIView animateWithDuration:0.3 animations:^{
        _tableView.tableHeaderView = _tableHeaderView;
//    }];
}

- (NSArray*)GetCityDataSoucre:(NSArray*)ary
{
    NSMutableArray *cityAry = [[NSMutableArray alloc]init];
    for (NSString*cityName in ary) {
        [cityAry addObject: [CityItem initWithTitleName:cityName]];
    }
    
    return cityAry;
}

#pragma mark - 获取城市数据
-(void)getCityData
{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"citydict"
                                                   ofType:@"plist"];
    self.cities = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    [_keys addObjectsFromArray:[[self.cities allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    
//    //添加热门城市
//    NSString *strHot = @"#";
//    [self.keys insertObject:strHot atIndex:0];
//    [self.cities setObject:_arrayHotCity forKey:strHot];
    
    NSArray *allValuesAry = [self.cities allValues];
    for (NSArray*oneAry in allValuesAry) {
        
        for (NSString *cityName in oneAry) {
           [_arrayCitys addObject:cityName];
        }
    }
    
    
    

}

#pragma mark - tableView
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 250, 30)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:14];
    
//    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 30, bgView.frame.size.width, 1)];
//    line.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    
    
    NSString *key = [_keys objectAtIndex:section];

    titleLabel.text = key;
//    [bgView addSubview:line];

    [bgView addSubview:titleLabel];
    
    return bgView;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    NSMutableArray *indexNumber = [NSMutableArray arrayWithArray:_keys];
//    NSString *strHot = @"#";
//    //添加搜索前的#号
//    [indexNumber insertObject:strHot atIndex:0];
    return indexNumber;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [_keys count];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
//    NSLog(@"title = %@",title);
    [self showTipsWithTitle:title];
    
    return index;
}

- (void)showTipsWithTitle:(NSString*)title
{
    
    //获取当前屏幕window
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //添加黑色透明背景
//    if (!_bgImageView) {
//        _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, window.frame.size.width, window.frame.size.height)];
//        _bgImageView.backgroundColor = [UIColor blackColor];
//        _bgImageView.alpha = 0.1;
//        [window addSubview:_bgImageView];
//    }
    if (!_tipsView) {
        //添加字母提示框
        _tipsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        _tipsView.center = window.center;
        _tipsView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:0.8];
        //设置提示框圆角
        _tipsView.layer.masksToBounds = YES;
        _tipsView.layer.cornerRadius  = _tipsView.frame.size.width/20;
        _tipsView.layer.borderColor   = [UIColor whiteColor].CGColor;
        _tipsView.layer.borderWidth   = 2;
        [window addSubview:_tipsView];
    }
    if (!_tipsLab) {
        //添加提示字母lable
        _tipsLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _tipsView.frame.size.width, _tipsView.frame.size.height)];
        //设置背景为透明
        _tipsLab.backgroundColor = [UIColor clearColor];
        _tipsLab.font = [UIFont boldSystemFontOfSize:50];
        _tipsLab.textAlignment = NSTextAlignmentCenter;
        
        [_tipsView addSubview:_tipsLab];
    }
   _tipsLab.text = title;//设置当前显示字母
    
//    [self performSelector:@selector(hiddenTipsView:) withObject:nil afterDelay:0.3];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self hiddenTipsView];
//    });
    
    
    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(hiddenTipsView) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
}

- (void)hiddenTipsView
{
    
    [UIView animateWithDuration:0.2 animations:^{
        _bgImageView.alpha = 0;
        _tipsView.alpha = 0;
    } completion:^(BOOL finished) {
        [_bgImageView removeFromSuperview];
        [_tipsView removeFromSuperview];
         _bgImageView = nil;
         _tipsLab     = nil;
         _tipsView    = nil;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *key = [_keys objectAtIndex:section];
    NSArray *citySection = [_cities objectForKey:key];
    return [citySection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_tableView respondsToSelector:@selector(setSectionIndexColor:)]) {
        _tableView.sectionIndexBackgroundColor = KSectionIndexBackgroundColor;  //修改索引试图未选中时的背景颜色
        _tableView.sectionIndexTrackingBackgroundColor = kSectionIndexTrackingBackgroundColor;//修改索引试图选中时的背景颜色
        _tableView.sectionIndexColor = kSectionIndexColor;//修改索引试图字体颜色
    }
    
    
    static NSString *CellIdentifier = @"Cell";
    
    NSString *key = [_keys objectAtIndex:indexPath.section];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.textLabel setTextColor:[UIColor colorWithWhite:0 alpha:0.7]];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    cell.textLabel.text = [[_cities objectForKey:key] objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *key = [_keys objectAtIndex:indexPath.section];
    NSString *cityName = [[_cities objectForKey:key] objectAtIndex:indexPath.row];
//    if ([_delegate respondsToSelector:@selector(didClickedWithCityName:)]) {
//        [_delegate didClickedWithCityName:cityName];
//        
//    }
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self checkCityWithName:cityName];
    
}

#pragma mark 按钮的点击事件
-(void)ButtonGroupView:(ButtonGroupView *)buttonGroupView didClickedItem:(CityButton *)item
{
    [self checkCityWithName:item.cityItem.titleName];
}

#pragma mark 检查选择的城市是否有子城市
- (void)checkCityWithName:(NSString *)cityName {
    
    BOOL foundFlage = NO;
    NSInteger cityID = 0;
    
    // 获取点击城市的ID（在开通的城市列表中搜索）
    for (DrivingCityListDMData *dmData in _openCityArray) {
        
        NSString *tempName = dmData.name.copy;
        if ([tempName hasSuffix:@"市"]) {
            tempName = [tempName substringToIndex:tempName.length - 1];
        }
        NSLog(@"%@ %@", tempName, dmData.name);
        if ([dmData.name isEqualToString:cityName] || [tempName isEqualToString:cityName]) {
            foundFlage = YES;
            cityID = dmData.ID;
        }
    }
    
    if (foundFlage) {
        // 检查此城市是否可以选择区域
        NSString *url = [NSString stringWithFormat:BASEURL, @"getchildopencity"];
        NSDictionary *dict = @{ @"cityid": [NSString stringWithFormat:@"%lu", (long)cityID] };
        
        [DVVToast showFromView:self.view OffSetY:-64];
        [JENetwoking startDownLoadWithUrl:url postParam:dict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
            
            [DVVToast hideFromView:self.view];
//            NSLog(@"%@", data);
            
            DVVCityListDMRootClass *dmRoot = [DVVCityListDMRootClass yy_modelWithJSON:data];
            
            if (0 == dmRoot.type) {
                // 出错
                [self obj_showTotasViewWithMes:@"查询详细信息出错"];
            }else {
                NSMutableArray *array = [NSMutableArray array];
                
                for (NSDictionary *dict in dmRoot.data) {
                    DVVCityListDMData *dmData = [DVVCityListDMData yy_modelWithDictionary:dict];
                    [array addObject:dmData];
                }
                
                //                for (int i = 0; i < 10; i++) {
                //                    DVVCityListDMData *dmData = [DVVCityListDMData new];
                //                    dmData.ID = 235 + i;
                //                    dmData.name = [NSString stringWithFormat:@"测试名%i", i];
                //                    [array addObject:dmData];
                //                }
                
                if (!array.count) {
                    // 没有子城市（直接返回城市名）
                    [self successWithCityName:cityName];
                }else {
                    // 把城市名添加到区里
                    DVVCityListDMData *dmData = [DVVCityListDMData new];
                    dmData.name = cityName;
                    [array insertObject:dmData atIndex:0];
                    
                    // 有子城市（返回选择的区名）
                    DVVSubCityView *subView = [DVVSubCityView new];
                    subView.delegate = self;
                    subView.dataArray = array;
                    [subView show];
                }
            }
            
        } withFailure:^(id data) {
            [DVVToast hideFromView:self.view];
            [self obj_showTotasViewWithMes:@"网络错误"];
        }];
    }else {
        if (![cityName isEqualToString:@"定位失败"]) {
            [self obj_showTotasViewWithMes:@"此城市暂未开通业务"];
        }
    }

}

- (void)dvvSubCityView:(DVVSubCityView *)dvvSubCityView didSelectItemWithCityName:(NSString *)cityName {
    
//    NSLog(@"cityName: %@", cityName);
    
    [self successWithCityName:cityName];
}

- (void)successWithCityName:(NSString *)cityName {
    
    if ([_delegate respondsToSelector:@selector(didClickedWithCityName:)]) {
        
        [_delegate didClickedWithCityName:cityName];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


NSInteger cityNameSort(id str1, id str2, void *context)
{
    NSString *string1 = (NSString*)str1;
    NSString *string2 = (NSString*)str2;
    
    return  [string1 localizedCompare:string2];
}
/**
 *  通过搜索条件过滤得到搜索结果
 *
 *  @param searchText 关键词
 *  @param scope      范围
 */
- (void)filterContentForSearchText:(NSString*)searchText {
    
    if (searchText.length > 0) {
        _searchResultDic = nil;
        _searchResultDic = [[NSMutableDictionary alloc]init];
        
        //搜索数组中是否含有关键字
        NSArray *resultAry  = [ZYPinYinSearch searchWithOriginalArray:_arrayCitys andSearchText:searchText andSearchByPropertyName:@""];
        //     NSLog(@"搜索结果:%@",resultAry) ;
        
        for (NSString*city in resultAry) {
            //获取字符串拼音首字母并转为大写
            NSString *pinYinHead = [PinYinForObjc chineseConvertToPinYinHead:city].uppercaseString;
            NSString *firstHeadPinYin = [pinYinHead substringToIndex:1]; //拿到字符串第一个字的首字母
            //        NSLog(@"pinYin = %@",firstHeadPinYin);
            
            
            NSMutableArray *cityAry = [NSMutableArray arrayWithArray:[_searchResultDic objectForKey:firstHeadPinYin]]; //取出首字母数组
            
            if (cityAry != nil) {
                
                [cityAry addObject:city];
                
                NSArray *sortCityArr = [cityAry sortedArrayUsingFunction:cityNameSort context:NULL];
                [_searchResultDic setObject:sortCityArr forKey:firstHeadPinYin];
                
            }else
            {
                cityAry= [[NSMutableArray alloc]init];
                [cityAry addObject:city];
                NSArray *sortCityArr = [cityAry sortedArrayUsingFunction:cityNameSort context:NULL];
                [_searchResultDic setObject:sortCityArr forKey:firstHeadPinYin];
            }
            
            
            
        }
        //    NSLog(@"dic = %@",dic);

        if (resultAry.count>0) {
            _cities = nil;
            _cities = _searchResultDic;
            [_keys removeAllObjects];
            //按字母升序排列
            [_keys addObjectsFromArray:[[self.cities allKeys] sortedArrayUsingSelector:@selector(compare:)]] ;
            _tableView.tableHeaderView = nil;
            [_tableView reloadData];
        }

    }else
    {
        //当字符串清空时 回到初始状态
        _cities = nil;
         [_keys removeAllObjects];
        [_arrayCitys removeAllObjects];
        [self getCityData];
        _tableView.tableHeaderView = _tableHeaderView;
        [_tableView reloadData];
    }
    
   
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
