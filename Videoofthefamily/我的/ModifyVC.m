//
//  ModifyVC.m
//  Videoofthefamily
//
//  Created by 王俊钢 on 2017/9/13.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "ModifyVC.h"

@interface ModifyVC ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *nicknametext;
@property (nonatomic,strong) UIView *line;
@end

@implementation ModifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改昵称";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithHexString:@"FFFFFF"];
    [self.view addSubview:self.nicknametext];
    [self.view addSubview:self.line];
    [self setuplayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.nicknametext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(15*WIDTH_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-15*WIDTH_SCALE);
        make.height.mas_offset(30*HEIGHT_SCALE);
        make.top.equalTo(weakSelf.view).with.offset(80*HEIGHT_SCALE);
        
    }];
    [weakSelf.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nicknametext);
        make.right.equalTo(weakSelf.nicknametext);
        make.top.equalTo(weakSelf.nicknametext.mas_bottom);
        make.height.mas_offset(1);
    }];
}

#pragma mark - getters

-(UITextField *)nicknametext
{
    if(!_nicknametext)
    {
        _nicknametext = [[UITextField alloc] init];
        _nicknametext.delegate = self;
        _nicknametext.placeholder = @"请输入昵称";
        _nicknametext.text = self.namestr;
    }
    return _nicknametext;
}

-(UIView *)line
{
    if(!_line)
    {
        _line = [[UIView alloc] init];
        _line.backgroundColor = systemColor;
    }
    return _line;
}

-(void)rightAction
{
    NSString *nicknamestr = @"";
    if (self.nicknametext.text.length==0) {
        nicknamestr = @"";
    }
    else
    {
        nicknamestr = self.nicknametext.text;
    }
    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
    NSString *userid = [userdefat objectForKey:user_uid];
    NSString *token = [userdefat objectForKey:user_token];
    NSDictionary *para = @{@"userid":userid,@"token":token,@"nikename":nicknamestr};
    [CLNetworkingManager postNetworkRequestWithUrlString:post_edit parameters:para isCache:NO succeed:^(id data) {
        if ([[data objectForKey:@"code"] intValue]==200) {

            [MBProgressHUD showSuccess:@"修改成功" :self.view];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [MBProgressHUD showSuccess:@"请检查输入" :self.view];

        }
    } fail:^(NSError *error) {
        [MBProgressHUD showSuccess:@"网络错误" :self.view];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.nicknametext resignFirstResponder];
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
