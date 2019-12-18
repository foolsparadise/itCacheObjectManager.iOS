//
//  itCacheObject.m
//  NULL
//
//  Created by foolsparadise on 12/12/2019.
//  Copyright © 2019 github.com/foolsparadise. All rights reserved.
//

#import "itCacheObject.h"

#include "Reachability.h"
// Expired Time
#define Expired_Time_DATA               3600*24*30   //30天
#define Expired_Time_WIFI               3600*24*7    //7天
// Current Network
#define CurrentNetwork_DISCONNECTED                -1  //没有连接
#define CurrentNetwork_DATA                        0   //手机蜂窝网络连接
#define CurrentNetwork_WIFI                        1   //Wi-Fi连接

@implementation itCacheObject

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.key = [aDecoder decodeObjectForKey:@"key"];
        self.data = [aDecoder decodeObjectForKey:@"data"];
        self.time = [aDecoder decodeObjectForKey:@"time"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.key forKey:@"key"];
    [aCoder encodeObject:self.data forKey:@"data"];
    [aCoder encodeObject:self.time forKey:@"time"];
}

- (int)getExpiredTime {
    int time = Expired_Time_WIFI;
    if ([self getNetType] == CurrentNetwork_DATA) {
        time = Expired_Time_DATA;
    }
    return time;
}

- (BOOL)isExpired {
    BOOL flag = NO;
    NSInteger lastTime = [self.time floatValue];
    NSInteger currTime = [[NSDate date] timeIntervalSince1970];
    if ((currTime - lastTime) > [self getExpiredTime]) {
        flag = YES;
    }
    return flag;
}

- (NSInteger)getNetType {
    NSInteger type = -1;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch([reach currentReachabilityStatus])
    {
        case NotReachable:  //没有连接上
            type = CurrentNetwork_DISCONNECTED;
            break;
        case ReachableViaWiFi:    //通过Wi-Fi连接
            type = CurrentNetwork_WIFI;
            break;
        case ReachableViaWWAN:    //通过手机蜂窝网络连接
            type = CurrentNetwork_DATA;
            break;
        default://未知情况
            type = 0;
            break;
    }
    return type;
}

@end
