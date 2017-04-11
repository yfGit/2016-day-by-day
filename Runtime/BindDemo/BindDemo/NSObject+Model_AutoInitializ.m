//
//  NSObject+Model_AutoInitializ.m
//  BindDemo
//
//  Created by Vincent on 2017/3/15.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "NSObject+Model_AutoInitializ.h"
#import <objc/runtime.h>

@implementation NSObject (Model_AutoInitializ)


/**
 判断哪些类是自定义类
 
 @param className 需要验证的类型
 @return NO: 自定义类
 */
- (BOOL)isFundationClass:(NSString *)className
{
    // 自由添加
    if ([className isEqualToString:@"NSString"] ||
        [className isEqualToString:@"Int"]) {
        return YES;
    }
    return NO;
}

- (void)initializeModelProperty
{
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (NSUInteger i = 0; i < count; i++) {
        
        objc_property_t property = properties[i];
        const char *attribute = property_getAttributes(property);
        
        NSArray *component = [[NSString stringWithCString:attribute encoding:NSUTF8StringEncoding] componentsSeparatedByString:@","];
        NSString *firstType = component.firstObject;
        NSString *lastType  = component.lastObject;
        
        if ([firstType hasPrefix:@"T@"]) { // 类型
            NSString *className = [firstType substringWithRange:NSMakeRange(3, firstType.length-4)];
            if (![self isFundationClass:className]) { // 自定义类型
                if ([lastType hasPrefix:@"V"]) {
                    // _属性
                    NSString *setter = [lastType substringWithRange:NSMakeRange(1, lastType.length-1)];
                    // 自定义类
                    Class cls = NSClassFromString(className);
                    // 赋值
                    id subject = [[cls alloc] init];
                    [self setValue:subject  forKey:setter];
                    // 递归
                    [subject initializeModelProperty];
                }
            }
        }
    }
    
    free(properties);
}



@end
