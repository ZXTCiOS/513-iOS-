//
//  GetUUID.m
//  Videoofthefamily
//
//  Created by 王俊钢 on 2017/9/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "GetUUID.h"

@implementation GetUUID

-(NSString*) uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

@end
