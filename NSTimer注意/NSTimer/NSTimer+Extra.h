//
//  NSTimer+Extra.h
//  NSTimer
//
//  Created by Wolf on 16/6/15.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Extra)

// 自动释放NSTimer, 不用 [timer invalidate];
+ (NSTimer *)ex_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(id (^)())block
                                       repeats:(BOOL)repeats;

@end
