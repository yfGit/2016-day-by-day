
//
//  People.m
//  2. 获取属性, 成员变量, 方法
//
//  Created by Wolf on 16/5/31.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import "People.h"

#if TARGET_IPHONE_SIMULATOR
#import <objc/objc-runtime.h>
#else
#import <objc/runtime.h>
#import <objc/message.h>
#endif

@interface People ()
{
    NSString *_dogName;
}

@property (nonatomic, copy) NSString *dog;

@end


@implementation People

#warning    1. 属性类型解析 \
            2. block

// 属性名, 类型
- (NSDictionary *)allProperties
{
    unsigned int count = 0;

    // 获取属性, 不包括父类的, 返回为数组.
    // 最后必须 'free()', 是一个数组指针
    objc_property_t *properties = class_copyPropertyList([self class], &count);

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (NSUInteger i = 0; i < count; i++) {

        objc_property_t property = properties[i];
        const char *name         = property_getName(property);
        NSString *propertyName   = [NSString stringWithUTF8String:name];
        const char *value        = property_getAttributes(property);
        NSString *propertyValue  = [NSString stringWithUTF8String:value];
        // kvc 获值
//        id value = [self valueForKey:propertyName];

        if (value)
            dict[propertyName] = propertyValue;
        else
            NSLog(@"-->> 字典 value 不能为nil");
    }

    return [dict copy];
}


// 实例变量名, 类型
/* Type Encodings
        https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1
 */
- (NSDictionary *)allIvars
{
    unsigned int count;
    Ivar *ivars = class_copyIvarList([self class], &count);

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (NSUInteger i = 0; i < count; i++) {

        Ivar ivar           = ivars[i];
        const char *name    = ivar_getName(ivar);
        NSString *ivarName  = [NSString stringWithUTF8String:name];
        const char *value   = ivar_getTypeEncoding(ivar);
        NSString *ivarValue = [NSString stringWithUTF8String:value];

        if (ivarValue)
            dict[ivarName] = ivarValue;
        else
            NSLog(@"-->> 字典 value 不能为nil");
    }
    free(ivars);

    return [dict copy];
}


// 方法名, 参数数量
- (NSDictionary *)allMethods
{
    unsigned int count;
    Method *methods = class_copyMethodList([self class], &count);

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (NSUInteger i = 0; i < count; i++) {

        Method method     = methods[i];
        SEL methodSEL     = method_getName(method);
        const char *name  = sel_getName(methodSEL);
        NSString *selName = [NSString stringWithUTF8String:name];

        unsigned int arguments = method_getNumberOfArguments(method);

#warning  arguments-2
        dict[selName] = @(arguments-2); // ??? 排除了 id self, SEL ???
    }
    free(methods);

    return [dict copy];
}

@end
