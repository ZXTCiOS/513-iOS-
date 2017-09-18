//
//  myinfoCell0.m
//  Videoofthefamily
//
//  Created by 王俊钢 on 2017/9/13.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "myinfoCell0.h"

@implementation myinfoCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.typelab];
        [self.contentView addSubview:self.contentlab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.typelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.centerY.equalTo(weakSelf);
        make.width.mas_equalTo(100*WIDTH_SCALE);
        make.height.mas_equalTo(20*HEIGHT_SCALE);
    }];
    [weakSelf.contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf).with.offset(-30*WIDTH_SCALE);
        make.height.mas_equalTo(20*HEIGHT_SCALE);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - getters


-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.textColor = [UIColor colorWithHexString:@"333333"];
        _typelab.font = [UIFont systemFontOfSize:15];
    }
    return _typelab;
}

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.textColor = [UIColor colorWithHexString:@"B7B7B7"];
        _contentlab.font = [UIFont systemFontOfSize:15];
        _contentlab.text = @"b513";
        _contentlab.textAlignment = NSTextAlignmentRight;
    }
    return _contentlab;
}




@end
