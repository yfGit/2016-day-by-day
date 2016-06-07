//
//  NSObject+ErrorHandle.m
//  extra-1. 交换方法, 越界不Crash
//
//  Created by Wolf on 16/6/3.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import "NSObject+ErrorHandle.h"

#import <objc/runtime.h>

@implementation NSObject (ErrorHandle)

+ (void)exchangOriginClass:(NSString *)originClsStr originSel:(SEL)originSel targetSel:(SEL)targetSel
{
    Class originCls = NSClassFromString(originClsStr);
    Class targetCls = [self class];

    [self exchangOriginClass:originCls originSel:originSel targetClass:targetCls targetSel:targetSel];
}


+ (void)exchangOriginClass:(Class)originCls originSel:(SEL)originSel targetClass:(Class)targetCls targetSel:(SEL)targetSel
{
    if (!originCls || !originSel || !targetCls || !targetSel) return;

    Method originMethod = class_getInstanceMethod(originCls, originSel);
    Method targetMethod = class_getInstanceMethod(targetCls, targetSel);
    method_exchangeImplementations(originMethod, targetMethod);
}
@end
