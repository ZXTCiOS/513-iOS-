//
//  homeVC.m
//  Videoofthefamily
//
//  Created by 王俊钢 on 2017/9/12.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "homeVC.h"
#import "SDCycleScrollView.h"
#import "homeCell.h"
#import "videoVC.h"
#import "homeModel.h"
#import "LoginVC.h"
#import "urlModel.h"
#import "liveVC.h"

@interface homeVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate>
{
    NSArray *_imagesURLStrings;
}
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UILabel *typelab;
@property (nonatomic,strong) NSMutableArray *imageurlarr;
@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) NSMutableArray *urlarray;

@end

@implementation homeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"5AA703"]];
    // Do any additional setup after loading the view.
    self.imageurlarr = [NSMutableArray array];
    self.dataSource = [NSMutableArray array];
    self.urlarray = [NSMutableArray array];

    [self loaddata];
    
    self.title = @"513影视共享";
    [self.view addSubview:self.collectionView];

    _imagesURLStrings = self.imageurlarr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loaddata
{
    [CLNetworkingManager getNetworkRequestWithUrlString:homeurl parameters:nil isCache:NO succeed:^(id data) {

        if ([[data objectForKey:@"code"] intValue]==200) {
            NSDictionary *datadic = [data objectForKey:@"data"];
            NSArray *imgarr = [datadic objectForKey:@"slide"];
            for (int i = 0; i<imgarr.count; i++) {
                NSDictionary *imgdic = [imgarr objectAtIndex:i];
                NSString *simg = [imgdic objectForKey:@"simg"];
                [self.imageurlarr addObject:simg];
            }
            
            NSArray *videoArr = [datadic objectForKey:@"video"];
            for (int i = 0; i<videoArr.count; i++) {
                NSDictionary *videoDic = [videoArr objectAtIndex:i];
                homeModel *model = [[homeModel alloc] init];
                model.videoid = [videoDic objectForKey:@"videoid"];
                model.vimg = [videoDic objectForKey:@"vimg"];
                model.vname = [videoDic objectForKey:@"vname"];
                model.vtime = [videoDic objectForKey:@"vtime"];
                model.vurl = [videoDic objectForKey:@"vurl"];
                [self.dataSource addObject:model];
            }
            
            [self.collectionView reloadData];
        }
    } fail:^(NSError *error) {
        
    }];
    
    [CLNetworkingManager getNetworkRequestWithUrlString:get_url parameters:nil isCache:NO succeed:^(id data) {
        if ([[data objectForKey:@"code"] intValue]==200) {
            NSArray *dataarr = [data objectForKey:@"data"];
            for (int i = 0; i<dataarr.count; i++) {
                NSDictionary *dic = [dataarr objectAtIndex:i];
                urlModel *model = [[urlModel alloc] init];
                model.iid = [dic objectForKey:@"iid"];
                model.iname = [dic objectForKey:@"iname"];
                model.itime = [dic objectForKey:@"itime"];
                model.iurl = [dic objectForKey:@"iurl"];
                [self.urlarray addObject:model];
            }
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showSuccess:@"网络错误"];
    }];
}

#pragma mark - 创建collectionView并设置代理

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.headerReferenceSize = CGSizeMake(kScreenW, 205*HEIGHT_SCALE);//头部大小
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) collectionViewLayout:flowLayout];
        //定义每个UICollectionView 的大小
        flowLayout.itemSize = CGSizeMake(kScreenW/3-2, 90*HEIGHT_SCALE);
        //定义每个UICollectionView 横向的间距
        flowLayout.minimumLineSpacing = 1;
        //定义每个UICollectionView 纵向的间距
        flowLayout.minimumInteritemSpacing = 1;
        //定义每个UICollectionView 的边距距
        flowLayout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);//上左下右
        //注册cell和ReusableView（相当于头部）
        [_collectionView registerClass:[homeCell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
        //设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //背景颜色
        _collectionView.backgroundColor = [UIColor whiteColor];
        //自适应大小
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _collectionView;
}

-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.font = [UIFont systemFontOfSize:15];
        _typelab.text = @"播放器";
        _typelab.textColor = [UIColor colorWithHexString:@"999999"];
        _typelab.textAlignment = NSTextAlignmentLeft;
    }
    return _typelab;
}

#pragma mark -UICollectionViewDataSource&&UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

#pragma mark 每个UICollectionView展示的内容

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    homeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    [cell setdata:self.dataSource[indexPath.item]];
    return cell;
}

#pragma mark 头部显示的内容

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                            UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    
    SDCycleScrollView *CYVIEW = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenW, 175*HEIGHT_SCALE) imageURLStringsGroup:_imagesURLStrings];
    CYVIEW.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    [headerView addSubview:CYVIEW];
    headerView.backgroundColor = [UIColor colorWithHexString:@"F5F5F5"];
    self.typelab.frame = CGRectMake(14*WIDTH_SCALE, 180*HEIGHT_SCALE, 100, 20*HEIGHT_SCALE);
    [headerView addSubview:self.typelab];
    return headerView;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
    NSString *uid = [userdefat objectForKey:user_uid];
    
    if ([strisNull isNullToString:uid]) {
        [self loginpushclick];
    }
    else
    {
        
        NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
        NSString *userid = [userdefat objectForKey:user_uid];
        NSString *token = [userdefat objectForKey:user_token];
        NSString *urlstr = [NSString stringWithFormat:shouyeclick,token,userid];
        [CLNetworkingManager getNetworkRequestWithUrlString:urlstr parameters:nil isCache:NO succeed:^(id data) {
            if ([[data objectForKey:@"code"] intValue]==200) {
                
                videoVC *vc = [[videoVC alloc] init];
                homeModel *model = self.dataSource[indexPath.item];
                if ([model.vname isEqualToString:@"斗鱼"]||[model.vname isEqualToString:@"虎牙"]) {
                    liveVC *vc = [[liveVC alloc] init];
                    vc.url = model.vurl;
                    vc.vname = model.vname;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else
                {
                    vc.url = model.vurl;
                    vc.vname = model.vname;
                    vc.viparray = [NSMutableArray array];
                    vc.urlarray = [NSMutableArray array];
                    vc.urlarray = self.urlarray;
                    vc.viparray = self.dataSource;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                
            }
            else
            {
                [MBProgressHUD showSuccess:@"请先充值"];
                
            }
        } fail:^(NSError *error) {
            
        }];

    }
}

-(void)loginpushclick
{
    LoginVC *vc = [[LoginVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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

