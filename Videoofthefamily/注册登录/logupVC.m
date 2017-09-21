//
//  logupVC.m
//  Videoofthefamily
//
//  Created by 王俊钢 on 2017/9/13.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "logupVC.h"
#import "NNValidationView.h"
#import "GetUUID.h"
#import "homeVC.h"

@interface logupVC ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *accounttext;
@property (nonatomic,strong) UITextField *passwordtext1;
@property (nonatomic,strong) UITextField *passwordtext2;
@property (nonatomic,strong) UITextField *valuetext;
@property (nonatomic,strong) NNValidationView *testView;
@property (nonatomic,strong) UIButton *submitBtn;
@property (nonatomic,strong) UIView *line0;
@property (nonatomic,strong) UIView *line1;
@property (nonatomic,strong) UIView *line2;
@property (nonatomic,strong) UIView *line3;

@property (nonatomic,strong) NSString *textstr;

@property (nonatomic,strong) GetUUID *getid;

@property (nonatomic,strong) UILabel *testlab;
@end

@implementation logupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"快速注册";
    [self.view addSubview:self.accounttext];
    [self.view addSubview:self.passwordtext1];
    [self.view addSubview:self.passwordtext2];
    [self.view addSubview:self.valuetext];
    [self.view addSubview:self.testView];
    [self.view addSubview:self.line0];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.line2];
    [self.view addSubview:self.line3];
    [self.view addSubview:self.submitBtn];
    [self.view addSubview:self.testlab];
    [self setuplayout];
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.accounttext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).offset(35*WIDTH_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-35*WIDTH_SCALE);
        make.top.equalTo(weakSelf.view).with.offset(153*HEIGHT_SCALE);
        make.height.mas_offset(30*HEIGHT_SCALE);
    }];
    [weakSelf.passwordtext1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.accounttext);
        make.right.equalTo(weakSelf.accounttext);
        make.top.equalTo(weakSelf.accounttext.mas_bottom).with.offset(30*HEIGHT_SCALE);
        make.height.mas_offset(30*HEIGHT_SCALE);
    }];
    [weakSelf.passwordtext2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.passwordtext1);
        make.right.equalTo(weakSelf.passwordtext1);
        make.top.equalTo(weakSelf.passwordtext1.mas_bottom).with.offset(30*HEIGHT_SCALE);
        make.height.mas_offset(30*HEIGHT_SCALE);
    }];
    [weakSelf.valuetext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.passwordtext2);
        make.top.equalTo(weakSelf.passwordtext2.mas_bottom).with.offset(30*HEIGHT_SCALE);
        make.height.mas_offset(30*HEIGHT_SCALE);
        make.width.mas_offset(220*WIDTH_SCALE);
    }];
    [weakSelf.testView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.valuetext.mas_right).with.offset(5*WIDTH_SCALE);
        make.right.equalTo(weakSelf.passwordtext2);
        make.height.mas_offset(30*HEIGHT_SCALE);
        make.top.equalTo(weakSelf.passwordtext2.mas_bottom).with.offset(25*HEIGHT_SCALE);
    }];
    [weakSelf.line0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.accounttext).with.offset(24);
        make.right.equalTo(weakSelf.accounttext);
        make.height.mas_offset(1);
        make.top.equalTo(weakSelf.accounttext.mas_bottom).with.offset(1);
    }];
    [weakSelf.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.line0);
        make.right.equalTo(weakSelf.line0);
        make.height.mas_offset(1);
        make.top.equalTo(weakSelf.passwordtext1.mas_bottom).with.offset(1);
    }];
    [weakSelf.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.line0);
        make.right.equalTo(weakSelf.line0);
        make.height.mas_offset(1);
        make.top.equalTo(weakSelf.passwordtext2.mas_bottom).with.offset(1);
    }];
    [weakSelf.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.line0);
        make.right.equalTo(weakSelf.line0);
        make.height.mas_offset(1);
        make.top.equalTo(weakSelf.valuetext.mas_bottom).with.offset(1);
    }];
    [weakSelf.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line3).with.offset(50*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.view).with.offset(36*WIDTH_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-36*WIDTH_SCALE);
        make.height.mas_offset(45*HEIGHT_SCALE);
    }];
    [weakSelf.testlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.submitBtn.mas_bottom).with.offset(20*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.submitBtn);
        make.right.equalTo(weakSelf.submitBtn);
    }];
}

- (void)setupViews {
    
    __weak typeof(self) weakSelf = self;
    /// 返回验证码数字
    _testView.changeValidationCodeBlock = ^(void){
        NSLog(@"验证码被点击了：%@", weakSelf.testView.charString);
        weakSelf.textstr = weakSelf.testView.charString;
    };
    NSLog(@"第一次打印：%@", self.testView.charString);
    self.textstr = self.testView.charString;
}
#pragma mark - getters

-(UITextField *)accounttext
{
    if(!_accounttext)
    {
        _accounttext = [[UITextField alloc] init];
        _accounttext.delegate = self;
        UIImageView *imageViewPwd=[[UIImageView alloc]initWithFrame:CGRectMake(-32, 0, 24, 22)];
        imageViewPwd.image=[UIImage imageNamed:@"zhanghao"];
        _accounttext.leftView=imageViewPwd;
        _accounttext.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
        _accounttext.placeholder = @"请输入账号 (至少6位)";
        
    }
    return _accounttext;
}

