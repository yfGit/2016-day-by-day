//
//  main.m
//  3. Category, NSCoding
//
//  Created by Wolf on 16/6/3.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "People+Associated.h"


#if TARGET_IPHONE_SIMULATOR
#import <objc/objc-runtime.h>
#else
#import <objc/runtime.h>
#import <objc/message.h>
#endif



int main(int argc, char * argv[]) {
    @autoreleasepool {

        People *cangTeacher = [[People alloc] init];
        cangTeacher.name = @"苍井空";
        cangTeacher.age = 18;
        [cangTeacher setValue:@"老师" forKey:@"occupation"];

        cangTeacher.associatedBust = @(90);

        __weak typeof(cangTeacher) weak = cangTeacher;
        cangTeacher.associatedCallBack = ^{
            NSLog(@"%d%@%@开工了, 男主是你, 快上!!!",weak.age, weak.name, [weak valueForKey:@"occupation"]);
        };
        cangTeacher.associatedCallBack();

        cangTeacher.polygonType = PolygonTypeSix;
        NSLog(@"%ld",cangTeacher.polygonType);

        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
    
    
}
