//
//  MyTextField.m
//  TextFeildDelegate
//
//  Created by Wolf on 16/6/3.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import "MyTextField.h"
#import <objc/runtime.h>

@interface MyTextField ()

@property (nonatomic, assign) BOOL isExchange;

@end

@implementation MyTextField



- (void)setDelegate:(id<UITextFieldDelegate>)delegate
{
    [super setDelegate:delegate];

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originMethod = class_getInstanceMethod([delegate class], @selector(textFieldShouldReturn:));
        Method targetMethod = class_getInstanceMethod([MyTextField class], @selector(customTextFieldShouldReturn:));
        method_exchangeImplementations(originMethod, targetMethod);
    });
}


- (BOOL)customTextFieldShouldReturn:(UITextField *)textField
{
    if ([textField isKindOfClass:[MyTextField class]]) {

        NSLog(@"custom");
        return [(MyTextField *)textField customTextFieldShouldReturn:textField];
    }else {
#warning  !!!! 没有达到需求
        NSLog(@"system");
        // !!! 不能直接写YES, 外壳调不到方法, 父类调不到子类方法
        return YES;
    }
}




@end
