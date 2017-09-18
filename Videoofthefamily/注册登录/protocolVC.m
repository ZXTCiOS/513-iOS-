//
//  protocolVC.m
//  Videoofthefamily
//
//  Created by 王俊钢 on 2017/9/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "protocolVC.h"
#import "bannerLab.h"
#import "xieyiScrollView.h"
@interface protocolVC ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIView *bannerview;
@property (nonatomic,strong) UIButton *backbtn;
@property (nonatomic,strong) UILabel *titlelab;
@property (nonatomic,strong) UIView  *line;
@property (nonatomic,strong) xieyiScrollView *xieyiview;


@end

@implementation protocolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"协议";
    [self.view addSubview:self.bannerview];
    [self.view addSubview:self.line];
    [self.view addSubview:self.xieyiview];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - getters


-(UIView *)bannerview
{
    if(!_bannerview)
    {
        _bannerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 64)];
        [self.bannerview addSubview:self.titlelab];
        [self.bannerview addSubview:self.backbtn];
    }
    return _bannerview;
}

-(UILabel *)titlelab
{
    if(!_titlelab)
    {
        _titlelab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, kScreenW, 64)];
        _titlelab.text = @"用户协议";
        _titlelab.textColor = [UIColor blackColor];
        _titlelab.textAlignment = NSTextAlignmentCenter;
    }
    return _titlelab;
}


-(UIView *)line
{
    if(!_line)
    {
        _line = [[UIView alloc] init];
        _line.frame = CGRectMake(0, 64, kScreenW, 0.4);
        _line.backgroundColor = [UIColor blackColor];
    }
    return _line;
}

-(xieyiScrollView *)xieyiview
{
    if(!_xieyiview)
    {
        _xieyiview = [[xieyiScrollView alloc] init];
        _xieyiview.frame = CGRectMake(0, 64, kScreenW, kScreenH-64);
        //设置内容大小
        _xieyiview.contentSize = _xieyiview.xieyiimg.frame.size;
        //设置代理为控制器
        _xieyiview.delegate = self;
        //设置最小缩放比例
        _xieyiview.minimumZoomScale = 1;
        //设置最大缩放比例
        _xieyiview.maximumZoomScale = 2;
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
        //设置手势点击数,双击：点2下
        tapGesture.numberOfTapsRequired=2;
        [_xieyiview addGestureRecognizer:tapGesture];
        
    }
    return _xieyiview;
}


#pragma mark - 协议展示
//放大缩小
-(void)handleTapGesture:(UIGestureRecognizer*)sender
{
    if(_xieyiview.zoomScale > 1.0){
        [_xieyiview setZoomScale:1.0 animated:YES];
        
    }else{
        [_xieyiview setZoomScale:2.0 animated:YES];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _xieyiview.xieyiimg;
}

-(void)tapGesture:(UIGestureRecognizer*)sender
{
    
}



@end
