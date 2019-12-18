//
//  itCacheObjectManager.m
//  NULL
//
//  Created by foolsparadise on 12/12/2019.
//  Copyright © 2019 github.com/foolsparadise. All rights reserved.
//

#import "itCacheObjectManager.h"

#import "itCacheObject.h"
#define __itCacheObjectManager @"itCacheObjectManager"

@implementation itCacheObjectManager

#pragma mark has?
- (BOOL)hasObjectCacheForKey:(id)key {
    NSString *cacheKey = [NSString stringWithFormat:@"%@_%@", __itCacheObjectManager, key];
    id value = [[NSUserDefaults standardUserDefaults] objectForKey:cacheKey];
    return value ? YES : NO;
}
#pragma mark obj
- (id)getOobjectForKey:(NSString *)key {
    //only for this file
    if ( nil == key )
        return nil;
    id value = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    itCacheObject *cache = [NSKeyedUnarchiver unarchiveObjectWithData:value];
    return cache;
}
- (void)setObject:(id)value forKey:(NSString *)key {
    //only for this file
    if ( nil == key || nil == value )
        return;
    NSTimeInterval currTime = [[NSDate date] timeIntervalSince1970];
    itCacheObject *cache = [itCacheObject new];
    cache.key = key;
    //cache.data = value;
    cache.data = [NSKeyedArchiver archivedDataWithRootObject:value];
    cache.time = [NSString stringWithFormat:@"%f", currTime];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:cache] forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (id)getObjectCacheForKey:(NSString *)key {
    if (nil == key)
        return nil;
    NSString *cacheKey = [NSString stringWithFormat:@"%@_%@", __itCacheObjectManager, key];
    //id value = [[NSUserDefaults standardUserDefaults] objectForKey:cacheKey];
    //return [NSKeyedUnarchiver unarchiveObjectWithData:value];
    itCacheObject *cache = [self getOobjectForKey:cacheKey];
    if(nil == cache) return nil;
    id objID = [NSKeyedUnarchiver unarchiveObjectWithData:cache.data];
    return objID;
}
- (void)setObjectCache:(id)value forKey:(NSString *)key {
    //缓存专用，这个方法会自动为KEY加上 __itCacheObjectManager 的头，以方便清除缓存判断
    NSString *cacheKey = [NSString stringWithFormat:@"%@_%@", __itCacheObjectManager, key];
    [self setObject:value forKey:cacheKey];
}
#pragma mark isexpired?
- (id)isObjectCacheExpiredForKey:(NSString *)key {
    if ( nil == key )
        return nil;
    NSString *cacheKey = [NSString stringWithFormat:@"%@_%@", __itCacheObjectManager, key];
    //id value = [[NSUserDefaults standardUserDefaults] objectForKey:cacheKey];
    //itCacheObject *cache = [NSKeyedUnarchiver unarchiveObjectWithData:value];
    itCacheObject *cache = [self getOobjectForKey:cacheKey];
    if (![key isEqualToString:@"some key you not need"] || [cache isExpired]) {
        return nil;
    }
    //return cache.data;
    id objID = [NSKeyedUnarchiver unarchiveObjectWithData:cache.data];
    return objID;
}
#pragma mark bools
- (void)setBool:(BOOL)value forKey:(NSString *)key {
    NSString *cacheKey = [NSString stringWithFormat:@"%@_%@", __itCacheObjectManager, key];
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:cacheKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (BOOL)getBoolForKey:(NSString *)key {
    NSString *cacheKey = [NSString stringWithFormat:@"%@_%@", __itCacheObjectManager, key];
    return [[NSUserDefaults standardUserDefaults] boolForKey:cacheKey];
}
#pragma mark remove
- (void)removeObjectForKey:(NSString *)key {
    //only for this file
    if ( nil == key )
        return;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)removeObjectCacheForKey:(NSString *)key {
    if ( nil == key )
        return;
    NSString *cacheKey = [NSString stringWithFormat:@"%@_%@", __itCacheObjectManager, key];
    [self removeObjectForKey:cacheKey];
}
- (void)removeObjectsCaches {
    NSUserDefaults *userDefatluts = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [userDefatluts dictionaryRepresentation];
    for(NSString *key in [dictionary allKeys]) {
        if ([key hasPrefix:__itCacheObjectManager]) {
            [self removeObjectForKey:key];
        }
    }
}
- (void)cleanAllObjectsCaches {
    [NSUserDefaults resetStandardUserDefaults];
}

@end
