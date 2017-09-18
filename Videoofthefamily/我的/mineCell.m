//
//  mineCell.m
//  Videoofthefamily
//
//  Created by 王俊钢 on 2017/9/13.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "mineCell.h"

@interface mineCell()

@end

@implementation mineCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftimg];
        [self.contentView addSubview:self.typelab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.leftimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15*WIDTH_SCALE);
        make.centerY.equalTo(weakSelf);
        make.width.mas_offset(24*WIDTH_SCALE);
        make.height.mas_offset(24*WIDTH_SCALE);
    }];
    [weakSelf.typelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftimg.mas_right).with.offset(20*WIDTH_SCALE);
        make.centerY.equalTo(weakSelf);
        make.height.mas_offset(24*WIDTH_SCALE);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - getters

-(UIImageView *)leftimg
{
    if(!_leftimg)
    {
        _leftimg = [[UIImageView alloc] init];
        _leftimg.image = [UIImage imageNamed:@"chongzhi"];
    }
    return _leftimg;
}

-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.font = [UIFont systemFontOfSize:15];
        _typelab.textColor = [UIColor colorWithHexString:@"333333"];
        _typelab.text = @"充值卡";
    }
    return _typelab;
}




@end
