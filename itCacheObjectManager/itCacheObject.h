//
//  itCacheObject.h
//  NULL
//
//  Created by foolsparadise on 12/12/2019.
//  Copyright © 2019 github.com/foolsparadise. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface itCacheObject : NSObject <NSCoding>

//缓存key
@property (nonatomic, strong) NSString *key;
//缓存数据
@property (nonatomic, strong) id data;
//缓存数据时的时间
@property (nonatomic, strong) NSString *time;

//缓存是否过期
- (BOOL)isExpired;

@end

NS_ASSUME_NONNULL_END
