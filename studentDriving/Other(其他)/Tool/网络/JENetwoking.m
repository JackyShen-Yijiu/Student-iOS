//
//  JENetwoking.m
//  BlackCat
//
//  Created by bestseller on 15/9/24.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "JENetwoking.h"
#import <UIKit/UIKit.h>
#import "ToolHeader.h"

@interface JENetwoking ()
@property (copy, nonatomic) NSString *urlString;
@property (assign, nonatomic) JENetworkingRequestMethod method;
@property (weak, nonatomic) id<JENetwokingDelegate>delegate;
@end
@implementation JENetwoking
//大量数据下载
+ (instancetype)initWithUrl:(NSString *)urlString
       WithMethod:(JENetworkingRequestMethod)method
     WithDelegate:(id<JENetwokingDelegate>)delegate {
    DYNSLog(@"data ");

    JENetwoking *networking = [[self alloc] init];
    networking.urlString = urlString;
    networking.method = method;
    networking.delegate = delegate;
    [networking startDownLoad];
    return networking;
}

- (void)startDownLoad {
    
    if (self.method == JENetworkingRequestMethodGet) {

        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer.timeoutInterval = 30;
        manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
        [manager GET:self.urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            if (responseObject == nil) {
                ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
                [alertView show];
                return;
            }
            if ([_delegate respondsToSelector:@selector(jeNetworkingCallBackData:)]) {
                [_delegate jeNetworkingCallBackData:responseObject];
            }
            
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
            [alertView show];
        }];
    }
    
}
//简单获取回调用于按钮点击上传图片，点击发送消息
+ (void)startDownLoadWithUrl:(NSString *)urlString
                   postParam:(id)param
                  WithMethod:(JENetworkingRequestMethod)method
              withCompletion:(Completion)completion {
    
    
    Completion _completion = [completion copy];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    manager.requestSerializer.timeoutInterval = 30.0f;
    if (method == JENetworkingRequestMethodGet) {
        if ([AcountManager manager].userToken && [AcountManager manager].userToken.length) {
            [manager.requestSerializer setValue:[AcountManager manager].userToken forHTTPHeaderField:@"authorization"];
        }
        [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            
            NSLog(@"JENetworkingRequestMethodGet urlString:%@ param:%@ responseObject:%@",urlString,param,responseObject);

            if (_completion) {
                _completion(responseObject);
            }
            if (responseObject == nil) {
                ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
                [alertView show];
                return ;
            }
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            if (_completion) {
                _completion(nil);
            }
            ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
            [alertView show];
        }];
    }else if (method == JENetworkingRequestMethodPost) {
        NSAssert(param != nil, @"param 不能为空");
        if ([AcountManager manager].userToken) {
            [manager.requestSerializer setValue:[AcountManager manager].userToken forHTTPHeaderField:@"authorization"];
        }

        [manager POST:urlString parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {

            NSLog(@"JENetworkingRequestMethodPost urlString:%@ param:%@ responseObject:%@",urlString,param,responseObject);

            if (_completion) {
                _completion(responseObject);
            }
            if (responseObject == nil) {
                ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
                [alertView show];
                return ;
            }
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            DYNSLog(@"error = %@",error);
            ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
            [alertView show];
        }];
        
    }else if (method == JENetworkingRequestMethodPut) {
        
        if ([AcountManager manager].userToken) {
            [manager.requestSerializer setValue:[AcountManager manager].userToken forHTTPHeaderField:@"authorization"];
        }
        DYNSLog(@"token = %@",manager.requestSerializer.HTTPRequestHeaders);
        
        [manager PUT:urlString parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            
            NSLog(@"JENetworkingRequestMethodPut urlString:%@ param:%@ responseObject:%@",urlString,param,responseObject);

            if (_completion) {
                _completion(responseObject);
            }
            if (responseObject == nil) {
                ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
                [alertView show];
                return ;
            }
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
            [alertView show];
            if (_completion) {
                _completion(nil);
            }
            
        }];
    }else if (method == JENetworkingRequestMethodDelete) {
        
        if ([AcountManager manager].userToken) {
            [manager.requestSerializer setValue:[AcountManager manager].userToken forHTTPHeaderField:@"authorization"];
        }
        
        [manager DELETE:urlString parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            
            NSLog(@"JENetworkingRequestMethodDelete urlString:%@ param:%@ responseObject:%@",urlString,param,responseObject);

            if (_completion) {
                _completion(responseObject);
            }
            if (responseObject == nil) {
                ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
                [alertView show];
                return ;
            }
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
            [alertView show];
            if (_completion) {
                _completion(nil);
            }
            
        }];
    }
}

