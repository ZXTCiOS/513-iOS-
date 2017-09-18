//
//  ModifypasswordVC.m
//  Videoofthefamily
//
//  Created by 王俊钢 on 2017/9/13.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "ModifypasswordVC.h"
#import "LCMD5Tool.h"


@interface ModifypasswordVC ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *passwordtext0;
@property (nonatomic,strong) UITextField *passwordtext1;
@property (nonatomic,strong) UITextField *passwordtext2;
@property (nonatomic,strong) UIView *line0;
@property (nonatomic,strong) UIView *line1;
@property (nonatomic,strong) UIView *line2;
@property (nonatomic,strong) UIButton *submitBtn;
@end

@implementation ModifypasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改密码";
    [self.view addSubview:self.passwordtext0];
    [self.view addSubview:self.passwordtext1];
    [self.view addSubview:self.passwordtext2];
    [self.view addSubview:self.line0];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.line2];
    [self.view addSubview:self.submitBtn];
    
    [self setuplayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.passwordtext0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(35*WIDTH_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-35*WIDTH_SCALE);
        make.top.equalTo(weakSelf.view).with.offset(80*HEIGHT_SCALE);
        make.height.mas_offset(30*HEIGHT_SCALE);
    }];
    [weakSelf.passwordtext1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.passwordtext0);
        make.right.equalTo(weakSelf.passwordtext0);
        make.top.equalTo(weakSelf.passwordtext0.mas_bottom).with.offset(20*HEIGHT_SCALE);
        make.height.mas_offset(30*HEIGHT_SCALE);
    }];
    [weakSelf.passwordtext2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.passwordtext1);
        make.right.equalTo(weakSelf.passwordtext1);
        make.top.equalTo(weakSelf.passwordtext1.mas_bottom).with.offset(20*HEIGHT_SCALE);
        make.height.mas_offset(30*HEIGHT_SCALE);
    }];
    [weakSelf.line0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.passwordtext0).with.offset(26);
        make.right.equalTo(weakSelf.passwordtext0);
        make.height.mas_offset(1);
        make.top.equalTo(weakSelf.passwordtext0.mas_bottom);
    }];
    [weakSelf.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.line0);
        make.right.equalTo(weakSelf.line0);
        make.height.mas_offset(1);
        make.top.equalTo(weakSelf.passwordtext1.mas_bottom);
    }];
    [weakSelf.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.line0);
        make.right.equalTo(weakSelf.line0);
        make.height.mas_offset(1);
        make.top.equalTo(weakSelf.passwordtext2.mas_bottom);
    }];
    [weakSelf.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(35*WIDTH_SCALE);
        make.top.equalTo(weakSelf.line2).with.offset(50*HEIGHT_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-35*WIDTH_SCALE);
        make.height.mas_offset(45*HEIGHT_SCALE);
    }];
}

#pragma mark - getters

-(UITextField *)passwordtext0
{
    if(!_passwordtext0)
    {
        _passwordtext0 = [[UITextField alloc] init];
        _passwordtext0.delegate = self;
        _passwordtext0.placeholder = @"请输入原密码 长度(6-16位)";
        UIImageView *imageViewPwd=[[UIImageView alloc]initWithFrame:CGRectMake(-32, 0, 24, 24)];
        imageViewPwd.image=[UIImage imageNamed:@"psw"];
        _passwordtext0.leftView=imageViewPwd;
        _passwordtext0.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
        _passwordtext0.secureTextEntry = YES;
    }
    return _passwordtext0;
}


-(UITextField *)passwordtext1
{
    if(!_passwordtext1)
    {
        _passwordtext1 = [[UITextField alloc] init];
        _passwordtext1.delegate = self;
        _passwordtext1.placeholder = @"请输入新密码 长度(6-16位)";
        UIImageView *imageViewPwd=[[UIImageView alloc]initWithFrame:CGRectMake(-32, 0, 24, 24)];
        imageViewPwd.image=[UIImage imageNamed:@"psw"];
        _passwordtext1.leftView=imageViewPwd;
        _passwordtext1.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
        _passwordtext1.secureTextEntry = YES;
    }
    return _passwordtext1;
}

