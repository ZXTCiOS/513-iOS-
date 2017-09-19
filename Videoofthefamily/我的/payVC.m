//
//  payVC.m
//  Videoofthefamily
//
//  Created by 王俊钢 on 2017/9/13.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "payVC.h"
#import <CommonCrypto/CommonDigest.h>  

@interface payVC ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *paytext;
@property (nonatomic,strong) UIButton *payBtn;
@property (nonatomic,strong) UIView *line;
@end

@implementation payVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"充值中心";
    
    [self.view addSubview:self.paytext];
    [self.view addSubview:self.payBtn];
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
    [weakSelf.paytext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(15*WIDTH_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-15*WIDTH_SCALE);
        make.height.mas_offset(30*HEIGHT_SCALE);
        make.top.equalTo(weakSelf.view).with.offset(80*HEIGHT_SCALE);
        
    }];
    [weakSelf.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.paytext);
        make.right.equalTo(weakSelf.paytext);
        make.top.equalTo(weakSelf.paytext.mas_bottom);
        make.height.mas_offset(1);
    }];
    
    [weakSelf.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(35*WIDTH_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-35*WIDTH_SCALE);
        make.height.mas_offset(45*HEIGHT_SCALE);
        make.top.equalTo(weakSelf.line).with.offset(50*HEIGHT_SCALE);
    }];
}

#pragma mark - getters


-(UITextField *)paytext
{
    if(!_paytext)
    {
        _paytext = [[UITextField alloc]init];
        _paytext.delegate = self;
        
    }
    return _paytext;
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


-(UIButton *)payBtn
{
    if(!_payBtn)
    {
        _payBtn = [[UIButton alloc] init];
        _payBtn.backgroundColor = systemColor;
        [_payBtn setTitle:@"立即充值" forState:normal];
        [_payBtn setTitleColor:[UIColor colorWithHexString:@"F5F5F5"] forState:normal];
        _payBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_payBtn addTarget:self action:@selector(paybtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payBtn;
}

#pragma mark - 实现方法

-(void)paybtnclick
{
    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
    NSString *userid = [userdefat objectForKey:user_uid];
    NSString *token = [userdefat objectForKey:user_token];
    NSString *ppwd = @"";
    if (self.paytext.text.length==0) {
        ppwd = @"";
    }
    else
    {
        ppwd = self.paytext.text;
    }
    NSDictionary *para = @{@"userid":userid,@"token":token,@"ppwd":ppwd};
    
    [CLNetworkingManager postNetworkRequestWithUrlString:post_cardPassword parameters:para isCache:NO succeed:^(id data) {
        if ([[data objectForKey:@"code"] intValue]==200) {
            UIAlertController *control = [UIAlertController alertControllerWithTitle:@"提示" message:@"充值成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [control addAction:action0];
            [control addAction:action1];
            [self presentViewController:control animated:YES completion:nil];
        }
        else
        {
            [MBProgressHUD showSuccess:@"请输入正确的卡密"];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showSuccess:@"网络错误"];
    }];
}



#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.paytext resignFirstResponder];

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