+ (void)startDownLoadWithUrl:(NSString *)urlString
                   postParam:(id)param
                  WithMethod:(JENetworkingRequestMethod)method
              withCompletion:(Completion)completion withFailure:(Failure)failure {
    Completion _completion = [completion copy];
    
    Failure _failure = [failure copy];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    manager.requestSerializer.timeoutInterval = 30.0f;
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"application/x-javascript",@"text/plain",@"image/gif", @"image/png",nil];
    
    if (method == JENetworkingRequestMethodGet) {
        
        DYNSLog(@"token = %@",[AcountManager manager].userToken);
        if ([AcountManager manager].userToken && [AcountManager manager].userToken.length) {
            [manager.requestSerializer setValue:[AcountManager manager].userToken forHTTPHeaderField:@"authorization"];
        
        }else {
            [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"authorization"];
        }
        [manager GET:urlString parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            
            NSLog(@"JENetworkingRequestMethodGet urlString:%@ param:%@ responseObject:%@",urlString,param,responseObject);
            
            if (responseObject == nil) {
                ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"没有数据"];
                [alertView show];
                return ;
            }
            if (_completion) {
                _completion(responseObject);
            }
            
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            
            DYNSLog(@"error = %@",error);
            ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
            [alertView show];
            _failure(error);
            
        }];
        
    }else if (method == JENetworkingRequestMethodPost) {
        
        NSAssert(param != nil, @"param 不能为空");
        if ([AcountManager manager].userToken && [AcountManager manager].userToken.length) {
            [manager.requestSerializer setValue:[AcountManager manager].userToken forHTTPHeaderField:@"authorization"];
            
        }else {
            [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"authorization"];
        }
        DYNSLog(@"token = %@",manager.requestSerializer.HTTPRequestHeaders);
        
        [manager POST:urlString parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {

            NSLog(@"JENetworkingRequestMethodPost urlString:%@ param:%@ responseObject:%@",urlString,param,responseObject);

            if (responseObject == nil) {
                ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
                [alertView show];
                return ;
            }
            if (_completion) {
                _completion(responseObject);
            }
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            DYNSLog(@"error = %@",error);
            _failure(error);

            ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
            [alertView show];
        }];
        
    }else if (method == JENetworkingRequestMethodPut) {
        
        if ([AcountManager manager].userToken) {
            [manager.requestSerializer setValue:[AcountManager manager].userToken forHTTPHeaderField:@"authorization"];
        }
        DYNSLog(@"token = %@",manager.requestSerializer.HTTPRequestHeaders);
        
        [manager PUT:urlString parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {

            NSLog(@"JENetworkingRequestMethodPut urlString:%@ param:%@ responseObject:%@",urlString,param,responseObject);

            if (responseObject == nil) {
                ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
                [alertView show];
                return ;
            }
            if (_completion) {
                _completion(responseObject);
            }
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            DYNSLog(@"error = %@",error);
            _failure(error);

            ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
            [alertView show];
            
        }];
    }else if (method == JENetworkingRequestMethodDelete) {
        
        if ([AcountManager manager].userToken) {
            [manager.requestSerializer setValue:[AcountManager manager].userToken forHTTPHeaderField:@"authorization"];
        }
        DYNSLog(@"token = %@",manager.requestSerializer.HTTPRequestHeaders);
        
        [manager DELETE:urlString parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {

            NSLog(@"JENetworkingRequestMethodPut urlString:%@ param:%@ responseObject:%@",urlString,param,responseObject);

            if (responseObject == nil) {
                ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
                [alertView show];
                return ;
            }
            if (_completion) {
                _completion(responseObject);
            }
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            DYNSLog(@"error = %@",error);
            _failure(error);

            ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
            [alertView show];
            
        }];
    }
}

@end
