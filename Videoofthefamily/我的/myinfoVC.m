//
//  myinfoVC.m
//  Videoofthefamily
//
//  Created by 王俊钢 on 2017/9/13.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "myinfoVC.h"
#import "myinfoCell0.h"
#import "ModifyVC.h"
#import "ModifypasswordVC.h"

@interface myinfoVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@end

static NSString *myinfoidentfid0 = @"myinfoidentfid0";
static NSString *myinfoidentfid1 = @"myinfoidentfid1";


@implementation myinfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人中心";
    [self.view addSubview:self.table];
    self.table.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getters

-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _table.dataSource = self;
        _table.delegate = self;
    }
    return _table;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
    }
    if (section==1) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        myinfoCell0 *cell = [tableView dequeueReusableCellWithIdentifier:myinfoidentfid0];
        cell = [[myinfoCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myinfoidentfid0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row==0) {
            [cell.contentlab setHidden:YES];
            cell.typelab.text = @"修改密码";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row==1) {
            cell.typelab.text = @"昵称";
            cell.contentlab.text = self.nickname;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row==2) {
            cell.typelab.text = @"账号";
            cell.contentlab.text = self.account;
        }
        return cell;
    }
    if (indexPath.section==1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myinfoidentfid1];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myinfoidentfid1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"退出登录";
        cell.textLabel.textColor = systemColor;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 60*HEIGHT_SCALE;
        }
        else
        {
            return 45*HEIGHT_SCALE;
        }
    }
    if (indexPath.section==1) {
        return 45*HEIGHT_SCALE;
    }
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 18*HEIGHT_SCALE;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            ModifypasswordVC *vc = [[ModifypasswordVC alloc] init];
            vc.yuanmima = self.passwordstr;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row==1) {
            ModifyVC *vc = [[ModifyVC alloc] init];
            vc.namestr = self.nickname;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row==2) {
            
        }
    }
    if (indexPath.section==1) {
        UIAlertController *control = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定退出登录吗" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
            [userdefat removeObjectForKey:user_uid];
            [userdefat removeObjectForKey:user_token];
            [self.navigationController popToRootViewControllerAnimated:YES];

        }];
        [control addAction:action0];
        [control addAction:action1];
        [self presentViewController:control animated:YES completion:nil];
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
