//
//  MBProgressHUD+WJG.m
//  Videoofthefamily
//
//  Created by 王俊钢 on 2017/9/21.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "MBProgressHUD+WJG.h"

@implementation MBProgressHUD (WJG)

+ (void)showSuccess:(NSString *)success: (UIView *)view
{
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:view animated:YES] ;
    HUD.mode = MBProgressHUDModeText;
    HUD.label.text = success;
    HUD.removeFromSuperViewOnHide = YES;
    [HUD hideAnimated:YES afterDelay:1.5];
    
}

@end
