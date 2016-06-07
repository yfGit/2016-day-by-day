//
//  main.m
//  1_创建类, 成员变量, 赋值, 发送消息
//
//  Created by Wolf on 16/6/3.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

#if TARGET_IPHONE_SIMULATOR
#import <objc/objc-runtime.h>
#else
#import <objc/runtime.h>
#import <objc/message.h>
#endif


// 最少两个参数 self, SEL
void sayFunction(id self, SEL _cmd, id some, int a) {

    // 为什么是 [self class]; 因为传进来的self
    //    NSLog(@"%@",[self class]); // -> People

    /**
     * 返回对象的指定实例变量的值
     *
     * @param obj   对象
     * @param ivar  实例变量
     */
    NSLog(@"%@岁的%@说：%@", object_getIvar(self, class_getInstanceVariable([self class], "_age")),[self valueForKey:@"name"], some);


}

int main(int argc, const char * argv[]) {
    @autoreleasepool {



        /* 动态创建类或元类, 与 'objc_registerClassPair' 配对
         objc_getMetaClass 可以得到元类
         */
        Class People = objc_allocateClassPair([NSObject class], "People", 0);

        /**
         *  添加实例变量
         *
         *  @param cls          不能是元类, 不支持
         *  @param name         "_name"
         *  @param size         sizeof(NSString *)
         *  @param alignment    log2(sizeof(NSString *))
         *  @param types        @encode(NSString *)
         *
         *  @return BOOL 可能已经存在
         */
        class_addIvar(People, "_name", sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));

        class_addIvar(People, "_age", sizeof(int), log2(sizeof(int)), @encode(int));


        // 注册方法   类, 还是对象方法根据绑定来决定
        // "say:" :  注册名, 只是标识符,有没有':'一样, 可读性
        SEL say = sel_registerName("say:");

#warning  super ???
        /*
         *  @param types   最少两个参数 self, SEL, 其它的可省略
         会覆盖父类的实现, 父类的实现不, [super ]???
         不会改变已有类的方法(如果已有retrun NO), method_setImplementation
         */
        class_addMethod(People, say, (IMP)sayFunction, "v@:@");


        // 所有属性方法添加完成之后才能调用
        objc_registerClassPair(People);


        // 创建实例
        id peopleInstance = [[People alloc] init];

        // 1. KVC 动态设置属性值
        [peopleInstance setValue:@"苍老师" forKey:@"_name"];

        // 2. 取出属性赋值
        // 得到实例变量
        Ivar ageIvar = class_getInstanceVariable(People, "_age");
        // 设置  'object_setIvar' 快于 'object_setInstanceVariable'
        object_setIvar(peopleInstance, ageIvar, @18);


        // 调用方法
        ((void (*)(id, SEL, id))objc_msgSend)(peopleInstance, say, @"大家好!");
        objc_msgSend(peopleInstance, say, @"晚上见!");
        // 报参数过多, Build Setting –> Apple LLVM 7.0 – Preprocessing –> Enable Strict Checking of objc_msgSend Calls 改为 NO

        // 销毁
        peopleInstance = nil;
        // 摧毁它和与它相关的元类
        // 如果它和它的子类的实例还存在, 不应该调用
        objc_disposeClassPair(People);
        
    }
    return 0;
}
