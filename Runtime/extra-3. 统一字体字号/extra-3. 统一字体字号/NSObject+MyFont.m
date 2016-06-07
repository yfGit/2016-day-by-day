//
//  NSObject+MyFont.m
//  extra-3. 统一字体字号
//
//  Created by Wolf on 16/6/6.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import "NSObject+MyFont.h"
#import <objc/runtime.h>
@implementation NSObject (MyFont)

@end
@implementation UIButton (MyFont)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        Method btnOrigin = class_getInstanceMethod([self class], @selector(initWithCoder:));
        Method btnTarget = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
        method_exchangeImplementations(btnOrigin, btnTarget);

        Method btnOrigin2 = class_getInstanceMethod([self class], @selector(initWithFrame:));
        Method btnTarget2 = class_getInstanceMethod([self class], @selector(myInitWithFrame:));
        method_exchangeImplementations(btnOrigin2, btnTarget2);
    });
}

- (id)myInitWithFrame:(CGRect)frame {
    [self myInitWithFrame:frame];
    if (self) {
        CGFloat fontSize     = self.titleLabel.font.pointSize;
        self.titleLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:fontSize];
    }
    return self;
}

- (id)myInitWithCoder:(NSCoder*)aDecode
{
    [self myInitWithCoder:aDecode];
    if (self) {
        CGFloat fontSize     = self.titleLabel.font.pointSize;
        self.titleLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:fontSize];
    }
    return self;
}
@end

@implementation UILabel (myFont)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        Method labelOrigin = class_getInstanceMethod([self class], @selector(initWithCoder:));
        Method labelTarget = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
        method_exchangeImplementations(labelOrigin, labelTarget);

        Method labelOrigin2 = class_getInstanceMethod([self class], @selector(initWithFrame:));
        Method labelTarget2 = class_getInstanceMethod([self class], @selector(myInitWithFrame:));
        method_exchangeImplementations(labelOrigin2, labelTarget2);
    });
}

- (id)myInitWithFrame:(CGRect)frame {
    [self myInitWithFrame:frame];
    if (self) {
        CGFloat fontSize = self.font.pointSize;
        self.font        = [UIFont fontWithName:@"MicrosoftYaHei" size:fontSize];
    }
    return self;
}

- (id)myInitWithCoder:(NSCoder*)aDecode
{
    [self myInitWithCoder:aDecode];
    if (self) {
        CGFloat fontSize = self.font.pointSize;
        self.font        = [UIFont fontWithName:@"MicrosoftYaHei" size:fontSize];
    }
    return self;
}

@end
