//
//  ViewController.m
//  5. 判断, 动态增加方法
//
//  Created by Wolf on 16/6/1.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import "ViewController.h"

#import "Car.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


//    [[[Car alloc] init] sing];
//
//    Method methed = class_getClassMethod([Car class], @selector(class_sing));
//    method_setImplementation(methed, (IMP)function);
//
//    [Car class_sing];
}



void function(id self, SEL cmd) {
    NSLog(@"动态生成这个方法 => %@方法找不到", NSStringFromSelector(cmd));
}
@end
