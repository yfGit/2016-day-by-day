//
//  NSObject+ErrorHandle.h
//  extra-1. 交换方法, 越界不Crash
//
//  Created by Wolf on 16/6/3.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ErrorHandle)


+ (void)exchangOriginClass:(NSString *)originClsStr originSel:(SEL)originSel targetSel:(SEL)targetSel;


@end
