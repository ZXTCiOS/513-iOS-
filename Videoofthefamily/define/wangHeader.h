//
//  wangHeader.h
//  Videoofthefamily
//
//  Created by 王俊钢 on 2017/9/13.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#ifndef wangHeader_h
#define wangHeader_h

//屏幕 宽 高
#define kScreenW ([UIScreen mainScreen].bounds.size.width)
#define kScreenH ([UIScreen mainScreen].bounds.size.height)

//屏幕宽度比
#define WIDTH_SCALE [UIScreen mainScreen].bounds.size.width / 375
//屏幕高度比
#define HEIGHT_SCALE [UIScreen mainScreen].bounds.size.height / 667

//默认颜色
#define systemColor [UIColor colorWithHexString:@"5AA703"]


#define user_token  @"TOKEN"
#define user_uid    @"UID"


#define BASEURL @"http://53.irapidtech.net"
//首页
#define homeurl             @""BASEURL"/index.php/index/index"
//注册
#define post_register       @""BASEURL"/index.php/login/register"
//登录
#define post_login          @""BASEURL"/index.php/login/login"
//首页点击
#define shouyeclick         @""BASEURL"/index.php/index/detail?token=%@&userid=%@"
//个人中心
#define get_info            @""BASEURL"/index.php/User/index?token=%@&userid=%@"
//个人信息修改
#define post_edit           @""BASEURL"/index.php/User/edit"
//关于我们
#define aboutus             @""BASEURL"/index.php/Mine/index"
//卡密兑换
#define post_cardPassword   @""BASEURL"/index.php/Mine/cardPassword"
// 第三方url
#define get_url             @""BASEURL"/index.php/Mine/url"
#endif /* wangHeader_h */
