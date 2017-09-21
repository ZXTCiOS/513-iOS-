//
//  mineVC.m
//  Videoofthefamily
//
//  Created by 王俊钢 on 2017/9/12.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "mineVC.h"
#import "myCell.h"
#import "mineCell.h"
#import "myinfoVC.h"
#import "payVC.h"
#import "LoginVC.h"
#import "MainNavigationController.h"
#import "SZKCleanCache.h"
#import "aboutVC.h"
#import "instructionVC.h"


@interface mineVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSString *namestr;
@property (nonatomic,strong) NSString *password;
@property (nonatomic,strong) NSString *account;
@property (nonatomic,strong) NSString *stilltime;

@end

static NSString *mineidentfid0 = @"mineidentfid0";
static NSString *mineidentfid1 = @"mineidentfid1";
static NSString *mineidentfid2 = @"mineidentfid2";
static NSString *mineidentfid3 = @"mineidentfid3";
static NSString *mineidentfid4 = @"mineidentfid4";

@implementation mineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"5AA703"]];
    self.title = @"我的";
    [self.view addSubview:self.table];
    self.table.tableFooterView = [UIView new];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loaddata];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loaddata
{
    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
    NSString *userid = [userdefat objectForKey:user_uid];
    NSString *token = [userdefat objectForKey:user_token];
    
    NSString *urlstr = [NSString stringWithFormat:get_info,token,userid];
    [CLNetworkingManager getNetworkRequestWithUrlString:urlstr parameters:nil isCache:NO succeed:^(id data) {
        if ([[data objectForKey:@"code"] intValue]==200) {
            NSDictionary *datadic = [data objectForKey:@"data"];
            self.namestr = [datadic objectForKey:@"nikename"];
            self.password = [datadic objectForKey:@"password"];
            self.account = [datadic objectForKey:@"account"];
            self.stilltime = [datadic objectForKey:@"stilltime"];
            
            [self.table reloadData];
        }
        if ([[data objectForKey:@"code"] intValue]==002) {

            [self.table reloadData];
        }
        
    } fail:^(NSError *error) {

        [self.table reloadData];
    }];

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
    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
    NSString *uid = [userdefat objectForKey:user_uid];
    if ([strisNull isNullToString:uid]) {
        return 2;
    }
    else
    {
        return 4;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    if (section==1) {
        return 3;
    }
    if (section==2) {
        return 1;
    }
    if (section==3) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
    NSString *uid = [userdefat objectForKey:user_uid];
    if ([strisNull isNullToString:uid])
    {
        if (indexPath.section==0) {
            myCell *cell = [tableView dequeueReusableCellWithIdentifier:mineidentfid0];
            cell = [[myCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineidentfid0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentlab.text = @"请登录";
            return cell;
        }
        if (indexPath.section==1) {
            mineCell *cell = [tableView dequeueReusableCellWithIdentifier:mineidentfid1];
            cell = [[mineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineidentfid1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row==0) {
                cell.typelab.text = @"关于我们";
                cell.leftimg.image = [UIImage imageNamed:@"guanyu"];
            }
            if (indexPath.row==1) {
                cell.leftimg.image = [UIImage imageNamed:@"qingchu"];
                cell.typelab.text = @"清空缓存";
            }
            if (indexPath.row==2) {
                cell.leftimg.image = [UIImage imageNamed:@"图层-1"];
                cell.typelab.text = @"使用说明";
            }
            return cell;
        }
    }
    else
    {
        if (indexPath.section==0) {
            myCell *cell = [tableView dequeueReusableCellWithIdentifier:mineidentfid0];
            cell = [[myCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineidentfid0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if ([strisNull isNullToString:self.namestr]) {
                cell.namelab.text = self.account;
            }
            else
            {
                cell.namelab.text = self.namestr;
            }
            
            NSString *str = self.stilltime;
            NSInteger inter = [str intValue];
            NSString *str1 = [self timestampSwitchTime:inter andFormatter:@"YYYY-MM-dd hh:mm:ss"];
            cell.contentlab.text = [NSString stringWithFormat:@"%@%@",@"到期时间:",str1];
            return cell;
        }
        if (indexPath.section==1) {
            mineCell *cell = [tableView dequeueReusableCellWithIdentifier:mineidentfid1];
            cell = [[mineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineidentfid1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row==0) {
                cell.typelab.text = @"充值中心";
            }
            if (indexPath.row==1) {
                cell.leftimg.image = [UIImage imageNamed:@"guanyu"];
                cell.typelab.text = @"关于我们";
            }
            if (indexPath.row==2) {
                cell.leftimg.image = [UIImage imageNamed:@"图层-1"];
                cell.typelab.text = @"使用说明";
            }
            return cell;
        }
        if (indexPath.section==2) {
            mineCell *cell = [tableView dequeueReusableCellWithIdentifier:mineidentfid2];
            cell = [[mineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineidentfid2];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.leftimg.image = [UIImage imageNamed:@"qingchu"];
            cell.typelab.text = @"清空缓存";
            return cell;
        }
        if (indexPath.section==3) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mineidentfid3];
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineidentfid3];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"退出登录";
            cell.textLabel.textColor = systemColor;
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            return cell;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 90*HEIGHT_SCALE;
    }
    else
    {
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
        
        NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
        NSString *uid = [userdefat objectForKey:user_uid];
        if ([strisNull isNullToString:uid]) {
            UIAlertController *control = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还未登录，去登录吗" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                LoginVC *vc = [[LoginVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }];
            [control addAction:action0];
            [control addAction:action1];
            [self presentViewController:control animated:YES completion:nil];

        }
        else
        {
            myinfoVC *vc = [[myinfoVC alloc] init];
            vc.nickname = self.namestr;
            vc.passwordstr = self.password;
            vc.account = self.account;
            [self.navigationController pushViewController:vc animated:YES];
        }
        


    }
    if (indexPath.section==1) {
        
        NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
        NSString *uid = [userdefat objectForKey:user_uid];
        if ([strisNull isNullToString:uid])
        {
            if (indexPath.row==0) {
                aboutVC *vc = [[aboutVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            if (indexPath.row==1) {
                //输出缓存大小 m
                NSLog(@"%.2fm",[SZKCleanCache folderSizeAtPath]);
                
                //清楚缓存
                [SZKCleanCache cleanCache:^{
                    NSLog(@"清除成功");
                    [MBProgressHUD showSuccess:@"清除成功" :self.view];
                }];
            }
            if (indexPath.row==2) {
                instructionVC *vc = [[instructionVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        else
        {
            if (indexPath.row==0) {
                payVC *vc = [[payVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            if (indexPath.row==1) {
                aboutVC *vc = [[aboutVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            if (indexPath.row==2) {
                instructionVC *vc = [[instructionVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        }
    if (indexPath.section==2) {
        //输出缓存大小 m
        NSLog(@"%.2fm",[SZKCleanCache folderSizeAtPath]);
        
        //清楚缓存
        [SZKCleanCache cleanCache:^{

            [MBProgressHUD showSuccess:@"清除成功" :self.view];
        }];
    }
    if (indexPath.section==3) {
        UIAlertController *control = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定退出登录吗" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSUserDefaults *defat = [NSUserDefaults standardUserDefaults];
            [defat removeObjectForKey:user_uid];
            [defat removeObjectForKey:user_token];
            
            LoginVC *vc = [[LoginVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];

            
        }];
        [control addAction:action0];
        [control addAction:action1];
        [self presentViewController:control animated:YES completion:nil];
    }
}

#pragma mark - 将某个时间戳转化成 时间

-(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    //format = @"YYYY-MM-dd hh:mm:ss";
    [formatter setDateFormat:format]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
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
