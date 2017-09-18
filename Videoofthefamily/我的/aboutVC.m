//
//  aboutVC.m
//  Videoofthefamily
//
//  Created by 王俊钢 on 2017/9/13.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "aboutVC.h"

@interface aboutVC ()
@property (nonatomic,strong) UILabel *contentlab;
@property (nonatomic,strong) UIImageView *aboutimg;
@end

@implementation aboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关于我们";
    [self loaddata];
    
    [self.view addSubview:self.contentlab];
    [self.view addSubview:self.aboutimg];
    [self setuplayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loaddata
{
    [CLNetworkingManager getNetworkRequestWithUrlString:aboutus parameters:nil isCache:NO succeed:^(id data) {
        if ([[data objectForKey:@"code"] intValue]==200) {
            NSDictionary *dic = [data objectForKey:@"data"];
            NSString *str = [dic objectForKey:@"mintro"];
            str = @"      513影视共享”是一个收藏各种视频播放器的应用，如爱奇艺、腾讯视频、优酷、芒果TV等等主流视频播放器。致力为用户打造一款主流全影视APP。\n      快向朋友推荐我吧！";
            
            [self.contentlab setText:str];
            NSString *imgstr = [dic objectForKey:@"mimg"];

            [self.aboutimg sd_setImageWithURL:[NSURL URLWithString:imgstr]];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showSuccess:@"网络错误"];
    }];
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    weakSelf.contentlab.sd_layout.leftSpaceToView(weakSelf.view, 15*WIDTH_SCALE).topSpaceToView(weakSelf.view, 64+20*HEIGHT_SCALE).rightSpaceToView(weakSelf.view, 15*WIDTH_SCALE).autoHeightRatio(0);
    weakSelf.aboutimg.sd_layout.leftSpaceToView(weakSelf.view, 122*WIDTH_SCALE).topSpaceToView(weakSelf.contentlab, 30*HEIGHT_SCALE).rightSpaceToView(weakSelf.view, 122*WIDTH_SCALE).heightIs(kScreenW-244*WIDTH_SCALE);
    
}


#pragma mark - getters


-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.numberOfLines = 0;
        _contentlab.textColor = [UIColor colorWithHexString:@"333333"];
        _contentlab.font = [UIFont systemFontOfSize:14];
    }
    return _contentlab;
}


-(UIImageView *)aboutimg
{
    if(!_aboutimg)
    {
        _aboutimg = [[UIImageView alloc] init];
    }
    return _aboutimg;
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
