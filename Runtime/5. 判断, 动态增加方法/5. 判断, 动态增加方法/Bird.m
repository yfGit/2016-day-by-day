//
//  Bird.m
//  5. 判断, 动态增加方法
//
//  Created by Wolf on 16/6/1.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import "Bird.h"
#import "Car.h"
#import <objc/runtime.h>

@implementation Bird




// 1. 是否动态添加方法 YES -> class_addMethod.  NO -> 2
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    return NO;
}

// 类方法不知道怎么实现
+ (BOOL)resolveClassMethod:(SEL)sel
{
    return NO;
}

// 2. 指定备选对象响应这个Selector, 不能为self.   nil -> 3
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return nil;
}


// 3. 方法签名, 如果返回nil, 消息无法处理. 返回 medthodSignatue -> 4
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if ([NSStringFromSelector(aSelector) isEqualToString:@"sing"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}


// 4. 修改实现方法, 修改响应对象等. '方法调用失败' -> 5
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    // 1️⃣ 修改响应对象
//    Car *car = [[Car alloc] init];
//    car.name = @"苍老师";
//    [anInvocation invokeWithTarget:car];

    // 2️⃣ 修改实现方法
    [anInvocation setSelector:@selector(dance)];
    [anInvocation invokeWithTarget:self];
}


// 5. '方法调用失败'时, 没有实现这个方法, 直接crash
- (void)doesNotRecognizeSelector:(SEL)aSelector
{
    NSLog(@"消息无法处理：%@", NSStringFromSelector(aSelector));
}

- (void)dance
{
    NSLog(@"%s",__func__);
}

@end
