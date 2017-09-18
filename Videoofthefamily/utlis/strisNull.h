//
//  strisNull.h
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/31.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface strisNull : NSObject
+ (BOOL )isNullToString:(id)string;
+(NSString *)getNowTimeTimestamp;
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;
@end
