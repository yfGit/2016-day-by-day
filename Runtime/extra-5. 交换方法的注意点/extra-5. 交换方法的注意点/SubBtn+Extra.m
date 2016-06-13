//
//  SubBtn+Extra.m
//  交换方法问题
//
//  Created by Wolf on 16/6/13.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import "SubBtn+Extra.h"
#import <objc/runtime.h>
@implementation SubBtn (Extra)


//+ (void)load
//{
//    [super load];
//    // 如果子类没有实现, 会找到父类的方法, 那么直接交换也会是把父类也交换了
//    Method origin = class_getInstanceMethod(self, @selector(des_name));
//    Method target = class_getInstanceMethod(self, @selector(cusDes_name));
//
//    class_addMethod(self, @selector(des_name), method_getImplementation(target), method_getTypeEncoding(target))
//    method_exchangeImplementations(origin, target);
//}

+ (void)load
{
    [super load]; // 父类会再调用一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 如果子类没有实现, 会isa找到父类的方法, 那么直接交换也会是把父类也交换了
        Method origin = class_getInstanceMethod(self, @selector(des_name));
        Method target = class_getInstanceMethod(self, @selector(cusDes_name));

        BOOL isSuccess = class_addMethod(self, @selector(des_name), method_getImplementation(target), method_getTypeEncoding(target));
        if (isSuccess) {
            NSLog(@"isSuccess"); //replaceMethod 本身会class_addMethod method_setImplementation
            // 实现这个可以再调父类的, 这样可以和exchange 合用
            class_replaceMethod(self, @selector(cusDes_name), method_getImplementation(origin), method_getTypeEncoding(origin));
        }else {
            method_exchangeImplementations(origin, target);
        }
    });
}


- (void)cusDes_name
{
    NSLog(@"11111");
    [self cusDes_name];
}

@end