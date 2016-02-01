//
//  JEPhotoPickManger.m
//  BlackCat
//
//  Created by bestseller on 15/9/18.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "JEPhotoPickManger.h"
#import "PFActionSheetView.h"
#import "ToolHeader.h"
#import <AVFoundation/AVFoundation.h>

@interface JEPhotoPickManger ()
@property (weak, nonatomic) UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate> *fromVc;

@end
@implementation JEPhotoPickManger


+ (void)pickPhotofromController:(UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>*)fromController{
    
    [PFActionSheetView showAlertWithTitle:nil message:nil cancelButtonTitle:@"取消" otherButtonTitles:@[@"拍照",@"从相册选取"] withVc:fromController completion:^(NSUInteger selectedOtherButtonIndex) {
        
        if (selectedOtherButtonIndex == 0) {
            
            
            // 如果用户没有打开相机，则提示用户去设置中打开
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (authStatus == AVAuthorizationStatusAuthorized) {
                // 已经授权
                
            }else {
                // 没有授权
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"相机不可用" message:@"请在设置中开启相机服务" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
                [alertView show];
                
                return ;
            }
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
                DYNSLog(@"camera");
                
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.allowsEditing = YES;
                picker.delegate = fromController;
                UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypeCamera;
                if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    type = UIImagePickerControllerSourceTypePhotoLibrary;
                }
                picker.sourceType = type;

                picker.navigationBar.barTintColor = fromController.navigationController.navigationBar.barTintColor;
                picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                             NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};

                [fromController presentViewController:picker animated:YES completion:nil];
                
            }
            
        }else if (selectedOtherButtonIndex == 1) {
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {

                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.allowsEditing = YES;
                picker.delegate = fromController;
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
                picker.navigationBar.barTintColor = fromController.navigationController.navigationBar.barTintColor;
                picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                             NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
                [fromController presentViewController:picker animated:YES completion:nil];

                //0x00007ff7f587e0a0
            }
        }
           
    }];
    
}

@end
