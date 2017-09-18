//
//  videoVC.h
//  Videoofthefamily
//
//  Created by 王俊钢 on 2017/9/13.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "BaseViewController.h"

@interface videoVC : UIViewController
@property (nonatomic,strong) NSString *url;
@property (nonatomic, assign) BOOL canDownRefresh;
@property (nonatomic,strong) NSString *vname;
@property (nonatomic,strong) NSMutableArray *viparray;
@property (nonatomic,strong) NSMutableArray *urlarray;
@end
