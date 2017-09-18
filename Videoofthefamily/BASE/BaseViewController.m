//
//  BaseViewController.m
//  Videoofthefamily
//
//  Created by 王俊钢 on 2017/9/12.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"5AA703"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"FFFFFF"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"FFFFFF"]}];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

    

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
