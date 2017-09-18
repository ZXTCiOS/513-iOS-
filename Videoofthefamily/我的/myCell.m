//
//  myCell.m
//  Videoofthefamily
//
//  Created by 王俊钢 on 2017/9/13.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "myCell.h"

@interface myCell()
@property (nonatomic,strong) UIImageView *infoimg;

@end

@implementation myCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.infoimg];
        [self.contentView addSubview:self.namelab];
        [self.contentView addSubview:self.contentlab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.infoimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(30*WIDTH_SCALE);
//        make.top.equalTo(weakSelf).with.offset(8*HEIGHT_SCALE);
        make.width.mas_offset(65*WIDTH_SCALE);
        make.height.mas_offset(65*WIDTH_SCALE);
        make.centerY.equalTo(weakSelf);
    }];
    [weakSelf.namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(110*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(27*HEIGHT_SCALE);
    }];
    [weakSelf.contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.namelab);
        make.top.equalTo(weakSelf.namelab.mas_bottom).with.offset(5*HEIGHT_SCALE);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - getters


-(UIImageView *)infoimg
{
    if(!_infoimg)
    {
        _infoimg = [[UIImageView alloc] init];
        [_infoimg sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"touxiang"]];
        _infoimg.layer.masksToBounds = YES;
        _infoimg.layer.cornerRadius = 65/2*WIDTH_SCALE;
    }
    return _infoimg;
}

-(UILabel *)namelab
{
    if(!_namelab)
    {
        _namelab = [[UILabel alloc] init];
        _namelab.font = [UIFont systemFontOfSize:17];
        _namelab.textColor = [UIColor colorWithHexString:@"333333"];
        _namelab.text = @"未登录";
    }
    return _namelab;
}

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.font = [UIFont systemFontOfSize:13];
        _contentlab.textColor = [UIColor colorWithHexString:@"D2D2D2"];
        _contentlab.text = @"更多精彩视频在513影视共享";
    }
    return _contentlab;
}





@end