-(UITextField *)passwordtext1
{
    if(!_passwordtext1)
    {
        _passwordtext1 = [[UITextField alloc] init];
        _passwordtext1.delegate = self;
        UIImageView *imageViewPwd=[[UIImageView alloc]initWithFrame:CGRectMake(-32, 0, 24, 22)];
        imageViewPwd.image=[UIImage imageNamed:@"psw"];
        _passwordtext1.leftView=imageViewPwd;
        _passwordtext1.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
        _passwordtext1.placeholder = @"请输入密码 长度(长度6-16位)";
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
        UIImageView *imageViewPwd=[[UIImageView alloc]initWithFrame:CGRectMake(-32, 0, 24, 22)];
        imageViewPwd.image=[UIImage imageNamed:@"psw"];
        _passwordtext2.leftView=imageViewPwd;
        _passwordtext2.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
        _passwordtext2.placeholder = @"请输入确认密码 长度(长度6-16位)";
        _passwordtext2.secureTextEntry = YES;
    }
    return _passwordtext2;
}


-(UITextField *)valuetext
{
    if(!_valuetext)
    {
        _valuetext = [[UITextField alloc] init];
        _valuetext.delegate = self;
        UIImageView *imageViewPwd=[[UIImageView alloc]initWithFrame:CGRectMake(-32, 0, 24, 22)];
        imageViewPwd.image=[UIImage imageNamed:@"yanzheng"];
        _valuetext.leftView=imageViewPwd;
        _valuetext.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
        _valuetext.placeholder = @"请输入验证码";
    }
    return _valuetext;
}

-(NNValidationView *)testView
{
    if(!_testView)
    {
        _testView = [[NNValidationView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 100) / 2, 200, 100, 40) andCharCount:4 andLineCount:4];
        
        
    }
    return _testView;
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

-(UIView *)line3
{
    if(!_line3)
    {
        _line3 = [[UIView alloc] init];
        _line3.backgroundColor = [UIColor colorWithHexString:@"EBEBEB"];
    }
    return _line3;
}

-(UIButton *)submitBtn
{
    if(!_submitBtn)
    {
        _submitBtn = [[UIButton alloc] init];
        _submitBtn.backgroundColor = [UIColor colorWithHexString:@"5AA703"];
        [_submitBtn addTarget:self action:@selector(submitbtnclick) forControlEvents:UIControlEventTouchUpInside];
        [_submitBtn setTitle:@"立即注册" forState:normal];
        [_submitBtn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:normal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 4;
    }
    return _submitBtn;
}

-(UILabel *)testlab
{
    if(!_testlab)
    {
        _testlab = [[UILabel alloc] init];
        _testlab.text = @"提示:每个设备只能注册一次账号";
        _testlab.font = [UIFont systemFontOfSize:13];
        _testlab.backgroundColor = [UIColor whiteColor];
        _testlab.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _testlab;
}



#pragma mark - 实现方法


-(void)submitbtnclick
{
    
    NSString *account = @"";
    if (self.accounttext.text.length==0) {
        account = @"";
    }
    else
    {
        if (self.accounttext.text.length>=6) {
            account = self.accounttext.text;
        }
        else
        {
            account = @"";
            [MBProgressHUD showSuccess:@"账号至少6位" :self.view];
        }
    }
    
    
    
    NSString *password = @"";
    NSString *password1 = @"";
    NSString *password2 = @"";
    if (self.passwordtext1.text.length==0) {
        password1 = @"";
    }
    else
    {
        if (self.passwordtext1.text.length>=6&&self.passwordtext1.text.length<=16) {
            password1 = self.passwordtext1.text;
        }
        else
        {
            password1 = @"";
           [MBProgressHUD showSuccess:@"密码长度6-16位" :self.view];
        }
    }
    
    
    if (self.passwordtext2.text.length==0) {
        password2 = @"";
    }
    else
    {
        if (self.passwordtext2.text.length>=6&&self.passwordtext2.text.length<=16) {
            password2 = self.passwordtext2.text;
        }
        else
        {
            password2 = @"";
            [MBProgressHUD showSuccess:@"密码长度6-16位" :self.view];

        }
    }
    
    if ([password1 isEqualToString:password2]) {
        password = password1;
    }
    else
    {
        password = @"";

        [MBProgressHUD showSuccess:@"两次密码不一致" :self.view];
    }
    
    NSString *valuestr = @"";
    if (self.valuetext.text.length==0) {
        valuestr = @"";
    }
    else
    {
        valuestr = self.valuetext.text;
        if ([valuestr isEqualToString:self.textstr]) {
            NSString *phoneid = [self uuid];
            NSDictionary *para = @{@"account":account,@"password":password,@"phoneid":phoneid};
            
            NSLog(@"dic------%@",para);
            
            [CLNetworkingManager postNetworkRequestWithUrlString:post_register parameters:para isCache:NO succeed:^(id data) {
                if ([[data objectForKey:@"code"] intValue]==200) {
                    [MBProgressHUD showSuccess:@"成功" :self.view];
                    NSDictionary *datadic = [data objectForKey:@"data"];
                    NSString *token = [datadic objectForKey:@"token"];
                    NSString *userid = [datadic objectForKey:@"userid"];
                    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
                    [userdefat setObject:token forKey:user_token];
                    [userdefat setObject:userid forKey:user_uid];
                    [userdefat synchronize];
                    //[self.navigationController popViewControllerAnimated:YES];
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    
                }
                else
                {
                     [MBProgressHUD showSuccess:@"注册失败，请检查输入" :self.view];

                }
            } fail:^(NSError *error) {
                
                 [MBProgressHUD showSuccess:@"没有网络" :self.view];
            }];
        }
        else
        {
             [MBProgressHUD showSuccess:@"验证码错误" :self.view];
        }
    }
    

}

-(NSString*) uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.accounttext resignFirstResponder];
    [self.passwordtext1 resignFirstResponder];
    [self.passwordtext2 resignFirstResponder];
    [self.valuetext resignFirstResponder];
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
