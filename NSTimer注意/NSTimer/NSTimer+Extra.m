
//
//  NSTimer+Extra.m
//  NSTimer
//
//  Created by Wolf on 16/6/15.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import "NSTimer+Extra.h"

@implementation NSTimer (Extra)


+ (NSTimer *)ex_scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(id (^)())block repeats:(BOOL)repeats
{
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(ex_blockInvoke:)
                                       userInfo:block
                                        repeats:repeats];

    
}


+ (void)ex_blockInvoke:(NSTimer *)timer {

    id (^block)() = timer.userInfo;
    if (block) {
        id obj = block();
        if (!obj) { // 不写会发送信息给nil, 不会报错, 但是方法还是会一直调
            [timer invalidate];
            timer = nil;
        }
    }}

@end
