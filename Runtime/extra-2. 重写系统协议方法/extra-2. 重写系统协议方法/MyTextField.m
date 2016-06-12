//
//  MyTextField.m
//  TextFeildDelegate
//
//  Created by Wolf on 16/6/3.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import "MyTextField.h"
#import <objc/runtime.h>

@interface UITextField (ReturnKeyClick) <UITextFieldDelegate>

- (BOOL)returnKeyClick:(UITextField *)textField;

@end

@implementation UITextField (ReturnKeyClick)

- (BOOL)returnKeyClick:(UITextField *)textField
{
    if ([textField isKindOfClass:[MyTextField class]])
    {
        MyTextField *myField = (MyTextField *)textField;
        if (myField.searchCallback)
        {
            myField.searchCallback(textField.text);
        }
    }
    return [textField returnKeyClick:textField];
}

@end

@interface MyTextField () <UITextFieldDelegate>

@property (nonatomic, assign) id<UITextFieldDelegate> keepDelegate;
@end

@implementation MyTextField

- (void)setDelegate:(id<UITextFieldDelegate>)delegate
{
    // 设置自己为自己的delegate, 方法已经交换了, 但还是调交换前的系统协议方法
    [super setDelegate:delegate];

    if ([self isKindOfClass:[MyTextField class]] && delegate != self)
    {
        // 如果当前textField是MyTextField对象并且delegate != self时，交换方法实现
        SEL selector = @selector(textFieldShouldReturn:);
        if ([delegate respondsToSelector:selector])
        {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{

                Method origin = class_getInstanceMethod([self.delegate class],selector);
                Method target = class_getInstanceMethod([self class], @selector(returnKeyClick:));
                method_exchangeImplementations(origin, target);
            });
        }
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{

    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.searchCallback)
        self.searchCallback(textField.text);

    return YES;
}




@end
