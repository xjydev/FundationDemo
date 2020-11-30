//
//  OCSonObj.m
//  FundationDemo
//
//  Created by jingyuan5 on 2020/11/26.
//

#import "OCSonObj.h"

@implementation OCSonObj

+ (BOOL)resolveClassMethod:(SEL)sel {
    NSLog(@" == %s",__func__);
    return NO;
}
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@" == %s",__func__);
    return NO;
}
- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@" == %s",__func__);
    return self.class;
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSLog(@" == %s",__func__);
    if ([self.forwardObj respondsToSelector:aSelector]) {
        return [self.forwardObj methodSignatureForSelector:aSelector];
    }
    return nil;
}
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@" == %s",__func__);
    [anInvocation invokeWithTarget:self.forwardObj];
}
@end
