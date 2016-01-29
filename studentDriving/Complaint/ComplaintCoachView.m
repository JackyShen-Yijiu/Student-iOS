//
//  ComplaintCoachView.m
//  studentDriving
//
//  Created by 大威 on 16/1/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "ComplaintCoachView.h"
#import "ComplaintCoachListController.h"
#import "DVVImagePickerControllerManager.h"

@interface ComplaintCoachView ()

@property (nonatomic, assign) BOOL complaintWay;

@property (nonatomic, assign) NSUInteger photoButtonTag;

@property (nonatomic, strong) UIImage *image_1;
@property (nonatomic, strong) UIImage *image_2;

@end

@implementation ComplaintCoachView

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray  *xibArray = [[NSBundle mainBundle]loadNibNamed:@"ComplaintCoachView" owner:self options:nil];
        ComplaintCoachView *view=xibArray.firstObject;
        self = view;
        
        [_anonymousButton setImage:[UIImage imageNamed:@"cancelSelect_click"] forState:UIControlStateSelected];
        _anonymousButton.selected = YES;
        [_realNameButton setImage:[UIImage imageNamed:@"cancelSelect_click"] forState:UIControlStateSelected];
        _textView.delegate = self;
    }
    return self;
}

- (void)textViewDidChange:(UITextView *)textView {
    
    if (0 == textView.text.length) {
        self.placeholderLabel.hidden = NO;
    }else {
        self.placeholderLabel.hidden = YES;
    }
}
- (IBAction)anonymousButtonAction:(UIButton *)sender {
    _complaintWay = 0;
    _realNameButton.selected = NO;
    sender.selected = YES;
}
- (IBAction)realNameButton:(UIButton *)sender {
    _complaintWay = 1;
    _anonymousButton.selected = NO;
    sender.selected = YES;
}


- (IBAction)selectCoachButtonAction:(UIButton *)sender {
    
    ComplaintCoachListController *listVC = [ComplaintCoachListController new];
    listVC.coachNameLabel = _coachNameLabel;
    [_superController.navigationController pushViewController:listVC animated:YES];
}
- (IBAction)photo_1_buttonAction:(UIButton *)sender {
    
    _photoButtonTag = 1;
    [DVVImagePickerControllerManager showImagePickerController:_superController delegate:self];
}
- (IBAction)photo_2_buttonAction:(UIButton *)sender {
    
    _photoButtonTag = 2;
    [DVVImagePickerControllerManager showImagePickerController:_superController delegate:self];
}

- (IBAction)okButtonAction:(UIButton *)sender {
    
    if ([_coachNameLabel.text isEqualToString:@"点击选择教练"]) {
        [self obj_showTotasViewWithMes:@"请选择要投诉的教练"];
        return ;
    }
    if (!_textView.text.length) {
        [self obj_showTotasViewWithMes:@"请输入投诉原因"];
        return ;
    }
    if (_image_1) {
        
        NSData *data = UIImageJPEGRepresentation(_image_1, 0.5);
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSData *data_2 = [string dataUsingEncoding:NSUTF8StringEncoding];
        _image_2 = [UIImage imageWithData:data_2];
        [_photo_2_button setBackgroundImage:_image_2 forState:UIControlStateNormal];
    }
}

#pragma mark - delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *photoImage = [info valueForKey:UIImagePickerControllerEditedImage];
    
    if (1 == _photoButtonTag) {
        _image_1 = photoImage;
        [_photo_1_button setBackgroundImage:photoImage forState:UIControlStateNormal];
    }else {
        _image_2 = photoImage;
        [_photo_2_button setBackgroundImage:photoImage forState:UIControlStateNormal];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
