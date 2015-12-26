#import "ModificationView.h"
#import <Masonry/Masonry.h>

@interface ModificationView ()

@property (strong, nonatomic) UIButton *accomplishButton;
@property (strong, nonatomic) UITextField *passWordTextFild;
@property (strong, nonatomic) UITextField *affirmTextFild;
@end

@implementation ModificationView

- (UIButton *)accomplishButton{
    if (_accomplishButton == nil) {
        _accomplishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _accomplishButton.backgroundColor = [UIColor yellowColor];
        [_accomplishButton addTarget:self action:@selector(dealNext:) forControlEvents:UIControlEventTouchUpInside];
        [_accomplishButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_accomplishButton setTitle:@"完成" forState:UIControlStateNormal];
        
    }
    return _accomplishButton;
}

- (UITextField *)passWordTextFild{
    if (_passWordTextFild == nil) {
        _passWordTextFild = [[UITextField alloc]init];
        _passWordTextFild.tag = 105;
        _passWordTextFild.placeholder = @"请输入新的密码";
        _passWordTextFild.layer.borderColor = [UIColor blackColor].CGColor;
        _passWordTextFild.layer.borderWidth = 0.5;
        _passWordTextFild.layer.cornerRadius = 5;
    }
    return _passWordTextFild;
}

- (UITextField *)affirmTextFild{
    if (_affirmTextFild == nil) {
        _affirmTextFild = [[UITextField alloc]init];
        _affirmTextFild.tag = 106;
        _affirmTextFild.placeholder = @"确认新密码";
        _affirmTextFild.layer.borderColor = [UIColor blackColor].CGColor;
        _affirmTextFild.layer.borderWidth = 0.5;
        _affirmTextFild.layer.cornerRadius = 5;
    }
    return _affirmTextFild;
}


- (id)initWithFrame:(CGRect)frame With:(id<ModificationViewDelegate>)delegate{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.delegate = delegate;
        
        [self createUI];
    }
    return self;
}

- (id)initWith:(id<ModificationViewDelegate>)delegate {
    return [self initWithFrame:CGRectMake(0, 0, 0, 0)With:delegate];
}
- (void)createUI {
    [self addSubview:self.passWordTextFild];
    [self addSubview:self.accomplishButton];
    [self addSubview:self.affirmTextFild];
    
    [self.passWordTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(20);
        make.right.mas_equalTo(self.mas_right).with.offset(-20);
        make.top.mas_equalTo(self.mas_top).with.offset(100);
        make.height.mas_equalTo(@40);
    }];
    
    [self.affirmTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(20);
        make.right.mas_equalTo(self.mas_right).with.offset(-20);
        make.top.mas_equalTo(self.passWordTextFild.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@40);
    }];
    
    [self.accomplishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(20);
        make.right.mas_equalTo(self.mas_right).with.offset(-20);
        make.top.mas_equalTo(self.affirmTextFild.mas_bottom).with.offset(30);
        make.height.mas_equalTo(@40);
    }];
    
}

- (void)dealNext:(UIButton *)sender {
    
    
}
@end