-(UITextField *)passwordtext2
{
    if(!_passwordtext2)
    {
        _passwordtext2 = [[UITextField alloc] init];
        _passwordtext2.delegate = self;
        _passwordtext2.placeholder = @"请确认新密码 长度(6-16位)";
        UIImageView *imageViewPwd=[[UIImageView alloc]initWithFrame:CGRectMake(-32, 0, 24, 24)];
        imageViewPwd.image=[UIImage imageNamed:@"psw"];
        _passwordtext2.leftView=imageViewPwd;
        _passwordtext2.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
        _passwordtext2.secureTextEntry = YES;
    }
    return _passwordtext2;
}

-(UIView *)line0
{
    if(!_line0)
    {
        _line0 = [[UIView alloc] init];
        _line0.backgroundColor = [UIColor colorWithHexString:@"EBEBEB"];
    }
    return _line0;
}

-(UIView *)line1
{
    if(!_line1)
    {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = [UIColor colorWithHexString:@"EBEBEB"];
    }
    return _line1;
}

-(UIView *)line2
{
    if(!_line2)
    {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = [UIColor colorWithHexString:@"EBEBEB"];
    }
    return _line2;
}

-(UIButton *)submitBtn
{
    if(!_submitBtn)
    {
        _submitBtn = [[UIButton alloc] init];
        _submitBtn.backgroundColor = systemColor;
        [_submitBtn setTitle:@"保存修改" forState:normal];
        [_submitBtn setTitleColor:[UIColor colorWithHexString:@"F5F5F5"] forState:normal];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 5;
        [_submitBtn addTarget:self action:@selector(submitbtnclick) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _submitBtn;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.passwordtext0 resignFirstResponder];
    [self.passwordtext1 resignFirstResponder];
    [self.passwordtext2 resignFirstResponder];
}

#pragma mark - 实现方法

-(void)submitbtnclick
{
    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
    NSString *userid = [userdefat objectForKey:user_uid];
    NSString *token = [userdefat objectForKey:user_token];
    NSString *password = @"";
    

    NSLog(@"yuanmima---%@",self.yuanmima);
    
    NSString *pass1 = @"";
    if (self.passwordtext0.text.length==0) {
        pass1 = @"";
    }
    else
    {
        pass1 = [LCMD5Tool MD5ForLower32Bate:self.passwordtext0.text];
    }
    NSString *pass2 = @"";
    if (self.passwordtext1.text.length==0) {
        pass2 = @"";
    }
    else
    {
        pass2 = self.passwordtext1.text;
    }
    NSString *pass3 = @"";
    if (self.passwordtext2.text.length==0) {
        pass3 = @"";
    }
    else
    {
        pass3 = self.passwordtext2.text;
    }
    
    if ([pass1 isEqualToString:self.yuanmima]) {
        if ([pass2 isEqualToString:pass3]) {
            password = pass2;
            NSDictionary *para = @{@"userid":userid,@"token":token,@"password":password};
            
            [CLNetworkingManager postNetworkRequestWithUrlString:post_edit parameters:para isCache:NO succeed:^(id data) {
                if ([[data objectForKey:@"code"] intValue]==200) {
                    [MBProgressHUD showSuccess:@"修改成功"];
                }
                else
                {
                    [MBProgressHUD showSuccess:@"请检查输入"];
                }
            } fail:^(NSError *error) {
                [MBProgressHUD showSuccess:@"网络错误"];
            }];
        }
        else
        {
            [MBProgressHUD showSuccess:@"两次新密码输入不一致"];
        }
        
        
    }
    else
    {
        [MBProgressHUD showSuccess:@"原密码错误"];
    }
    
    
}

#pragma mark - 控制屏幕旋转方法
//是否自动旋转,返回YES可以自动旋转,返回NO禁止旋转
- (BOOL)shouldAutorotate{
    return NO;
}
//返回支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
//由模态推出的视图控制器 优先支持的屏幕方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}
@end
