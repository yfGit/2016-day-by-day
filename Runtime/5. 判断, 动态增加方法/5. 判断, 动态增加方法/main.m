//
//  main.m
//  5. 判断, 动态增加方法
//
//  Created by Wolf on 16/6/1.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "Car.h"
#import "Bird.h"
#import <objc/runtime.h>
#import <objc/message.h>

int main(int argc, char * argv[]) {
    @autoreleasepool {

        [[[Car alloc] init] sing];

        [Car class_sing];

        Bird *bird = [[Bird alloc] init];
        bird.name  = @"小小鸟";

        ((void (*)(id, SEL))objc_msgSend)((id)bird, @selector(sing));



        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

