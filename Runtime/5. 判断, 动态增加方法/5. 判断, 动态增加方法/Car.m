//
//  Car.m
//  5. 判断, 动态增加方法
//
//  Created by Wolf on 16/6/1.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import "Car.h"

#if TARGET_IPHONE_SIMULATOR
#import <objc/objc-runtime.h>
#else
#import <objc/runtime.h>
#import <objc/message.h>
#endif

@implementation Car


/* Type Encodings
 https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1
*/

// 类方法不知道怎么实现
//+ (BOOL)resolveClassMethod:(SEL)sel
//{
//    if (![super resolveClassMethod:sel]) {
//NSLog(@"%@",NSStringFromSelector(sel));
//        class_addMethod(self, sel, (IMP)function2, "#v@:");
//        return YES;
//    }
//    return [super resolveClassMethod:sel];
//}



// 动态生成实例方法
+ (BOOL)resolveInstanceMethod:(SEL)sel {

    if (![super resolveInstanceMethod:sel]) {  // 找不到方法

        class_addMethod(self, sel, (IMP)function2, "v@:");
        return YES;
    }

    return [super resolveInstanceMethod:sel];
}

void function2(id self, SEL cmd) {
    NSLog(@"动态生成这个方法 => %@方法找不到", NSStringFromSelector(cmd));
}


void function3(id self, SEL cmd, Class cls) {
    NSLog(@"动态生成这个方法 => %@方法找不到", NSStringFromSelector(cmd));
}

@end
