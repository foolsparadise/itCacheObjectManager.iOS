# itCacheObjectManager  
iOS 本地缓存存储一些对象一些数组等  cache some object,array in..  
如缓存对象,对象要遵守NSCoding协议  
eg: NSObject <NSCoding>  
```  
@interface CLObject : NSObject <NSCoding>  
@property (nonatomic, strong) CLLocation *location;  
@property (nonatomic, strong) CLPlacemark *placeMark;  
@end  
@implementation CLObject  
- (instancetype)init {  
    if (self = [super init]) {  
    }  
    return self;  
}  
- (id)initWithCoder:(NSCoder *)aDecoder{  
    self = [super init];  
    if (self) {  
        self.location = [aDecoder decodeObjectForKey:@"location"];  
        self.placeMark = [aDecoder decodeObjectForKey:@"placeMark"];  
    }  
    return self;  
}  
- (void)encodeWithCoder:(NSCoder *)aCoder{  
    [aCoder encodeObject:self.location forKey:@"location"];  
    [aCoder encodeObject:self.placeMark forKey:@"placeMark"];  
}  
@end  
```  
### Usage:  
import itCacheObjectManagerDemo.h  
get and save obj Demo  
```  
get..  
CLObject *obj = [itCacheObjectManagerDemo getObjectCacheForKey:@"CllLastone"];  
if(obj) {  
 NSLog(@"%@", [NSString stringWithFormat:@"%@\n%@", obj.placeMark.name, obj.placeMark.thoroughfare]);  
}  
save..  
CLObject *obj = [CLObject new];  
obj.location = location.copy;  
obj.placeMark = placeMark.copy;  
[itCacheObjectManagerDemo setObjectCache:obj forKey:@"CllLastone"];  
```  
get and save array Demo  
```  
get..  
NSMutableArray *objArrayHistory = [NSMutableArray new];  
NSArray *arr = [itCacheObjectManagerDemo getObjectCacheForKey:@"CllHistory"];  
if(arr.count>0)  
{  
    for (NSObject *arrObj in arr) {  
        [objArrayHistory addObject:arrObj];  
    }  
}  
save..  
CLObject *obj = [CLObject new];  
obj.location = location.copy;  
obj.placeMark = placeMark.copy;  
NSMutableArray *objArrayHistory = [NSMutableArray new];  
[objArrayHistory addObject:obj];  
[itCacheObjectManagerDemo setObjectCache:objArrayHistory.mutableCopy forKey:@"CllHistory"]; //加入历史记录  
```  
### Apache-2.0  
