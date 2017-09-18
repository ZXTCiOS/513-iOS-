//
//  LoginVC.m
//  Videoofthefamily
//
//  Created by 王俊钢 on 2017/9/13.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "LoginVC.h"
#import "logupVC.h"
#import "MainTabBarController.h"
#import "JPLabel.h"
#import "JHUD.h"


@interface LoginVC ()<UITextFieldDelegate,JPLabelDelegate>
@property (nonatomic,strong) UITextField *nicknametext;
@property (nonatomic,strong) UITextField *passwordtext;
@property (nonatomic,strong) UIButton *submitBtn;
@property (nonatomic,strong) UIView *line0;
@property (nonatomic,strong) UIView *line1;
@property (nonatomic,strong) UIButton *logupbtn;


@property (nonatomic,strong) JHUD *hudView;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"账号登录";
    
    [self.view addSubview:self.nicknametext];
    [self.view addSubview:self.passwordtext];
    [self.view addSubview:self.submitBtn];
    [self.view addSubview:self.line0];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.logupbtn];

    [self setuplayout];
    
    _hudView = [[JHUD alloc]initWithFrame:self.view.bounds];
    
    _hudView.messageLabel.text = @"正在登录";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.nicknametext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(35*WIDTH_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-35*WIDTH_SCALE);
        make.top.equalTo(weakSelf.view).with.offset(199*HEIGHT_SCALE);
        make.height.mas_offset(30*HEIGHT_SCALE);
    }];
    [weakSelf.passwordtext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nicknametext);
        make.right.equalTo(weakSelf.nicknametext);
        make.top.equalTo(weakSelf.nicknametext.mas_bottom).with.offset(30*HEIGHT_SCALE);
        make.height.mas_offset(30*HEIGHT_SCALE);
    }];
    [weakSelf.line0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nicknametext).with.offset(24);
        make.right.equalTo(weakSelf.nicknametext);
        make.height.mas_offset(1);
        make.top.equalTo(weakSelf.nicknametext.mas_bottom).with.offset(1);
    }];
    [weakSelf.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.line0);
        make.right.equalTo(weakSelf.line0);
        make.height.mas_offset(1);
        make.top.equalTo(weakSelf.passwordtext.mas_bottom).with.offset(1);
    }];
    [weakSelf.logupbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line1).with.offset(20*HEIGHT_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-37*HEIGHT_SCALE);
        make.height.mas_offset(20*HEIGHT_SCALE);
        make.width.mas_offset(80*WIDTH_SCALE);
    }];

    [weakSelf.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line1).with.offset(50*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.view).with.offset(36*WIDTH_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-36*WIDTH_SCALE);
        make.height.mas_offset(45*HEIGHT_SCALE);
    }];

}

#pragma mark - getters

-(UITextField *)nicknametext
{
    if(!_nicknametext)
    {
        _nicknametext = [[UITextField alloc] init];
        _nicknametext.delegate = self;
        UIImageView *imageViewPwd=[[UIImageView alloc]initWithFrame:CGRectMake(-32, 0, 24, 22)];
        imageViewPwd.image=[UIImage imageNamed:@"zhanghao"];
        _nicknametext.leftView=imageViewPwd;
        _nicknametext.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
        _nicknametext.placeholder = @"请输入账号";
    }
    return _nicknametext;
}


-(UITextField *)passwordtext
{
    if(!_passwordtext)
    {
        _passwordtext = [[UITextField alloc] init];
        _passwordtext.delegate = self;
        UIImageView *imageViewPwd=[[UIImageView alloc]initWithFrame:CGRectMake(-32, 0, 24, 24)];
        imageViewPwd.image=[UIImage imageNamed:@"psw"];
        _passwordtext.leftView=imageViewPwd;
        _passwordtext.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
        _passwordtext.placeholder = @"请输入密码";
        _passwordtext.secureTextEntry = YES;
    }
    return _passwordtext;
}

-(UIButton *)submitBtn
{
    if(!_submitBtn)
    {
        _submitBtn = [[UIButton alloc] init];
        _submitBtn.backgroundColor = [UIColor colorWithHexString:@"5AA703"];
        [_submitBtn addTarget:self action:@selector(subbtnclick) forControlEvents:UIControlEventTouchUpInside];
        [_submitBtn setTitle:@"立即登录" forState:normal];
        [_submitBtn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:normal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 4;
    }
    return _submitBtn;
}


-(UIButton *)logupbtn
{
    if(!_logupbtn)
    {
        _logupbtn = [[UIButton alloc] init];
        [_logupbtn setTitleColor:systemColor forState:normal];
        _logupbtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_logupbtn addTarget:self action:@selector(logupbtnclick) forControlEvents:UIControlEventTouchUpInside];
        [_logupbtn setTitle:@"快速注册" forState:normal];
        _logupbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _logupbtn.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
    }
    return _logupbtn;
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





- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.nicknametext resignFirstResponder];
    [self.passwordtext resignFirstResponder];
}

#pragma mark - 实现方法

-(void)subbtnclick
{
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    MainTabBarController * main = [[MainTabBarController alloc] init];
//    appDelegate.window.rootViewController = main;
    NSString *account = @"";
    NSString *password = @"";
    if (self.nicknametext.text.length==0) {
        account = @"";
    }
    else
    {
        account = self.nicknametext.text;
    }
    if (self.passwordtext.text.length==0) {
        password = @"";
    }
    else
    {
        password = self.passwordtext.text;
    }
    
    //show
    [_hudView showAtView:self.view hudType:JHUDLoadingTypeCircle];
    

    
    NSDictionary *para = @{@"account":account,@"password":password};
    [CLNetworkingManager postNetworkRequestWithUrlString:post_login parameters:para isCache:NO succeed:^(id data) {
        if ([[data objectForKey:@"code"] intValue]==200) {
            NSDictionary *datadic = [data objectForKey:@"data"];
            NSString *token = [datadic objectForKey:@"token"];
            NSString *userid = [datadic objectForKey:@"userid"];
            NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
            [userdefat setObject:token forKey:user_token];
            [userdefat setObject:userid forKey:user_uid];
            [userdefat synchronize];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        if ([[data objectForKey:@"code"] intValue]==204) {
            [MBProgressHUD showSuccess:@"账号或密码错误"];
        }
        //hide
        [_hudView hide];
    } fail:^(NSError *error) {
        [MBProgressHUD showSuccess:@"网络错误"];
        //hide
        [_hudView hide];
    }];
}

-(void)logupbtnclick
{
    logupVC *vc = [[logupVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
