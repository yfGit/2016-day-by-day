
//
//  UIButton+Extra.m
//  HookTouch
//
//  Created by Wolf on 16/6/12.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import "UIButton+Extra.h"
#import <objc/runtime.h>

@implementation UIButton (Extra)

+ (void)load
{
    [super load];

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        Method origin = class_getInstanceMethod([UIButton class], @selector(touchesBegan:withEvent:));
        Method target = class_getInstanceMethod([self class], @selector(cusTouchesBegan:withEvent:));
        method_exchangeImplementations(origin, target);
    });

}

- (void)cusTouchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    // 判断网络
    NSLog(@"1111111111111");
    if (1) {
        [self cusTouchesBegan:touches withEvent:event];
    }
}
@end
