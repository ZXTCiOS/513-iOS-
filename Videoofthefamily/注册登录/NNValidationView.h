//
//  LoginVC.h
//  Videoofthefamily
//
//  Created by 王俊钢 on 2017/9/13.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^NNChangeValidationCodeBlock)();

@interface NNValidationView : UIView

@property (nonatomic, copy) NSArray *charArray;

@property (nonatomic, strong) NSMutableString *charString;

@property (nonatomic, copy) NNChangeValidationCodeBlock changeValidationCodeBlock;

- (instancetype)initWithFrame:(CGRect)frame andCharCount:(NSInteger)charCount andLineCount:(NSInteger)lineCount;

@end
