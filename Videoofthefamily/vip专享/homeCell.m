//
//  homeCell.m
//  Videoofthefamily
//
//  Created by 王俊钢 on 2017/9/13.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "homeCell.h"
#import "homeModel.h"

@interface homeCell()
@property (nonatomic,strong) UILabel *namelab;
@property (nonatomic,strong) UIImageView *typeimg;
@property (nonatomic,strong) homeModel *hmodel;
@end

@implementation homeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.namelab];
        [self.contentView addSubview:self.typeimg];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.typeimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(36*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(9*HEIGHT_SCALE);
        make.right.equalTo(weakSelf).with.offset(-36*WIDTH_SCALE);
        make.height.mas_offset(kScreenW/3-72*WIDTH_SCALE);
    }];
    [weakSelf.namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.typeimg.mas_bottom).with.offset(16*HEIGHT_SCALE);
        make.left.equalTo(weakSelf).with.offset(16*WIDTH_SCALE);
        make.right.equalTo(weakSelf).with.offset(-16*WIDTH_SCALE);
    }];
}

#pragma mark - getters


-(UILabel *)namelab
{
    if(!_namelab)
    {
        _namelab = [[UILabel alloc] init];
        _namelab.textAlignment = NSTextAlignmentCenter;
        _namelab.font = [UIFont systemFontOfSize:14];
        _namelab.textColor = [UIColor colorWithHexString:@"333333"];
        _namelab.text = @"爱奇艺";
    }
    return _namelab;
}

-(UIImageView *)typeimg
{
    if(!_typeimg)
    {
        _typeimg = [[UIImageView alloc] init];
        _typeimg.image = [UIImage imageNamed:@"aiqiyi"];
    }
    return _typeimg;
}

-(void)setdata:(homeModel *)model
{
    self.hmodel = model;
    [self.typeimg sd_setImageWithURL:[NSURL URLWithString:model.vimg]];
    self.namelab.text = model.vname;
}

@end
