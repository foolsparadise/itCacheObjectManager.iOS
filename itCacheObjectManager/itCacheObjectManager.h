//
//  itCacheObjectManager.h
//  NULL
//
//  Created by foolsparadise on 12/12/2019.
//  Copyright © 2019 github.com/foolsparadise. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface itCacheObjectManager : NSObject

- (BOOL)hasObjectCacheForKey:(id)key;

- (id)getObjectCacheForKey:(NSString *)key;
- (void)setObjectCache:(id)value forKey:(NSString *)key;

- (id)isObjectCacheExpiredForKey:(NSString *)key;

- (void)setBool:(BOOL)value forKey:(NSString *)key;
- (BOOL)getBoolForKey:(NSString *)key;

- (void)removeObjectCacheForKey:(NSString *)key;
- (void)removeObjectsCaches;
- (void)cleanAllObjectsCaches;

@end

NS_ASSUME_NONNULL_END
