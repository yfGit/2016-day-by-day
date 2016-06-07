//
//  People.m
//  JSON转Model
//
//  Created by Wolf on 16/6/1.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import "People.h"

#if TARGET_IPHONE_SIMULATOR
#import <objc/objc-runtime.h>
#else
#import <objc/runtime.h>
#import <objc/message.h>
#endif



@implementation People


- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];

    if (self) {

        for (NSString *key in dict.allKeys) {

            id value = dict[key];

            SEL setter = [self propertySetterByKey:key];
            if (setter) {
                ((void (*)(id, SEL, id))objc_msgSend)(self, setter, value);
            }
        }
    }

    return self;
}


- (SEL)propertySetterByKey:(NSString *)key
{
    // 注意 ':'
    NSString *name = [NSString stringWithFormat:@"set%@:",key.capitalizedString];
    SEL setter = NSSelectorFromString(name);
    if ([self respondsToSelector:setter]) {
        return setter;
    }

    return nil;
}


- (NSDictionary *)covertToDictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);

    if (count == 0) {
        free(properties);
        return nil;
    }

    for (NSUInteger i = 0; i < count; i++) {

        const char *name = property_getName(properties[i]);
        NSString *propertyName = [NSString stringWithUTF8String:name];

        SEL getter = [self propertyGetterByName:propertyName];
        if (getter) {

            id value = ((id (*)(id, SEL))objc_msgSend)(self, getter);
            if (value)
                dict[propertyName] = value;
            else
                dict[propertyName] = @"字典value不能为nil";
        }
    }
    free(properties);

    return dict;
}


- (SEL)propertyGetterByName:(NSString *)name
{
    SEL getter = NSSelectorFromString(name);
    if ([self respondsToSelector:getter]) {
        return getter;
    }

    return nil;
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"%@%@的%@%@开片了, 你是男主, 准备好了吗!!!", self.nationality, self.age, self.name, self.occupation];
}

@end
