//
//  NSObject+Model_AutoInitializ.h
//  BindDemo
//
//  Created by Vincent on 2017/3/15.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Model_AutoInitializ)


/**
  初始化Model属性中的嵌套自定义类: 找到自定义类-初始化-递归
  嵌套多用继承的话所以Model都得继承, 用category只要根Model初始化里调用就行了
 */
- (void)initializeModelProperty;

@end
