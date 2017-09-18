//
//  strisNull.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/31.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "strisNull.h"

@implementation strisNull
+ (BOOL )isNullToString:(id)string
{
    if ([string isEqual:@"NULL"] || [string isKindOfClass:[NSNull class]] || [string isEqual:[NSNull null]] || [string isEqual:NULL] || [[string class] isSubclassOfClass:[NSNull class]] || string == nil || string == NULL || [string isKindOfClass:[NSNull class]] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0 || [string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"])
    {
        return YES;
        
    }else
    {
        
        return NO;
    }
}

+(NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    return timeSp;
    
}


+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    NSString *str=timeString;
    NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
   // [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
     [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}
@end
