//
//  DiscountShopModel.h
//  studentDriving
//
//  Created by ytzhang on 15/12/31.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscountShopModel : NSObject
@property (nonatomic,strong) NSString *productid;
@property (nonatomic,strong) NSString *productname;
@property (nonatomic,assign) int  productprice;
@property (nonatomic,strong) NSString *productimg;
@property (nonatomic,strong) NSString *productdesc;
@property (nonatomic,assign) int viewcount;
@property (nonatomic,assign) int buycount;
@property (nonatomic,strong) NSString *detailsimg;

@property (nonatomic,assign) int is_scanconsumption;

@property (nonatomic,strong) NSString *detailurl;

@property (nonatomic,strong) NSString *cityname;

@property (nonatomic,strong) NSString *merchantid; 

@property (nonatomic,strong) NSString *address;

@property (nonatomic,strong) NSString *county; // 区

@property (nonatomic,strong) NSString *distinct; // 距离
@end
