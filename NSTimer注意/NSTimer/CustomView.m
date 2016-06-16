//
//  CustomView.m
//  NSTimer
//
//  Created by Wolf on 16/6/16.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import "CustomView.h"
#import "NSTimer+Extra.h"

@implementation CustomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        __weak typeof(self) weakSelf = self;
        [NSTimer ex_scheduledTimerWithTimeInterval:2 block:^id{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf start];
            return strongSelf;
        } repeats:YES];
    }
    return self;
}

- (void)start
{
    NSLog(@"%s",__func__);
}
- (void)dealloc
{
    NSLog(@"%s",__func__);
}
@end
