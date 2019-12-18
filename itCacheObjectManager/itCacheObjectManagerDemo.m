//
//  itCacheObjectManagerDemo.m
//  NULL
//
//  Created by foolsparadise on 12/12/2019.
//  Copyright © 2019 github.com/foolsparadise. All rights reserved.
//
#import "itCacheObjectManagerDemo.h"

#import "itCacheObjectManager.h"

@interface itCacheObjectManagerDemo()

+ (instancetype)shareInstance;

@property(nonatomic,strong)itCacheObjectManager *manager;

@end

@implementation itCacheObjectManagerDemo
- (itCacheObjectManager *)manager
{
    dispatch_semaphore_t se = dispatch_semaphore_create(1);
    dispatch_semaphore_wait(se, DISPATCH_TIME_FOREVER);
    if (_manager == nil) {
        _manager = [[itCacheObjectManager alloc] init];
    }
    dispatch_semaphore_signal(se);
    return _manager;
}
static itCacheObjectManagerDemo *_instance = nil;
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    }) ;
    
    return _instance;
}
#pragma mark function

+ (BOOL)hasObjectCacheForKey:(id)key
{
    return [[itCacheObjectManagerDemo shareInstance].manager hasObjectCacheForKey:key];
}

+ (id)getObjectCacheForKey:(NSString *)key
{
    return [[itCacheObjectManagerDemo shareInstance].manager getObjectCacheForKey:key];
}
+ (void)setObjectCache:(id)value forKey:(NSString *)key
{
    return [[itCacheObjectManagerDemo shareInstance].manager setObjectCache:value forKey:key];
}

+ (id)isObjectCacheExpiredForKey:(NSString *)key
{
    return [[itCacheObjectManagerDemo shareInstance].manager isObjectCacheExpiredForKey:key];
}

+ (void)setBool:(BOOL)value forKey:(NSString *)key
{
    return [[itCacheObjectManagerDemo shareInstance].manager setBool:value forKey:key];
}
+ (BOOL)getBoolForKey:(NSString *)key
{
    return [[itCacheObjectManagerDemo shareInstance].manager getBoolForKey:key];
}

+ (void)removeObjectCacheForKey:(NSString *)key
{
    return [[itCacheObjectManagerDemo shareInstance].manager removeObjectCacheForKey:key];
}
+ (void)removeObjectsCaches
{
    return [[itCacheObjectManagerDemo shareInstance].manager removeObjectsCaches];
}
+ (void)cleanAllObjectsCaches
{
    return [[itCacheObjectManagerDemo shareInstance].manager cleanAllObjectsCaches];
}

@end
