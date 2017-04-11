//
//  People+Associated.m
//  3. Category
//
//  Created by Wolf on 16/5/31.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import "People+Associated.h"


#if TARGET_IPHONE_SIMULATOR
#import <objc/objc-runtime.h>
#else
#import <objc/runtime.h>
#import <objc/message.h>
#endif

static const char associatedKey;

@implementation People (Associated)



/**
 * @param object  源对象
 * @param key     关键字, 一个对象可以添加多少关联, 一般定义 static const char, 可直接SEL
 * @param value   关联的对象
 * @param policy  关联的规则. 和 @propery类似, 赋值,保留引用,复制. 是否原子性
 *                OBJC_ASSOCIATION_RETAIN_NONATOMIC
 *
 * !!! 断开关联对象只要在 'value' 里设 nil 就行
 * !!! objc_removeAssociatedObjects(self) 断开所有self的关联, 需要 '恢复到原始状态' 时才会用
 */

//    http://blog.csdn.net/lengshengren/article/details/16886915/
//    http://blog.csdn.net/onlyou930/article/details/9299169

#pragma mark - NSNumber
- (void)setAssociatedBust:(NSNumber *)associatedBust
{
    objc_setAssociatedObject(self, &associatedKey, associatedBust, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

//    objc_setAssociatedObject(self, @selector(associatedBust), associatedBust, OBJC_ASSOCIATION_RETAIN_NONATOMIC);  // 属性方便都用@selector()
}

- (NSNumber *)associatedBust
{
    return objc_getAssociatedObject(self, &associatedKey);

//    objc_getAssociatedObject(self, _cmd);  // @selector(associatedBust)
}

#pragma mark - Block
- (void)setAssociatedCallBack:(CodingCallBack)associatedCallBack
{
    objc_setAssociatedObject(self, @selector(associatedCallBack), associatedCallBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CodingCallBack)associatedCallBack
{
    return objc_getAssociatedObject(self, _cmd); // 每个方法都有一个_cmd, 表示方法自身
}

#pragma mark - assign
- (void)setPolygonType:(PolygonType)polygonType
{
    objc_setAssociatedObject(self, @selector(polygonType), @(polygonType), OBJC_ASSOCIATION_ASSIGN);
}

- (PolygonType)polygonType
{
    NSNumber *num = objc_getAssociatedObject(self, _cmd);
    return [num intValue];
}

@end
