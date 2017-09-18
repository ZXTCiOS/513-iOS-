//
//  MBProgressHUD+XMG.h
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/24.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//
//
//#import <MBProgressHUD/MBProgressHUD.h>

#import "MBProgressHUD.h"

@interface MBProgressHUD (XMG)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end
