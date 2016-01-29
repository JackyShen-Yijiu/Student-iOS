//
//  DVVImagePickerControllerManager.m
//  studentDriving
//
//  Created by 大威 on 16/1/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVImagePickerControllerManager.h"
#import "PFActionSheetView.h"
#import <AVFoundation/AVFoundation.h>

@implementation DVVImagePickerControllerManager

+ (void)showImagePickerController:(UIViewController *)fromController delegate:(id)delegate {
    
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
                picker.delegate = delegate;
                UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypeCamera;
                if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    type = UIImagePickerControllerSourceTypePhotoLibrary;
                }
                picker.sourceType = type;
                
                picker.navigationBar.barTintColor = fromController.navigationController.navigationBar.barTintColor;
//                picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
//                                                             NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
                picker.navigationBar.titleTextAttributes = fromController.navigationController.navigationBar.titleTextAttributes;
                
                [fromController presentViewController:picker animated:YES completion:nil];
                
            }
            
        }else if (selectedOtherButtonIndex == 1) {
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.allowsEditing = YES;
                picker.delegate = delegate;
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
                picker.navigationBar.barTintColor = fromController.navigationController.navigationBar.barTintColor;
//                picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
//                                                             NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
                picker.navigationBar.titleTextAttributes = fromController.navigationController.navigationBar.titleTextAttributes;
                [fromController presentViewController:picker animated:YES completion:nil];
                
                //0x00007ff7f587e0a0
            }
        }
        
    }];
}

@end
