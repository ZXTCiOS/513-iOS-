//
//  instructionVC.m
//  Videoofthefamily
//
//  Created by 王俊钢 on 2017/9/21.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "instructionVC.h"

@interface instructionVC ()
@property (nonatomic,strong) UILabel *contentlab;
@property (nonatomic,strong) UIImageView *demoimg;
@end

@implementation instructionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"使用说明";
    
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.contentlab];
    [self.view addSubview:self.demoimg];
    [self setuplayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(14*WIDTH_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-14*WIDTH_SCALE);
        make.top.equalTo(weakSelf.view).with.offset(80*WIDTH_SCALE);
    }];
    [weakSelf.demoimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(35*WIDTH_SCALE);
        make.top.equalTo(weakSelf.contentlab.mas_bottom).with.offset(20*HEIGHT_SCALE);
        make.width.mas_offset(200*WIDTH_SCALE);
        make.height.mas_offset(320*WIDTH_SCALE);
    }];
}

#pragma mark - getters

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.font = [UIFont systemFontOfSize:14];
        [_contentlab setText:@"       本产品是用于只有通过卡密充值，就可以上各个视频网站看到各种视频，包扩vip视频.具体使用步骤如下\n \n 第一步：注册，登录，充值\n \n 第二步：点击513视频界面的各个网站，进入各个网站\n \n 第三步：点击普通的视频，可以正常播放。点击vip视频的时候，需要在标题栏上点击(选择路线)按钮，选择任意一条线路可看vip视频,如若播放线路不稳定，可以随时切换线路。如下图所示："];
        _contentlab.textColor = [UIColor colorWithHexString:@"333333"];
        _contentlab.numberOfLines = 0;
    }
    return _contentlab;
}

-(UIImageView *)demoimg
{
    if(!_demoimg)
    {
        _demoimg = [[UIImageView alloc] init];
        _demoimg.image = [UIImage imageNamed:@"jietu"];
    }
    return _demoimg;
}


@end
