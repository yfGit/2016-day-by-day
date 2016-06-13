//
//  People.h
//  2. 获取属性, 成员变量, 方法
//
//  Created by Wolf on 16/5/31.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^Block)(id, NSString *, int);

@interface People : NSObject
{
    NSString *_profession;
    NSString *_address;
}

@property (nonatomic, copy  ) NSString   *name;
@property (nonatomic, assign) NSUInteger age;
@property (nonatomic, copy  ) Block      block;// 参数为Block

- (NSDictionary *)allProperties;
- (NSDictionary *)allIvars;
- (NSDictionary *)allMethods;


+ (NSDictionary *)Class_allMetshods;  // class_copyMethodList 找不到 \
                                         用 class_getClassMethod

@end
