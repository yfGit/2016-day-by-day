
//
//  People.m
//  3. Category
//
//  Created by Wolf on 16/5/31.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import "People.h"

#if TARGET_IPHONE_SIMULATOR
#import <objc/objc-runtime.h>
#else
#import <objc/runtime.h>
#endif



@implementation People

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);

    for (NSUInteger i = 0; i < count; i++) {

        const char *name = ivar_getName(ivars[i]);
        NSString *key    = [NSString stringWithUTF8String:name];

        id value         = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(ivars);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    // 如果父类遵守了<NSCoding>, 'self = [super initWithCoder:aDecoder]'
    self = [super init];

    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);

    for (NSUInteger i = 0; i < count; i++) {

        const char *name = ivar_getName(ivars[i]);
        NSString *key    = [NSString stringWithUTF8String:name];

        id value         = [aDecoder decodeObjectForKey:key];
        [self setValue:value forKey:key];
    }
    free(ivars);

    return self;
}

@end
