//
//  NSArray+Overstep.m
//  extra-1. 交换方法, 越界不Crash
//
//  Created by Wolf on 16/6/3.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import "NSArray+Overstep.h"
#import "NSObject+ErrorHandle.h"
#import <objc/runtime.h>

@implementation NSArray (Overstep)



/**
 *  不知道为什么转到 NSObject 有问题
 */
+ (void)load
{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

//        [self exchangOriginClass:@"__NSArrayI" originSel:@selector(objectForKey:) targetSel:@selector(yfObjectAtIndex:)];
        Method formMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
        Method toMethod   = class_getInstanceMethod([self class], @selector(yfObjectAtIndex:));

        method_exchangeImplementations(formMethod, toMethod);
    });
}


- (id)yfObjectAtIndex:(NSUInteger)index
{
    if (self.count < index) {
        @try {
            [self yfObjectAtIndex:index];
        } @catch (NSException *exception) {
            NSLog(@"============Crash============");
            NSLog(@"reason -> %@",[exception reason]);
            NSLog(@"============Crash============");
        } @finally {
            return nil;
        }
    }
    return [self yfObjectAtIndex:index];
}


@end
