//
//  NSMutableArray+Overstep.m
//  extra-1. 交换方法, 越界不Crash
//
//  Created by Wolf on 16/6/3.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import "NSMutableArray+Overstep.h"
#import "NSObject+ErrorHandle.h"
#import <objc/runtime.h>

@implementation NSMutableArray (Overstep)

+ (void)load
{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

//        [self exchangOriginClass:@"__NSArrayM" originSel:@selector(objectAtIndex:) targetSel:@selector(yfObjectAtIndex:)];
        Method formMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
        Method toMethod   = class_getInstanceMethod([self class], @selector(yfMObjectAtIndex:));

        method_exchangeImplementations(formMethod, toMethod);

    });
}


- (id)yfMObjectAtIndex:(NSUInteger)index
{
    if (index >= self.count) {
        @try {
            [self yfMObjectAtIndex:index];
        } @catch (NSException *exception) {
            NSLog(@"============Crash============");
            NSLog(@"reason -> %@",[exception reason]);
            NSLog(@"============Crash============");
        } @finally {
            return nil;
        }
    }
    return [self yfMObjectAtIndex:index];
}


@end
